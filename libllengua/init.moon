--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 12.04.2019
import runSeveralOn, fileExists from require "libllengua.util"
import schema, maps, mapf       from require "libllengua.db.schemas"
import insertInto               from require "libllengua.db.table"
import LLENGUA_DB_VERSION       from require "libllengua.config"
import mapMetadata              from mapf
clutch = require "clutch"

--> # General structure
--> This paragraph describes the general structure of the llengua language storage system.
-->
--> ## Language
--> A Language object contains every piece of information about the language to be stored. It has the following
--> properties:
--> - **Name** (name): The name of the language.
--> - **Autonym** (autonym): The name of the language as said in the language.
--> - **Code** (code): Language code (`en_US`, `en_UK`, `es_AR`...)
--> ### Phonology
--> Phonetic properties of your language, here you can set the inventory, phonotactics and pronounciation estimation.
--> ### Ortography
--> Here you can associate graphemes to phonemes, form ortographic categories to use with tools, or set the alphabetical
--> order.
--> ### Grammar
--> Set the typology, create grammar tables and conjugators and test grammar.
--> ### Dictionary
--> Word list for your language.
--> ### Literature
--> Keep track of journals and other pieces of literature.

--> # getDatabaseVersion
--> Returns the database version.
getDatabaseVersion = (db) -> (db\queryone "SELECT value FROM ll_metadata WHERE key='db_version'").value

--> # Language
--> Creates a new Language object.
Language = (name, autonym, code="#{string.lower name\sub 1,2}_#{string.upper autonym\sub 1,2}") ->
  db           = clutch.open "#{code}.llengua.db"
  unless fileExists "#{code}.llengua.db"
    initLanguage = runSeveralOn db
    initLanguage schema
    db\update insertInto "ll_metadata", mapMetadata key: "'db_version'", "'#{LLENGUA_DB_VERSION}'"
  else
    error "Database version mismatch. Expected #{LLENGUA_DB_VERSION}, got #{getDatabaseVersion db}" unless (getDatabaseVersion db) == LLENGUA_DB_VERSION
  { :name, :autonym, :code, :db }

--> # queryLanguage
--> Performs a query on a language.
queryLanguage = (lang) ->
  db = lang.db
  (sql) -> (varl) -> db\queryall sql, varl

--> # finalizeLanguage
--> Finalize all edits to the language.
finalizeLanguage = (lang) ->
  lang.db\close!

{ :Language, :queryLanguage, :finalizeLanguage, :getDatabaseVersion }
