require 'rest_client'
require 'file/file_op'
# Post multipart form data
class Post
  URL = ENV['POST_URL']
  
  def initialize(value, filepath, cropfilepath)
    @value = value
    @filepath = filepath
    @cropfilepath = cropfilepath
  end

  def post
    success = true

    begin
      RestClient.post(URL,
        article: { text: @value,
                   file: File.new(@filepath, 'rb'),
                   crop_file: File.new(@cropfilepath, 'rb') }
      )
      LOG.info "Posted to the server."
    rescue StandardError => err
      puts err
      success = false
    end
    success
  end
end
