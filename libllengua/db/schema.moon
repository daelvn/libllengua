--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 28.04.2019
import getSingleKey from require "libllengua.util"

--> # Schema
--> Creates a table schema to use with method generation and Clutch builders. The `columns` argument gets broken down
--> into `column_types` and `column_order`.
--> Fields:
--> - `name`: Name of the schema.
--> - `column_types`: Types for each column.
--> - `column_order`: Order of the columns.
Schema = (name, columns) ->
  column_types, column_order = {}, {}
  for i, column in ipairs columns
    key = getSingleKey column
    column_types[key] = column[key]
    column_order[i]   = key
  { :name, :column_types, :column_order }

--> # create
--> Generates a `create table` statement from a Schema.
create = (schema) ->
  query = "create table #{schema.name}("
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= "#{column} #{schema.column_types[column]}"
    else           query ..= ", #{column} #{schema.column_types[column]}"
  query .. ")"

--> # insert
--> Generates an `insert into` statement from a Schema.
insert = (schema) ->
  query = "insert into #{schema.name}("
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= "#{column}"
    else           query ..= ", #{column}"
  query ..= ") values("
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= ":#{column}"
    else           query ..= ", :#{column}"
  query .. ");"

--> # delete
--> Generates a `delete from` statement from a Schema.
delete = (schema) ->
  query = "delete from #{schema.name} where "
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= "#{column}=:#{column}"
    else           query ..= " and #{column}=:#{column}"
  query

--> # update
--> Generates an `update` statement from a Schema.
update = (schema) ->
  query = "update #{schema.name} set "
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= "#{column}=:#{column}"
    else           query ..= ", #{column}=:#{column}"
  query ..= " where "
  for i, column in ipairs schema.column_order
    if i == 1 then query ..= "#{column}=:old#{column}"
    else           query ..= " and #{column}=:old#{column}"
  query

--> # select
--> Generates a `select` statement from a Schema.
select = (schema) -> (select) ->
  query = "select * from #{schema.name} where "
  for i, column in ipairs select
    if i == 1 then query ..= "#{column}=:#{column}"
    else           query ..= ", #{column}=:#{column}"
  query

--> # prepare
--> Prepare a statement for it to apply variables (to use with `runOn` and `runSeveralOn`)
prepare = (query) -> (variables) ->
  for variable, value in pairs variables do query\gsub ":#{variable}", tostring value
  query

--> # SQL Types
TEXT    = "text"
NUMERIC = "numeric"
UNIQUE  = (x) -> "unique" .. x
ROWID   = "integer primary key"

--> # Index
--> Creates an index on a Schema.
Index = (name, schema, column) -> "create index #{name} on #{schema.name} (#{column})"

{ :Schema, :Index, :create, :insert, :delete, :update, :select, :prepare, types: {:TEXT, :NUMERIC, :UNIQUE, :ROWID}}
