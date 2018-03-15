# group process
class GroupProcessor
  REGEX = /(SET|SET[5|S][0|O]) (\d{1,3},\d{3}.\d{2}|\d{3}.\d{2}) (.{1}) (\d{1,2}.\d{2})/

  def initialize(t_group)
    @ts = t_group
  end

  def process
    ts_length = @ts.length
    # return immediately for single result
    return @ts[0] if ts_length == 1

    # test with regex
    @ts.each do |t|
      return t if REGEX =~ t.ocr
    end

    # return the middle value in the arrays
    ts_length.odd? ? @ts[ts_length / 2] : @ts[ts_length / 2 - 1]
  end
end
