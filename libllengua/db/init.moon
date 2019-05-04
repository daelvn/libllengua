--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 29.04.2019

--> # runOn
--> Runs a single update query on a database
runOn = (db) -> (query) -> db\update query

--> # selectOn
--> Runs a single select query on a database
selectOn = (db) -> (query) -> db\queryall query

--> # runSeveralOn
--> Runs several update queries on a database
runSeveralOn = (db) -> (queries) -> for query in *queries do db\update query

--> # selectSeveralOn
--> Runs several select queries on a database
selectSeveralOn = (db) -> (queries) -> return for query in *queries do db\queryall query

{ :runOn, :selectOn, :runSeveralOn, :selectSeveralOn }
