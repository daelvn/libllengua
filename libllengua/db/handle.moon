--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019
import insert, delete, update, select from require "libllengua.db.schema"
import flatJoinRight, transformOld    from require "libllengua.util"

--> # Handle
--> Generates `*For` functions for being imported.
Handle = (schema) ->
  selectSchema = select schema

  --> ## insertRow
  --> Inserts a new row into the table.
  insertRow = (lang) -> (row) ->
    db = lang.db
    db\update (insert schema), row

  --> ## deleteRow
  --> Deletes a row from the table.
  deleteRow = (lang) -> (row) ->
    db = lang.db
    db\update (delete schema), row

  --> ## findRow
  --> Returns all occurrences of a name in the table. Apply the first argument for several column selectors.
  findRow = (lang) -> (column) -> (str) ->
    db = lang.db
    db\queryall (selectSchema {column}), [column]: str

  --> ## getRow
  --> Returns a single row from the table. Apply the first argument for several column selectors.
  getRow = (lang) -> (column) -> (str) ->
    db = lang.db
    db\queryone (selectSchema {column}), [column]: str

  --> ## updateRow
  --> Updates a row from the table.
  updateRow = (lang) -> (oldRow) -> (row) ->
    db = lang.db
    db\update (update schema), (flatJoinRight transformOld oldRow) row

  { :insertRow, :deleteRow, :findRow, :getRow, :updateRow }

{ :Handle }
