require "sqlite3"
require "json"

db = SQLite3::Database.new("./example.sqlite")
db.results_as_hash = true

tables = db.execute("SELECT name FROM sqlite_master WHERE type='table'").map { |row| row["name"] }
p tables

# Get content from each table
db_content = {}
tables.each do |table|
  db_content[table] = db.execute("SELECT * FROM #{table}").map { |row| row.to_h }
end

p db_content

File.open("example.json", "w") do |f|
  f.write(JSON.pretty_generate(db_content))
end
