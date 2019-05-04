--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019
import ll_inventory_schema from (require "libllengua.db.initialize").schemas
import unpackFn, isIn      from require "libllengua.util"
import Handle              from require "libllengua.db.handle"
clutch = require "clutch"

--> # Categories
--> Categories are used to store lists of sounds, to be used in LLRE and word building.

--> # Category
--> A Category structure for Lua.
Category = unpackFn {"category", "sounds"}, (category, sounds={}) ->
  { :category, sounds: table.concat sounds, "," }

--> # categoriesFor
--> Returns the category methods library for a language.
categoriesFor = (lang) ->
  import insertRow, deleteRow, findRow, getRow, updateRow from Handle ll_namebase_schema
  insertCategory = insertRow lang
  deleteCategory = deleteRow lang
  findAny        = findRow   lang
  getAny         = getRow    lang
  updateCategory = updateRow lang
  --
  getCategory    = getAny "category"

  { :insertCategory, :deleteCategory, :findAny, :getAny, :updateCategory, :getCategory }

{ :Category, :categoriesFor }
