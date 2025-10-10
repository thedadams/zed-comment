# zed-comment
[![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.zed.dev%2Fextensions%2Fzed-comment&query=%24.data%5B0%5D.download_count&label=download&cacheSeconds=60)](https://zed.dev/extensions?query=zed-comment)

An extension for the Zed text editor to highlight according to the corresponding theme color comments beginning with:
- TODO:, WIP: (`constant`)
- NOTE:, XXX:, INFO:, DOCS:, PERF:, TEST: (`emphasis`)
- FIXME:, BUG:, ERROR: (`property`)
- HACK:, WARNING:, WARN:, FIX: (`keyword`)
- If the comment has a user in it (like `TODO(thedadams)`), then they user will be highlighted as `emphasis`.

Ideally, the coloring would be supported by definitions like `comment.info` and `comment.warning`, but those aren't officially supported by Zed themes.

## Installation

Search "zed-comment" in extension page, and install it. See the Compatibility section for details on what is needed from _each_ language for proper highlighting.

## Compatibility

This extension provides a new "language" called `comment`.
In order for comments to be properly highlighted, this language must be injected into other languages.
This will progressively be integrated for every language/language extension via pull request.

If in the meantime you want to enable it for a specific language extension:

### 1. Find the root folder of Zed language extensions

| OS      | Path                                                                      |
| ------- | ------------------------------------------------------------------------- |
| macOS   | `/Users/<username>/Library/Application Support/Zed/extensions/installed/` |
| Linux   | `~/.local/share/zed/extensions/installed/`                                |
| Windows | `%APPDATA%\Zed\extensions\installed\`                                     |

### 2. Find or create the `injections.scm` file for the desired language

Navigate to the language's directory and locate or create an `injections.scm` file. Add the language injection snippet below.

> [!NOTE]
> In a single `injections.scm` file, only one of `@content` or `@injections.content` is allowed, never both.
> Check which variant the existing file uses (if any) and use the same one.

#### Using `@content`:

```scheme
((comment) @content
  (#set! injection.language "comment"))
```

#### Using `@injections.content`:

```scheme
((comment) @injections.content
  (#set! injection.language "comment"))
```

> [!IMPORTANT]
> Replace `comment` in `((comment)` with the proper node name for the comment syntax in your target language. This varies per language (see examples below).

### 3. Examples

| Language      | Relative Path                            | Node Name | Snippet                                                     |
| ------------- | ---------------------------------------- | --------- | ----------------------------------------------------------- |
| Scheme (.scm) | `scheme/languages/scheme/injections.scm` | `comment` | `((comment) @content (#set! injection.language "comment"))` |

---

> [!TIP]
> You can add support for the built-in languages that don't inject the "comment" language yet by [building Zed](https://github.com/zed-industries/zed/tree/main) yourself after patching every language you want in `zed/crates/languages/src`.
> See the [Rust](https://github.com/zed-industries/zed/blob/main/crates/languages/src/rust/injections.scm) language support built into Zed as an example.

> [!NOTE]
> You may have to restart the language server or Zed to get the injections to work properly. Also, you are likely to need to redo the edits made here any time the extension is updated. Because of this, it is highly recommended to submit a PR to the extension with the edits you are making.

## Credits

Thanks to [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment) grammar.
