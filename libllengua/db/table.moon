--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 20.04.2019

--> # createTable
--> Creates a SQL table
createTable = (name, columns) ->
  query = "CREATE TABLE #{name}("
  for name, type in pairs columns[1]
    query ..= "#{name} #{type}"
  for column in *columns[2,]
    for name, type in pairs column
      query ..= ", #{name} #{type}"
  query .. ")"

--> # insertInto
--> Inserts into a SQL table
insertInto = (name, columns) ->
  query = "INSERT INTO #{name}("
  for name, _ in pairs columns[1]
    query ..= "#{name}"
  for column in *columns[2,]
    for name, _ in pairs column
      query ..= ", #{name}"
  query ..= ") VALUES("
  for _, value in pairs columns[1]
    query ..= "#{value}"
  for column in *columns[2,]
    for _, value in pairs column
      query ..= ", #{value}"
  query .. ");"

--> # mapColumns
--> Generates a column mapper, so you don't have to write the indexes every time.
mapColumns = (columnMap) -> (row) ->
  buildTable = {}
  for k, v in pairs row
    buildTable[columnMap[k]] = [k]: v
  buildTable

{ :createTable, :insertInto, :mapColumns }
