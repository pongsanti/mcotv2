Sequel.migration do
  change do
    create_table(:firsts) do
      String    :filename
      String    :ocr
      String    :normalized
      TrueClass :ready, default: false
      TrueClass :posted, default: false
    end
  end
end
