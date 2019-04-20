--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 18.04.2019

--> # runSeveralOn
--> Given a clutch handle and a statement list, it runs each statement. It returns the number of modified rows.
runSeveralOn = (db) -> (stmtl) ->
  modifiedRows = 0
  for stmt in *stmtl
    modifiedRows += db\update stmt
  --
  modifiedRows

--> # fileExists
--> Checks whether a file exists.
--> https://stackoverflow.com/a/4991602
fileExists = (file) ->
  if f = io.open file, "r"
    f\close!
    return true
  false

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


{ :runSeveralOn, :fileExists, :flatJoinRight, :isIn, :transformOld }
