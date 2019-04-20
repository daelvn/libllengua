--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 18.04.2019
inspect = require "inspect"

--> # inspectFor
--> Returns inspection tools for a language
inspectFor = (lang) ->
  db = lang.db

  --> # printTable
  --> Prints all contents of a table in the database.
  printTable = (tableName) ->
    for row in db\query "SELECT * FROM #{tableName}"
      print inspect row

  { :printTable }

{ :inspectFor }
