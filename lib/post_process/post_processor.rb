#
class PostProcessor

  YEN = "\u00A5".encode('utf-8')

  def initialize(ocr)
    @ocr = ocr
  end

  def normalize
    res = @ocr.strip

    arr = res.split(' ')
    if arr.length == 4
      # replace 50
      type = arr[0]
      if type.length == 5 # SET50
        type[3..4] = '50'
        arr[0] = type
      end

      arr[2].sub!('+', '-')
      arr[2].sub!('7', '-')
      arr[2].sub!('T', '-')
      arr[2].sub!('v', '-')
      arr[2].sub!(YEN, '-')
      arr[2].sub!('A', '+')
      arr[2].sub!('4', '+')
      arr[2].sub!('a', '+')
      arr[2].sub!('«', '+')
    end
    arr.join(' ')
  end
end
