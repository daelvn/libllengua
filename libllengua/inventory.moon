--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019
import ll_inventory_schema from (require "libllengua.db.initialize").schemas
import unpackFn, isIn      from require "libllengua.util"
import qualities           from require "libllengua.phonetic.qualities"
import Handle              from require "libllengua.db.handle"
clutch = require "clutch"

--> # Inventory
--> Ortographic and phonetic inventory.

--> # isQuality
--> Checks whether a string is a valid phonetic quality.
isQuality = isIn qualities

--> # Sound
--> Creates a Sound structure.
Sound = unpackFn {"sound", "quality", "grapheme", "grapheme_upper", "allophone", "variant", "loan", "blend"},
  (sound, quality="none", grapheme, grapheme_upper=grapheme\upper!, allophone="", variant="", loan=false, blend=false) ->
    loan  = (loan == true) and 1 or 0
    blend = (blend == true) and 1 or 0
    error "Quality #{quality} is not valid." unless isQuality quality
    { :sound, :quality, :grapheme, :grapheme_upper, :allophone, :variant, :loan, :blend }

--> # inventoryFor
--> Returns the inventory methods library for a language.
inventoryFor = (lang) ->
  import insertRow, deleteRow, findRow, getRow, updateRow from Handle ll_inventory_schema
  insertSound    = insertRow lang
  deleteSound    = deleteRow lang
  findAny        = findRow   lang
  getAny         = getRow    lang
  updateSound    = updateRow lang
  --
  findSound         = findAny "sound"
  getSound          = getAny  "sound"
  findQuality       = findAny "quality"
  findGrapheme      = findAny "grapheme"
  getGrapheme       = getAny  "grapheme"
  findUpperGrapheme = findAny "grapheme_upper"
  getUpperGrapheme  = getAny  "grapheme_upper"
  findAllophone     = findAny "allophone"
  getAllophone      = getAny  "allophone"
  findVariant       = findAny "variant"
  getVariant        = getAny  "variant"
  findLoans         = findAny "loan"
  findBlends        = findAny "blend"

  {
    :insertSound, :deleteSound, :findAny, :getAny, :updateSound, :findSound, :getSound, :findQuality, :findGrapheme,
    :getGrapheme, :findUpperGrapheme, :getUpperGrapheme, :findAllophone, :getAllophone, :findVariant, :getVariant,
    :findLoans, :findBlends
  }

{ :Sound, :inventoryFor }
