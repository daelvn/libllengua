# LLRE
LLRE (LLengua Rewrite Engine) is the system for rewriting words or applying sound changes as a Lua library. Ideally, it
would be implemented as a Lua domain specific language. Using MoonScript as the base for the DSL is being considered due
to it's ease of use and relative closeness to human language (compare `if belongs_to(position(5),category) then
inside(word,replace("x", "y"))` to `inside word, "x" becomes "y" if (position 5) belongs to category`).
