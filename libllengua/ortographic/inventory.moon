--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 19.04.2019
import flatJoinRight, transformOld from require "libllengua.util"
clutch = require "clutch"

--> # Ortographic Inventory
--> This is the inventory for graphemes, as linked to sounds.

--> # Grapheme
--> Creates a Grapheme object to manage within Lua.
--> ## Grapheme properties
--> - **sound**: Sound associated to the grapheme.
--> - **grapheme**: Grapheme for the inventory.
--> - **upper**: Uppercase version of the grapheme. This is usually handled by Lua. (optional)
--> - **name**: Name of the sound. (optional)
--> - **variant**: Variant grapheme. (optional)
Grapheme = (sound, grapheme, name="", upper=(string.upper grapheme), variant="") ->
  if (type sound) == "table"
    grapheme  = sound.grapheme  or error "Missing grapheme for sound #{sound}"
    name      = sound.name      or ""
    upper     = sound.upper     or string.upper grapheme or ""
    variant   = sound.variant   or ""
    sound     = sound.sound     or error "Missing sound"
  { :sound, :grapheme, :name, :upper, :variant }

--> # ortographicInventoryFor
--> Returns the ortographic inventory methods library for the language.
ortographicInventoryFor = (lang) ->
  db = lang.db

  --> ## insertGrapheme
  --> Inserts a grapheme into the ortographic inventory.
  insertGrapheme = (grapheme) ->
    db\update [[
      INSERT INTO ortographic_inventory
      VALUES(:sound, :grapheme, :name, :upper, :variant);
    ]], grapheme

  --> ## deleteGrapheme
  --> Deletes a grapheme from the ortographic inventory.
  deleteGrapheme = (grapheme) ->
    db\update [[
      DELETE FROM ortographic_inventory WHERE
          sound=:sound
      AND grapheme=:grapheme
      AND name=:name
      AND upper=:upper
      AND variant=:variant
    ]], sound

  --> ## findGrapheme
  --> Returns all occurrences of a sound in the inventory.
  findGrapheme = (graphemestring) -> db\queryall "SELECT * FROM ortographic_inventory WHERE grapheme=:graphemestring"

  --> ## getGrapheme
  --> Returns a sound object from the string.
  getGrapheme = (graphemestring) -> db\queryone "SELECT * FROM ortographic_inventory WHERE grapheme=:graphemestring"

  --> ## setGrapheme
  --> Updates a sound
  setGrapheme = (oldGrapheme) -> (grapheme) ->
    db\update [[
      UPDATE ortographic_inventory SET
          sound=:sound
        , grapheme=:grapheme
        , name=:name
        , upper=:upper
        , variant=:variant
      WHERE
            sound=:sound
        AND grapheme=:grapheme
        AND name=:name
        AND upper=:upper
        AND variant=:variant
    ]], (flatJoinRight (transformOld oldGrapheme)) sound

  { :insertGrapheme, :deleteGrapheme, :findGrapheme, :getGrapheme, :setGrapheme }

{ :Grapheme, :ortographicInventoryFor }
