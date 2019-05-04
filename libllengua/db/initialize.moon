--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 28.04.2019
import Schema, Index, create, types from require "libllengua.db.schema"
import TEXT, NUMERIC, UNIQUE, ROWID from types
--> # Database initialization
--> Queries for initializing the database.

--> ## ll_metadata
--> This table contains metadata for the database, such as the version, language name and code, etc.
ll_metadata_schema = Schema "ll_ll_metadata",
  [1]: key:   TEXT
  [2]: value: TEXT

--> ## ll_inventory
--> This table contains the list of sounds and its associated graphemes, it is possible to assign qualities to the
--> sounds, custom uppercase versions, allophones and variants, and it supports blends natively.
ll_inventory_schema = Schema "ll_inventory",
  [1]: sound:          TEXT
  [2]: quality:        TEXT
  [3]: grapheme:       TEXT
  [4]: grapheme_upper: TEXT
  [5]: allophone:      TEXT
  [6]: variant:        TEXT
  [7]: loan:           NUMERIC
  [8]: blend:          NUMERIC

--> ## ll_categories
--> Comma-separated sound categories for the tools provided by libllengua.
ll_categories_schema = Schema "ll_categories",
  [1]: category: UNIQUE TEXT
  [2]: sounds:   TEXT

--> ## ll_dictionary
--> Word list for the language. Supports definitions, transliterations, etymology, notes, classes, pronounciation and
--> more.
ll_dictionary_schema = Schema "ll_dictionary",
  [1]: word:          TEXT
  [2]: definition:    TEXT
  [3]: pronunciation: TEXT
  [4]: source:        TEXT
  [5]: class:         TEXT
  [6]: etymology:     TEXT
  [7]: notes:         TEXT
ll_dictionary_index  = Index "ll_index_dictionary", "ll_dictionary", "word"

--> ## ll_namebase
--> Keep track of proper names and other kinds of names in your language. With support for gender and notes.
ll_namebase_schema = Schema "ll_namebase",
  [1]: name:    TEXT
  [2]: type:    TEXT
  [3]: gender:  TEXT
  [4]: notes:   TEXT

--> ## ll_translations
--> Text or phrase translations for the language.
ll_translations_schema = Schema "ll_translations",
  [1]: original_code: TEXT
  [2]: original_text: TEXT
  [3]: text:          TEXT

--> ## ll_grammar_declinations
--> Table that links a part of speech to its declinations, so later it can form conjugation tables.
ll_grammar_declinations_schema = Schema "ll_grammar_declinations",
  [1]: pos:          UNIQUE TEXT
  [2]: declinations: TEXT

--> ## ll_examples
--> Table of examples to display.
ll_examples_schema = Schema "ll_examples",
  [1]: name: TEXT
  [2]: text: TEXT

--> ## ll_remap
--> Pattern replacements at display time.
ll_remap_schema = Schema "ll_remap",
  [1]: name:    TEXT
  [2]: capture: TEXT
  [3]: replace: TEXT

--> ## ll_syllables
--> Table of syllables for wordbuilding.
ll_syllables_schema = Schema "ll_syllables",
  [1]: syllable: TEXT

--> ## ll_re
--> Stores sound changes for the Llengua Rewrite Engine.
ll_re_schema = Schema "ll_re",
  [1]: name:        TEXT
  [2]: capture:     TEXT
  [3]: replace:     TEXT
  [4]: environment: TEXT
  [5]: exception:   TEXT
  [6]: otherwise:   TEXT
ll_re_index  = Index "ll_index_re", "ll_re", "name"

schemas = {
  ll_metadata_schema
  ll_inventory_schema
  ll_categories_schema
  ll_dictionary_schema
  ll_namebase_schema
  ll_translations_map
  ll_grammar_declinations_schema
  ll_examples_schema
  ll_remap_schema
  ll_syllables_schema
  ll_re_schema
}

indexes = {
  ll_dictionary_index
  ll_re_index
}

{ :schemas, :indexes }
