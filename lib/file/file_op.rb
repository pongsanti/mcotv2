# file operation class
class FileOp
  FILE_EXT = ENV['FILE_EXT']
  FILE_PATH = ENV['FILE_PATH']

  def initialize(filename)
    @filename = filename
  end

  def path
    "#{FILE_PATH}/#{@filename}"
  end

  def crop_path
    String.new(path).insert(path.index('.'), '_c')
  end

  def delete
    File.delete(path)
    File.delete(crop_path)
  rescue StandardError => err
    puts err
    false
  end

  class << self
    def current_filename
      "#{Time.now.strftime('%Y-%m-%d-T-%H:%M:%S')}.#{FILE_EXT}"
    end
  end
end
