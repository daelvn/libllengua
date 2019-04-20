--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 19.04.2019
import flatJoinRight, transformOld from require "libllengua.util"
import guessIPA                    from require "libllengua.phonetic.util"
clutch = require "clutch"

--> # Dictionary
--> Dictionary manager for libllengua.

--> # Word
--> A Word object to manage in Lua.
Word = (word, definition, pos, classlist="", ipa=(guessIPA word), source="unknown", etymology="unknown", notes="")
  if (type word) == "table"
    definition = word.definition or error "Missing definition for word #{word.word}"
    pos        = word.pos        or error "Missing part of speech for word #{word.word}"
    classlist  = word.classlist  or ""
    ipa        = word.ipa        or guessIPA word.word
    source     = word.source     or "unknown"
    etymology  = word.etymology  or "unknown"
    notes      = word.notes      or ""
    word       = word.word       or error "Missing word"
  {:word, :definition, :pos, :classlist, :ipa, :source, :etymology, :notes}

--> # transformInternal
--> Makes a Word into an internal representation, so it matches with the column names.
transformInternal = (word) ->
  word.pronunciation = word.ipa
  word.ipa           = nil
  --
  word["class"]      = word.classlist
  word.classlist     = nil
  --
  word

--> # dictionaryFor
--> Returns the dictionary methods library for a language.
dictionaryFor = (lang) ->
  db = lang.db

  --> ## insertWord
  --> Inserts a new name into the database.
  insertWord = (word) ->
    db\update [[
      INSERT INTO dictionary
      VALUES(:word, :definition, :pronunciation, :source, :class, :etymology, :notes);
    ]], transformInternal word

  --> ## deleteWord
  --> Deletes a word from the table.
  deleteWord = (word) ->
    db\update [[
      DELETE FROM dictionary WHERE
          word=:word
      AND definition=:definition
      AND pronunciation=:pronunciation
      AND source=:source
      AND class=:class
      AND etymology=:etymology
      AND notes=:notes
    ]], transformInternal word

  --> ## findWord
  --> Returns all definitions of a word in the table.
  findWord = (wordstring) -> db\queryall "SELECT * FROM dictionary WHERE word=:wordstring"

  --> ## getWord
  --> Returns a single word from the dictionary.
  getWord = (wordstring) -> db\queryone "SELECT * FROM dictionary WHERE word=:wordstring"

  --> ## setWord
  --> Updates a word
  setWord = (oldWord) -> (word) ->
    db\update [[
      UPDATE dictionary SET
          word=:word
        , definition=:definition
        , pronunciation=:pronunciation
        , source=:source
        , class=:class
        , etymology=:etymology
        , notes=:notes
      WHERE
            word=:oldword
        AND definition=:olddefinition
        AND pronunciation=:oldpronunciation
        AND source=:oldsource
        AND class=:oldclass
        AND etymology=:oldetymology
        AND notes=:oldnotes
    ]], (flatJoinRight (transformOld transformInternal oldWord)) transformInternal word

  { :insertWord, :deleteWord, :findWord, :getWord, :setWord }

{ :Word, :transformInternal, :dictionaryFor }
