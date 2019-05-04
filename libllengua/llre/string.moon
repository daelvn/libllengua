--> # llre
--> Llengua Rewrite Engine
-- By daelvn
-- 04.05.2019
import reverse from require "libllengua.util"

--> # llre.string
--> This module contains modified version of string library functions, and some additions, so that LLRE can work with
--> patterns properly.

--> # atomize
--> Returns a list of characters from a string.
atomize = (str) -> [char for char in str\gmatch "."]

--> # find
--> Returns a list of start-end position pairs.
find = (re) -> (str) ->
  len  = str\len!
  last = 1
  posl = {}
  while true do
    st, en = str\find re, last
    return nil if (last == 1) and (st == nil)
    break      if (st == nil)
    table.insert posl, {st, en}
    last = en + 1

--> # insert
--> Inserts strings into their original positions. It has to be done in reverse, otherwise the indexes of the table
--> generated from the string would change.
insert = (str) -> (ins) -> (st) ->
  rstrl = reverse atomize str
  rinsl = reverse atomize ins
  while #rinsl >= 1
    table.insert rstrl, st
    table.remove rinsl, 1
  return table.concat (reverse rstrl), ""

print ((insert "abchij") "def") 3
