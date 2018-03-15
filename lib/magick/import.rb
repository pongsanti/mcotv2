require 'file/file_op'

class Import
  #import -window $WINDOW_ID -resize $RESIZE_ARG ${FILE_PATH}/${IMG_NAME}
  WINDOW_ID = ENV['WINDOW_ID']
  W = ENV['IMP_WIDTH']
  H = ENV['IMP_HEIGHT']

  def initialize(window_id = nil, width = nil, height = nil, filename = nil)
    @window_id = window_id || WINDOW_ID
    @width = width || W
    @height = height || H
    @filename = filename || FileOp.current_filename
  end

  def import
    LOG.info "Import to #{filepath}" if LOG
    %x[import -window #{@window_id} -resize #{resize_arg} #{filepath}]
  end

  def resize_arg
    "#{@width}x#{@height}"
  end

  def filepath
    FileOp.new(@filename).path
  end
end