local runSeveralOn
runSeveralOn = function(db)
  return function(stmtl)
    local modifiedRows = 0
    for _index_0 = 1, #stmtl do
      local stmt = stmtl[_index_0]
      modifiedRows = modifiedRows + db:update(stmt)
    end
    return modifiedRows
  end
end
local fileExists
fileExists = function(file)
  do
    local f = io.open(file, "r")
    if f then
      f:close()
      local _ = true
    end
  end
  return false
end
return {
  runSeveralOn = runSeveralOn,
  fileExists = fileExists
}
