# First model
class Sec < Sequel::Model
  set_primary_key :rowid

  class << self
    def sel
      select(:rowid, :gid, :filename, :ocr, :normalized :ready, :posted)
    end
  end
end
