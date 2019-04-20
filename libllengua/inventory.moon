--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 20.04.2019
import Sound, phoneticInventoryFor       from require "libllengua.phonetic.inventory"
import Grapheme, ortographicInventoryFor from require "libllengua.ortographic.inventory"

--> # Inventory
--> This part of the library is the result of linking the Phonetic Inventory and the Ortographic Inventory into a single
--> inventory using SQLite triggers.

--> # inventoryFor
--> Returns an inventory for the language.
