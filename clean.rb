require 'dotenv/load'
require 'logger'

LOG = Logger.new('clean.log', 10, 1_024_000)

FILE_PATH = ENV['FILE_PATH']
FILE_EXT = ENV['FILE_EXT']

def remove_by_prefix(prefix)
  path = "#{FILE_PATH}/#{prefix}*.#{FILE_EXT}"
  LOG.info "Deleting files: #{path}"
  `rm #{FILE_PATH}/#{prefix}*.#{FILE_EXT}`
  LOG.info "Done."
end

def get_prefix(past_day)
  today = Time.new
  past = today - day_in_ms(past_day)
  past.strftime('%Y-%m-%d')
end

def day_in_ms(day)
  day * (60 * 60 * 24)
end

remove_by_prefix(get_prefix(5))
remove_by_prefix(get_prefix(4))
remove_by_prefix(get_prefix(3))