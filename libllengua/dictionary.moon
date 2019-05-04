--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019
import ll_dictionary_schema from (require "libllengua.db.initialize").schemas
import unpackFn             from require "libllengua.util"
import Handle               from require "libllengua.db.handle"
clutch = require "clutch"

--> # Dictionary
--> Dictionary manager for libllengua.

--> # Word
--> A Word structure for Lua.
Word = unpackFn {"word", "definition", "pos", "classlist", "ipa", "source", "etymology", "notes"},
  (word, definition, pos, classlist="", ipa=(guessIPA word), source="unknown", etymology="unknown", notes="") ->
    { :word, :definition, :pos, :classlist, :ipa, :source, :etymology, :notes }

--> # dictionaryFor
--> Returns the dictionary methods library for a language.
dictionaryFor = (lang) ->
  import insertRow, deleteRow, findRow, getRow, updateRow from Handle ll_dictionary_schema
  insertWord = insertRow lang
  deleteWord = deleteRow lang
  findAny    = findRow   lang
  getAny     = getRow    lang
  updateWord = updateRow lang
  --
  findWord       = findAny "word"
  getWord        = getAny  "word"
  findDefinition = findAny "definition"
  findPoS        = findAny "pos"
  findIPA        = findAny "ipa"
  getIPA         = getAny "ipa"
  findClasslist  = findAny "classlist"
  findSource     = findAny "source"
  findEtymology  = findAny "etymology"
  findNotes      = findAny "notes"

  {
    :insertWord, :deleteWord, :findAny, :getAny, :updateWord, :findWord, :getWord, :findDefinition, :findPoS, :findIPA,
    :getIPA, :findClasslist, :findSource, :findEtymology, :findNotes
  }

{ :Word, :dictionaryFor }
