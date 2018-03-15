# file operation class
class FileOp
  FILE_EXT = ENV['FILE_EXT']
  FILE_PATH = ENV['FILE_PATH']

  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def path
    "#{FILE_PATH}/#{@filename}"
  end

  def name_suffix(suffix)
    FileOp.new(put_suffix(suffix))
  end

  def delete()
    LOG.info "Deleting file #{path}"
    File.delete(path)
  rescue StandardError => err
    puts err
    false
  end

  private
  def put_suffix(suffix)
    String.new(@filename).insert(@filename.index('.'), suffix)
  end

  class << self
    def current_filename
      "#{Time.now.strftime('%Y-%m-%d-T-%H:%M:%S')}.#{FILE_EXT}"
    end
  end
end
