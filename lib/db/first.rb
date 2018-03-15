# First model
class First < Sequel::Model
  set_primary_key :rowid

  class << self
    def sel
      select(:rowid, :filename, :ocr, :normalized, :posted)
    end

    def not_posted
      sel.where(posted: 0).order(:rowid)
    end
  end
end
