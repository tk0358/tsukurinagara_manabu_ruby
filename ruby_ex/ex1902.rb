require 'pstore'

db = PStore.new('fruitdb')

db.transaction(true) do
  db["drink"] = "grape juice"
end
