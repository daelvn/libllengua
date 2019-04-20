--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 18.04.2019
import flatJoinRight, transformOld from require "libllengua.util"
clutch = require "clutch"

--> # Namebase
--> Based on ConWorkShop's Namebase feature.  
--> Namebase is a a list of proper names in the language. It can contain given names, surnames, nicknames, and others.

--> # Name
--> A Name object to manage in Lua.
Name = (name, type_="given", gender="any", notes="") ->
  if (type name) == "table"
    type_  = name.type   or "given"
    gender = name.gender or "any"
    notes  = name.notes  or ""
    name   = name.name
  type_ = switch type_
    when "given", "surname", "middle", "chosen", "nick", "token", "tribe", "other" then type_
    else                                                                                "other"
  { :name, type: type_, :gender, :notes }

--> # namebaseFor
--> Returns the namebase methods library for a language.
namebaseFor = (lang) ->
  db = lang.db

  --> ## insertName
  --> Inserts a new name into the table.
  insertName = (name) ->
    db\update [[
      INSERT INTO namebase (name, type, gender, notes)
      VALUES(:name, :type, :gender, :notes);
    ]], name

  --> ## deleteName
  --> Deletes a name from the table.
  deleteName = (name) ->
    db\update [[
      DELETE FROM namebase WHERE
          name=:name
      AND type=:type
      AND gender=:gender
      AND notes=:notes;
    ]], name

  --> ## findName
  --> Returns all occurrences of a name in the table.
  findName = (namestring) -> db\queryall "SELECT * FROM namebase WHERE name=:namestring"

  --> ## getName
  --> Returns a name object from the name string.
  getName = (namestring) -> db\queryone "SELECT * FROM namebase WHERE name=:namestring"

  --> ## setName
  --> Updates a name
  setName = (oldName) -> (name) ->
    db\update [[
      UPDATE namebase SET
          name=:name
        , type=:type
        , gender=:gender
        , notes=:notes
      WHERE
            name=:oldname
        AND type=:oldtype
        AND gender=:oldgender
        AND notes=:oldnotes;
    ]], (flatJoinRight (transformOld oldName)) name

  { :insertName, :deleteName, :findName, :getName, :setName }

{ :Name, :namebaseFor }
