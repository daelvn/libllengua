--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 20.04.2019
import createTable, insertInto, mapColumns from require "libllengua.db.table"
--
TEXT    = "TEXT"
NUMERIC = "NUMERIC"
UNIQUE  = (x) -> "UNIQUE " .. x
ROWID   = "INTEGER PRIMARY KEY"

--> # Schemas
--> Table schemas for the creation of the database.

--> ## ll_metadata
--> This table contains metadata for the database, such as the version, language name and code, etc.
ll_metadata_schema = createTable "ll_metadata",
  [1]: key:   TEXT
  [2]: value: TEXT

--> ## ll_metadata_map
--> Column map to use with mapColumns.
ll_metadata_map = {
  key:   1
  value: 2
}

--> ## mapMetadata
--> mapColumns with ll_metadata_map applied.
mapMetadata = mapColumns ll_metadata_map

--> ## inventory
--> This table contains the list of sounds and its associated graphemes, it is possible to assign qualities to the
--> sounds, custom uppercase versions, allophones and variants, and it supports blends natively.
inventory_schema = createTable "inventory",
  [1]: sound:          TEXT
  [2]: quality:        TEXT
  [3]: grapheme:       TEXT
  [4]: grapheme_upper: TEXT
  [5]: allophone:      TEXT
  [6]: variant:        TEXT
  [7]: loan:           NUMERIC
  [8]: blend:          NUMERIC
  --
  [9]: sound_id:       ROWID

--> ## inventory_map
--> Column map to use with mapColumns.
inventory_map = mapColumns {
  sound:          1
  quality:        2
  grapheme:       3
  grapheme_upper: 4
  allophone:      5
  variant:        6
  loan:           7
  blend:          8
  sound_id:       9
}

--> ## mapInventory
--> mapColumns with inventory_map applied.
mapInventory = mapColumns inventory_map

--> ## categories
--> Comma-separated sound categories for the tools provided by libllengua.
categories_schema = createTable "categories",
  [1]: category: UNIQUE TEXT
  [2]: sounds:   TEXT

--> ## categories_map
--> Column map to use with mapColumns.
categories_map = {
  category: 1
  sounds:   2
}

--> ## mapCategories
--> mapColumns with categories_map applied.
mapCategories = mapColumns categories_map

--> ## dictionary
--> Word list for the language. Supports definitions, transliterations, etymology, notes, classes, pronounciation and
--> more.
dictionary_schema = createTable "dictionary",
  [1]: word:          TEXT
  [2]: definition:    TEXT
  [3]: pronunciation: TEXT
  [4]: source:        TEXT
  [5]: class:         TEXT
  [6]: etymology:     TEXT
  [7]: notes:         TEXT
  --
  [8]: word_id:       ROWID

--> ## dictionary_map
--> Column map to use with mapColumns.
dictionary_map = {
  word:          1
  definition:    2
  pronunciation: 3
  source:        4
  class:         5
  etymology:     6
  notes:         7
  word_id:       8
}

--> ## mapDictionary
--> mapColumns with dictionary_map applied.
mapDictionary = mapColumns dictionary_map

--> ## namebase
--> Keep track of proper names and other kinds of names in your language. With support for gender and notes.
namebase_schema = createTable "namebase",
  [1]: name:    TEXT
  [2]: type:    TEXT
  [3]: gender:  TEXT
  [4]: notes:   TEXT
  --
  [5]: name_id: ROWID

--> ## namebase_map
--> Column map to use with mapColumns.
namebase_map = {
  name:    1
  type:    2
  gender:  3
  notes:   4
  mame_id: 5
}

--> ## mapNamebase
--> mapColumns with namebase_map applied.
mapNamebase = mapColumns namebase_map

--> ## translations
--> Text or phrase translations for the language.
translations_schema = createTable "translations",
  [1]: original_code: TEXT
  [2]: original_text: TEXT
  [3]: text:          TEXT
  --
  [4] translation_id: TEXT

--> ## translations_map
--> Column map to use with mapColumns.
translations_map = {
  original_code:  1
  original_text:  2
  text:           3
  translation_id: 4
}

--> ## mapTranslations
--> mapColumns with translations_map applied.
mapTranslations = mapColumns translations_map

--> ## grammar_declinations
--> Table that links a part of speech to its declinations, so later it can form conjugation tables.
grammar_declinations_schema = createTable "grammar_declinations",
  [1]: pos:          UNIQUE TEXT
  [2]: declinations: TEXT

--> ## grammar_declinations_map
--> Column map to use with mapColumns.
grammar_declinations_map = {
  pos:          1
  declinations: 2
}

--> ## mapGrammarDeclinations
--> mapColumns with grammar_declinations_map applied.
mapGrammarDeclinations = mapColumns grammar_declinations_map

schema = {
  ll_metadata_schema
  inventory_schema
  categories_schema
  dictionary_schema
  namebase_schema
  translations_map
  grammar_declinations_schema
}

maps = {
  :ll_metadata_map
  :inventory_map
  :categories_map
  :dictionary_map
  :namebase_map
  :translations_map
  :grammar_declinations_map
}

mapf = {
  :mapMetadata
  :mapInventory
  :mapCategories
  :mapDictionary
  :mapNamebase
  :mapTranslations
  :mapGrammarDeclinations
}

{ :schema, :maps, :mapf }
