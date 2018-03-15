Sequel.migration do
  change do
    create_table(:firsts) do
      String    :filename
      TrueClass :posted, default: false
    end
  end
end
