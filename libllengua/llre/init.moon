--> # llre
--> Llengua Rewrite Engine
-- By daelvn
-- 05.05.2019
import find, insert, split from require "libllengua.llre.string"
import categoriesFor       from require "libllengua.categories"
unpack or= table.unpack

--> ## LLRE-Lua
--> Simplified version of LLRE, only supporting the features of Lua patterns. Usually, this covers enough cases for
--> sound changes.

--> # parseLuaRule
--> Parses a LLRE rule.
parseLuaRule = (rule) -> (split "/") rule

--> # compileRule
--> Compiles a parsed rule into a LLRE structure.
compileLuaRule = (lang) -> (rule) ->
  compilePart = (r) ->
    r = r\gsub "%[(.)%]", (c) ->
      import getCategory from categoriesFor lang
      getCategory c
    r
  {
    capture:     compilePart rule[1]
    replace:     compilePart rule[2]
    environment: compilePart rule[3]
    exception:   compilePart rule[4]
    otherwise:   compilePart rule[5]
  }

--> # buildRule
--> Parses and compiles a LLRE rule
buildLuaRule = (lang) -> (rule) -> (compileLuaRule lang) parseLuaRule rule

--> # applyRule
--> Applies a compiled rule to a string.
applyLuaRule = (rule) -> (str) ->
  insertBack = insert str
  posl = (find rule.environment) str
  if #posl > 0
    for pair in *posl
      substr    = str\sub unpack pair
      substr, c = substr\gsub rule.capture, rule.replace
      if c > 0
        return (insertBack substr) pair[1]
      else
        substr, c = substr\gsub rule.capture, rule.otherwise
        if c > 0
          return (insertBack substr) pair[1]
        else
          return str
  else
    excPosl = (find rule.exception) str
    if #excPosl > 0
      substr    = str\sub unpack pair
      substr, c = substr\gsub rule.capture, rule.otherwise
      if c > 0
        return (insertBack substr) pair[1]
      else
        return str
    else
      return str

print (require "inspect") parseLuaRule "i/j/a.e[^l]/a.el/n"
print (require "inspect") (buildLuaRule {}) "i/j/a.e[^l]/a.el/n"
print (applyLuaRule (buildLuaRule {}) "i/j/a.e[^l]/a.el/n") "faied"
