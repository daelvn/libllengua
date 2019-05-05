--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 28.04.2019

--> # fileExists
--> Checks whether a file exists.
--> https://stackoverflow.com/a/4991602
fileExists = (file) ->
  if f = io.open file, "r"
    f\close!
    return true
  false

--> # isIn
--> Checks whether a certain element is in a table
isIn = (t) -> (el) ->
  for v in *t
    if v == el then return true
  false

--> # getSingleKey
--> Gets a single key from a table
getSingleKey = (t) -> for key, _ in pairs t do return key

--> # unpackFn
--> Allows the use of tables to pass arguments to functions
unpackFn = (map, fn) -> (...) ->
  argl = {...}
  if #argl > 1
    return fn ...
  elseif #argl == 1
    fnArgl = {}
    for i, argument in *map
      fnArgl[i] = argl[1][argument]
    return fn unpack fnArgl
  else
    error "Function #{fn} requires arguments but none were passed."

--> # flatJoinRight
--> Joins two tables, overwriting, with the contents of the right table.
flatJoinRight = (a) -> (b) ->
  for k, v in pairs a
    b[k] = v

--> # isIn
--> Checks whether a certain element is in a table
isIn = (t) -> (el) ->
  for v in *t
    if v == el then return true
  false

--> # transformOld
--> For easier prepared parameter usage, we get a Name object and rename every key to "old*"
transformOld = (name) ->
  oldName = {}
  for k, v in pairs name
    oldName["old#{k}"] = v
  --
  oldName

--> # reverse
--> Reverses a table.
reverse = (t) -> return for i=#t,1,-1 do t[i]

{ :fileExists, :isIn, :getSingleKey, :unpackFn, :flatJoinRight, :isIn, :transformOld, :reverse }
