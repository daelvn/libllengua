--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 19.04.2019
import flatJoinRight, transformOld from require "libllengua.util"
clutch = require "clutch"

--> # Phonetic Categories
--> Groupings of letters to use with phonetic and ortographic rules, rewrite rules and others.
--> ```moon
--> V = aeiou
--> L = àèìòù
--> ```

--> # Category
--> Creates a new Category object.
Category = (category, letters) -> { :category, :letters }

--> # categoriesFor
--> Returns the category methods library for the language.
categoriesFor = (lang) ->
  db = lang.db

  --> ## insertCategory
  --> Inserts a category in the table.
  insertCategory = (category) -> db\update [[ INSERT INTO phonetic_categories VALUES(:category, :letters); ]], category

  --> ## deleteCategory
  --> Deletes a category from the table.
  deleteCategory = (category) -> db\update [[ DELETE FROM phonetic_categories WHERE category=:category AND letters=:letters; ]], category

  --> ## getCategory
  --> Returns a category from the table.
  getCategory = (categoryName) -> db\queryone "SELECT * FROM phonetic_categories WHERE category=:categoryName;"

  --> ## setCategory
  --> Modifies an existing category.
  setCategory = (oldCategory) -> (category) ->
    db\update [[
      UPDATE phonetic_categories SET
          category=:category
        , letters=:letters
      WHERE
          category=:oldcategory
      AND letters=:oldletters;
    ]], (flatJoinRight transformOld oldCategory) category

  { :insertCategory, :deleteCategory, :getCategory, :setCategory }

{ :Category, :categoriesFor }
