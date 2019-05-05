--> # llre
--> Llengua Rewrite Engine
-- By daelvn
-- 04.05.2019
import reverse from require "libllengua.util"
inspect           = require "inspect"

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
    return {} if (last == 1) and (st == nil)
    break     if (st == nil)
    table.insert posl, {st, en}
    last = en + 1
  posl

--> # insert
--> Inserts strings into their original positions. It has to be done in reverse, otherwise the indexes of the table
--> generated from the string would change.
insert = (str) -> (ins) -> (st) ->
  rstrl = reverse atomize str
  rinsl = reverse atomize ins
  while #rinsl > 0
    table.insert rstrl, st+1, rinsl[#rinsl]
    table.remove rinsl, #rinsl
  return table.concat (reverse rstrl), ""

--> # split
split = (sep) -> (str, max, plain) ->
  assert sep != ''
  assert (max == nil) or (max >= 1)
  res = {}
  if str\len! > 0
    max         or= -1
    field, start  = 1, 1
    first, last   = str\find sep, start, plain
    while first and max != 0
      res[field]  = str\sub start, first-1
      field      += 1
      start       = last + 1
      first, last = str\find sep, start, plain
      max        -= 1
    res[field]    = str\sub start
  res

{ :atomize, :find, :insert, :split }
