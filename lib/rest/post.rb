require 'rest_client'
require 'file/file_op'
# Post multipart form data
class Post
  URL = ENV['POST_URL']
  
  def initialize(value, filename)
    @value = value
    @file_op = FileOp.new(filename)
    @cropfile_op = @file_op.name_suffix('_c')
  end

  def post
    success = true

    begin
      RestClient.post(URL,
        article: { text: @value,
                   file: File.new(@file_op.path, 'rb'),
                   crop_file: File.new(@cropfile_op.path, 'rb') }
      )
      LOG.info "Posted to the server."
    rescue StandardError => err
      puts err
      success = false
    end
    success
  end
end
