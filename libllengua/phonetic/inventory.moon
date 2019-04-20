--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 19.04.2019
import qualities                         from require "libllengua.phonetic.qualities"
import flatJoinRight, isIn, transformOld from require "libllengua.util"
clutch = require "clutch"

--> # Phonetic Inventory
--> Full list of phonemes and sounds.

--> # isQuality
--> Check whether a string is a phonetic quality
isQuality = isIn qualities

--> # Sound
--> Creates a Sound object to manage within Lua.
Sound = (sound, quality="none", allophone="", loan=false, blend=false) ->
  if (type sound) == "table"
    quality   = sound.quality   or "none"
    allophone = sound.allophone or ""
    loan      = sound.loan      or false
    blend     = sound.blend     or false
  unless isQuality quality then error "Quality #{quality} is not valid."
  loan  = (loan  == true) and 1 or 0
  blend = (blend == true) and 1 or 0
  { :sound, :quality, :allophone, :loan, :blend }

--> # phoneticInventoryFor
--> Returns the phonetic inventory method library for the language.
phoneticInventoryFor = (lang) ->
  db = lang.db

  --> ## insertSound
  --> Inserts a sound into the phonetic inventory.
  insertSound = (sound) ->
    db\update [[
      INSERT INTO phonetic_inventory
      VALUES(:sound, :quality, :allophone, :loan, :blend);
    ]], sound

  --> ## deleteSound
  --> Deletes a sound from the phonetic inventory.
  deleteSound = (sound) ->
    db\update [[
      DELETE FROM phonetic_inventory WHERE
          sound=:sound
      AND quality=:quality
      AND allophone=:allophone
      AND loan=:loan
      AND blend=:blend;
    ]], sound

  --> ## findSound
  --> Returns all occurrences of a sound in the inventory.
  findSound = (soundstring) -> db\queryall "SELECT * FROM phonetic_inventory WHERE sound=:soundstring"

  --> ## getSound
  --> Returns a sound object from the string.
  getSound = (soundstring) -> db\queryone "SELECT * FROM phonetic_inventory WHERE sound=:soundstring"

  --> ## setSound
  --> Updates a sound
  setSound = (oldSound) -> (sound) ->
    db\update [[
      UPDATE phonetic_inventory SET
          sound=:sound
        , quality=:quality
        , allophone=:allophone
        , loan=:loan
        , blend=:blend
      WHERE
            sound=:oldsound
        AND quality=:oldquality
        AND allophone=:oldallophone
        AND loan=:oldloan
        AND blend=:oldblend
    ]], (flatJoinRight (transformOld oldSound)) sound

  { :insertSound, :deleteSound, :findSound, :getSound, :setSound }

{ :Sound, :phoneticInventoryFor }
