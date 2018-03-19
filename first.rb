require 'dotenv/load'
require 'logger'

require_relative 'load_path'
require 'db/connection'
require 'file/file_op'
require 'magick/import'
require 'magick/convert'
require 'tesseract/ocr'

LOG = Logger.new('first.log', 10, 1_024_000)

WINDOW_ID = `cat windowid/vlcwindow.id`.strip
LOG.info '---'
LOG.info "Window ID: #{WINDOW_ID}"

F_C_W = ENV['F_C_W']
F_C_H = ENV['F_C_H']
F_C_WO = ENV['F_C_WO']
F_C_HO = ENV['F_C_HO']
C_BOT_OFF = ENV['C_BOT_OFF']
F_C_Regex = Regexp.new(ENV['F_C_MATCHER'])

begin
  loop do
    # capture
    origin_fop = Import.new.import
    # crop
    c = Convert.new(w: F_C_W, h: F_C_H,
                    wo: F_C_WO, ho: F_C_HO,
                    bo: C_BOT_OFF, suffix: '_f',
                    in_filename: origin_fop.filename)
    crop_fop = c.convert

    if c.white? # image white
      origin_fop.delete
    else
      text = Ocr.new(crop_fop).parse
      if F_C_Regex =~ text
        LOG.info 'Orc matched. Create a record in db'
        First.create(filename: origin_fop.filename)
      else
        LOG.info 'Ocr not matched. Delete files'
        origin_fop.delete
      end
    end

    crop_fop.delete
    LOG.info '--'

    sleep 0.5
  end
rescue SignalException => e
  LOG.info e
  LOG.info('Terminating...')
  raise e
end