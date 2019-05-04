--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019
import ll_namebase_schema from (require "libllengua.db.initialize").schemas
import unpackFn           from require "libllengua.util"
import Handle             from require "libllengua.db.handle"
clutch = require "clutch"

--> # Namebase
--> Based on ConWorkShop's Namebase feature.  
--> Namebase is a a list of proper names in the language. It can contain given names, surnames, nicknames, and others.

--> # Name
--> A Name structure for Lua.
Name = unpackFn {"name", "type", "gender", "notes"}, (name, type="given", gender="any", notes="") ->
  type_ = switch type_
    when "given", "surname", "middle", "chosen", "nick", "token", "tribe", "other" then type_
    else                                                                                "other"
  { :name, :type, :gender, :notes }

--> # namebaseFor
--> Returns the namebase methods library for a language.
namebaseFor = (lang) ->
  import insertRow, deleteRow, findRow, getRow, updateRow from Handle ll_namebase_schema
  insertName = insertRow lang
  deleteName = deleteRow lang
  findAny    = findRow   lang
  getAny     = getRow    lang
  updateName = updateRow lang
  --
  findName   = findAny "name"
  getName    = getAny  "name"
  findType   = findAny "type"
  findGender = findAny "gender"
  findNotes  = findAny "notes"

  { :insertName, :deleteName, :findAny, :getAny, :updateName, :findName, :getName, :findType, :findGender, :findNotes}

{ :Name, :namebaseFor }
