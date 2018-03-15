# convert op
class Convert
  OUT_FILE_SUFFIX = '_f'.freeze
  # convert ${FILE_PATH}/${IMG_NAME} -crop $CROP_GEO -colorspace gray -lat 10x10+5% -negate ${FILE_PATH}/${CROP_FILENAME}
  def initialize(hash)
    @width = hash[:w] || 0
    @height = hash[:h] || 0

    @width_offset = hash[:wo] || 0
    @height_offset = hash[:ho].to_i || 0
    @bottom_offset = hash[:bo].to_i || 0

    @in_filename = hash[:in_filename]

    @fileop = FileOp.new(@in_filename)
    @out_file = @fileop.path_suffix(OUT_FILE_SUFFIX)
    @height_offset -= @bottom_offset
  end

  def convert
    
    LOG.info "Convert to #{@out_file}"
    `convert #{@fileop.path} -crop #{geometry} -colorspace gray -lat 10x10+5% -negate #{@out_file}`
    @fileop.name_suffix(OUT_FILE_SUFFIX)
  end

  def geometry
    "#{@width}x#{@height}+#{@width_offset}+#{@height_offset}"
  end

  def white?
    w = `convert #{@out_file} -threshold 65534 -format "%[fx:100*image.mean]" info:`
    w.strip.to_i > 85
  end
end
