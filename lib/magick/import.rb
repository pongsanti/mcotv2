require 'file/file_op'
# Import operation
# import -window $WINDOW_ID -resize $RESIZE_ARG ${FILE_PATH}/${IMG_NAME}
class Import
  WINDOW_ID = ENV['WINDOW_ID']
  W = ENV['IMP_WIDTH']
  H = ENV['IMP_HEIGHT']

  def initialize(window_id = nil, width = nil, height = nil, filename = nil)
    @window_id = window_id || WINDOW_ID
    @width = width || W
    @height = height || H
    @filename = filename || FileOp.current_filename
    
    @fileop = FileOp.new(@filename)
  end

  def import
    LOG.info "Import to #{filepath}" if LOG
    `import -window #{@window_id} -resize #{resize_arg} #{filepath}`
    # put date into image
    `convert #{filepath} -fill white -undercolor '#00000080' -gravity SouthEast -annotate +0+5 "$(date)" #{filepath}`
    @fileop
  end

  def resize_arg
    "#{@width}x#{@height}"
  end

  def filepath
    @fileop.path
  end
end
