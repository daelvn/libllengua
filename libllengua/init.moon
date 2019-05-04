--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 28.04.2019
import schemas, indexes                from require "libllengua.db.initialize"
import Schema, create, insert, prepare from require "libllengua.db.schema"
import runOn, runSeveralOn             from require "libllengua.db"
import unpackFn, fileExists            from require "libllengua.util"
import LIBLLENGUA_DB_VERSION           from require "libllengua.config"
clutch = require "clutch"

--> # Llengua
--> Llengua is a constructed language framework for the development and management of those. It is based upon the
--> functionality of [ConWorkShop](https://conworkshop.info), and seeks to expand on top of that. The general idea is to
--> build it as a library, so that it can be used in command-line applications (curses?), webapps (using
--> [Lapis](https://leafo.net/lapis)), apps (Java-Lua bridge, perhaps?) and many others. It uses
--> [Clutch](https://github.com/akojo/clutch) for managing SQLite databases.
--> ## Database structure
--> The database uses SQLite, and each language is stored as a single database, so these can be exported and read by
--> other libraries and programs. There are some tables destined to certain parts of the database, like the dictionary
--> or the phonetic inventory, these are prefixed with `ll_`, where as other user-modifiable content, such as
--> conjugation tables, are defined in other database tables prefixed with `conj_` or `user_`.
--> ### `ll_metadata`
--> Key-value storage for the language. Stores stuff like the language name, the schema version...
--> #### Common fields
--> - `schema_version`: Version of the schema.
--> - `language_name`: Name of the language.
--> - `language_code`: Code of the language (xx\_XX)
--> - `language_autonym`: Autonym for the language. An autonym is the name of the language in the language itself.
--> ### `ll_inventory`
--> This table contains the list of sounds and its associated graphemes, it is possible to assign qualities to the
--> sounds, custom uppercase versions, allophones and variants, and it supports blends natively.
--> ### `ll_categories`
--> Comma-separated sound categories for the tools provided by libllengua.
--> ### `ll_dictionary`
--> Word list for the language. Supports definitions, transliterations, etymology, notes, classes, pronounciation and
--> more.
--> ### `ll_namebase`
--> Keep track of proper names and other kinds of names in your language. With support for gender and notes.
--> ### `ll_translations`
--> Text or phrase translations for the language.
--> ### `ll_grammar_declinations`
--> Table that links a part of speech to its declinations, so later it can form conjugation tables.

--> # getSchemaVersion
--> Returns the schema version.
getSchemaVersion = (db) -> (db\queryone "SELECT value FROM ll_metadata WHERE key='schema_version'").value

--> # Language
--> Creates a new Language structure.
Language = unpackFn {"code", "name", "autonym"}, (code, name=(string.lower code), autonym=(string.lower code)) ->
  db = clutch.open "#{code}.llengua.db"
  unless fileExists "#{code}.llengua.db"
    insertMeta   = prepare insert schemas.ll_metadata_schema
    initLanguage = runSeveralOn db
    initLanguage [create schema for schema in *schemas]
    initLanguage indexes
    initLanguage {
      insertMeta {key: "schema_version",   value: LIBLLENGUA_DB_VERSION}
      insertMeta {key: "language_name",    value: name}
      insertMeta {key: "language_code",    value: code}
      insertMeta {key: "language_autonym", value: autonym}
    }
  else
    error "Schema version mismatch. Expected #{LIBLLENGUA_DB_VERSION}, got #{getSchemaVersion db}" unless (getSchemaVersion db) == LIBLLENGUA_DB_VERSION
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
