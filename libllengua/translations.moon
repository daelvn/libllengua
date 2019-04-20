--> # libllengua
--> Library for managing conlangs
-- By daelvn
-- 19.04.2019
clutch = require "clutch"

--> # Translations
--> This aims to keep a list of translations, keeping track of the original language as well.

--> # Translation
--> Creates a Translation object.
Translation = (original_code, original_text, text) ->
  if (type original_code) == "table"
    original_text = original_code.original
    text          = original_code.text
    original_code = original_code.from
  { :original_code, :original_text, :text }

--> # translationsFor
--> Returns the translation methods library for this language.
translationsFor = (lang) ->
  db = lang.db
  
  --> ## insertTranslation
  --> Inserts a translation into the table. Returns a translation ID.
  insertTranslation = (translation) ->
    db\update [[
      INSERT INTO translations(original_code, original_text, text)
      VALUES(:original_code, :original_text, :text);
    ]], translation
    return (db\queryone [[
      SELECT id FROM translations WHERE
            original_code=:original_code
        AND original_text=:original_text
        AND text=:text;
    ]], translation).id

  --> ## deleteTranslation
  --> Deletes a translation by id.
  deleteTranslation = (translationID) -> db\update "DELETE FROM translations WHERE id=:translationID;"

  --> ## getTranslation
  --> Returns a translation by id.
  getTranslation = (translationID) -> db\queryone "SELECT * FROM translations WHERE id=:translationID;"

  --> ## setTranslation
  --> Updates a translation by id.
  setTranslation = (translationID) -> (translation) ->
    db\update [[
      UPDATE translations SET
        original_code=:original_code
      , original_text=:original_text
      , text=:text
      WHERE
        id=:translationID
    ]], (flatJoinRight {:translationID}) translation

  { :insertTranslation, :deleteTranslation, :getTranslation, :setTranslation }

{ :Translation, :translationsFor }
