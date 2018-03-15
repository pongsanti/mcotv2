require 'file/file_op'
# ocr op
class Ocr
  def initialize(filename)
    @filename = filename
    @fileop = FileOp.new(filename)
  end

  def parse
    LOG.info "Parsing file: #{@filename} ..."

    parsed = `tesseract #{@fileop.path} -psm 7 stdout`
    res = parsed.strip

    LOG.info "OCR got: #{res}"
    res
  end
end
