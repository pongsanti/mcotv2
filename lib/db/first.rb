# First model
class First < Sequel::Model
  set_primary_key :rowid

  class << self
    def sel
      select(:rowid, :filename, :posted)
    end
  end
end
