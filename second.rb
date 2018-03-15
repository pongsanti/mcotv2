require 'dotenv/load'
require 'logger'

require_relative 'load_path'
require 'db/connection'
require 'file/file_op'
require 'magick/convert'
require 'tesseract/ocr'
require 'post_process/group_processor'
require 'post_process/post_processor'
require 'rest/post'

LOG = Logger.new(STDOUT)

S_C_W = ENV['S_C_W']
F_C_H = ENV['F_C_H']
F_C_WO = ENV['F_C_WO']
F_C_HO = ENV['F_C_HO']
C_BOT_OFF = ENV['C_BOT_OFF']

SET_MATCHER = Regexp.new(ENV['SET_MATCHER'])
SET50_MATCHER = Regexp.new(ENV['SET50_MATCHER'])

SET = 'SET'.freeze
SET50 = 'SET50'.freeze
NOMATCH = 'NOMATCH'.freeze

def batch_process(fs)
  f = GroupProcessor.new(fs).process
  f.normalized = PostProcessor.new(f.ocr).normalize
  f
end

def post(value, filename)
  Post.new(value, filename).post
end

def update_posted(f)
  f.posted = true
  f.save
end

def update_flag(fs)
  fs.each do |f|
    update_posted(f)
  end
end

loop do
  last_match = nil
  current_match = nil
  fs = []

  First.not_posted.all do |f|
    fop = FileOp.new(f.filename)
    # crop
    LOG.info "Cropping image: #{fop.path}"
    c = Convert.new(w: S_C_W, h: F_C_H,
                    wo: F_C_WO, ho: F_C_HO,
                    bo: C_BOT_OFF,
                    in_filename: fop.filename)
    crop_fop = c.convert

    # ocr
    text = Ocr.new(crop_fop).parse
    if SET_MATCHER =~ text
      LOG.info 'match SET!!'
      f.ocr = text
      fs << f
      current_match = SET
    elsif SET50_MATCHER =~ text
      LOG.info 'match SET50!!'
      f.ocr = text
      fs << f
      current_match = SET50
    else
      current_match = NOMATCH
      update_posted(f)
    end

    last_match_change = last_match && last_match != current_match && last_match != NOMATCH
    if last_match_change
      LOG.info 'processing batch...'
      f = batch_process(fs)
      post(f.normalized, f.filename) && update_flag(fs)
      LOG.info 'processing batch done.'
      fs = []
    end

    last_match = current_match
  end

  batch_process(fs) unless fs.empty?

  puts '--'
  sleep 2
end
