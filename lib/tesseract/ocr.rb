require 'file/file_op'
# ocr op
class Ocr
  def initialize(fop)
    @fop = fop
  end

  def parse
    LOG.info "Parsing file: #{@fop.filename} ..."

    parsed = `tesseract #{@fop.path} -psm 7 stdout`
    res = parsed.strip

    LOG.info "OCR got: #{res}"
    res
  end
end
