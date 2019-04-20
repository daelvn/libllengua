import Language, finalizeLanguage from require "libllengua.init"
import Name, namebaseFor          from require "libllengua.namebase"
import inspectFor                 from require "libllengua.inspect"
sv_SV = Language "Svalic", "Parlà Svaerna", "sv_SV"

import insertName, deleteName, getName, setName from namebaseFor sv_SV
import printTable                               from inspectFor sv_SV
insertName Name "Dael", "given", "any", ""
print (getName "Dael").gender
deleteName Name "Dael", "given", "any", ""
finalizeLanguage sv_SV
