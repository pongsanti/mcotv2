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

  def name_suffix(suffix)
    String.new(@filename).insert(@filename.index('.'), suffix)
  end

  def path_suffix(suffix)
    "#{FILE_PATH}/#{name_suffix(suffix)}"
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
