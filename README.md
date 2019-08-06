# libllengua
libllengua is a collection of utilities and database operations to manage constructed languages. It uses
[Clutch](https://github.com/akojo/clutch) as its database handler, which uses SQLite. The idea of making a library is so
that frontends can be implemented in any way: `curses` command-line applications, prompts, Webapps, desktop
applications, phone apps, whatever! Each language is stored as a single database.

## Modules
### `libllengua.init`
Creation and opening of Languages. It creates a database object which you can pass around to the several other modules.
It also has functions for querying the database or finalizing the connection. All opened languages should be finalized
before closing.

### `libllengua.inspect`
Inspection tools for the database.

### `libllengua.namebase`
Namebase is a list of names in several qualities stored as a table in the database.

### `libllengua.translations`
Keep track of translations from any language to your language with the tools in this module.

### `libllengua.util`
Mainly functions to be used by other modules. Nothing important.

### `libllengua.dictionary`
A dictionary for your language supporting pronunciation, etymology and definitions, so it is not just a direct
translation book.

### `libllengua.ortographic.inventory`
Grapheme inventory, linked to sounds. In the future, the ortographic inventory and the phonetic inventory will be linked
using SQLite triggers.

### `libllengua.phonetic.qualities`
Simply returns a list of allowed phonetic qualities.

### `libllengua.phonetic.categories`
Handling of phonetic categories for use in tools like the LLRE (LLengua Rewriting Engine), which will come anytime soon
(not).

### `libllengua.phonetic.inventory`
Sound part of the inventory.

## License
Public domain.
