--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 12.04.2019
import runSeveralOn, fileExists from require "libllengua.util"
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

--> # Language
--> Creates a new Language object.
Language = (name, autonym, code="#{string.lower name\sub 1,2}_#{string.upper autonym\sub 1,2}") ->
  db           = clutch.open "#{code}.llengua.db"
  unless fileExists "#{code}.llengua.db"
    print "File #{code}.llengua.db does not exist!"
    initLanguage = runSeveralOn db
    initLanguage {
      "CREATE TABLE phonetic_inventory(sound TEXT, quality TEXT, allophone TEXT, loan NUMERIC, blend NUMERIC)"
      "CREATE TABLE phonetic_categories(category UNIQUE TEXT, letters TEXT)"
      "CREATE TABLE ortographic_inventory(sound TEXT, grapheme TEXT, name TEXT, upper TEXT, variant TEXT)"
      "CREATE TABLE grammar_declinations(pos TEXT, targets TEXT)"
      "CREATE TABLE dictionary(word TEXT, definition TEXT, pronunciation TEXT, source TEXT, class TEXT, etymology TEXT, notes TEXT)"
      "CREATE TABLE translations(id INTEGER PRIMARY KEY, original_code TEXT, original_text TEXT, text TEXT)"
      "CREATE TABLE namebase(name TEXT, type TEXT, gender TEXT, notes TEXT)"
    }
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

{ :Language, :queryLanguage, :finalizeLanguage }
