# zed-comment
[![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.zed.dev%2Fextensions%2Fcomment&query=%24.data%5B0%5D.download_count&label=download&cacheSeconds=60)](https://zed.dev/extensions?query=comment)

An extension for the Zed text editor to highlight according to the corresponding theme color comments beginning with:
- TODO:, WIP: (`constant`)
- INFO:, NOTE:, XXX:, DOCS:, PERF:, TEST: (`string`)
- ERROR:, FIXME:, BUG: (`property`)
- WARN:, HACK:, WARNING:, FIX: (`keyword`)
- If the comment has a user in it (like `TODO(thedadams):`), then they user will be highlighted as `emphasis`.
- By default, anything after the `:` is highlighted the same as the name (`TODO`, `INFO`, `ERROR`, etc). See [Theme Overrides](#theme-overrides) for customization.

Ideally, the coloring would be supported by definitions like `comment.info` and `comment.warning`, but those aren't officially supported by Zed themes. However, it is possible to customize these colors using the [Theme Overrides](#theme-overrides) below.

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

### Supported languages

The table below lists each language’s comment injection status: ✅ supported; ⚠️ not yet supported (PR submitted).

| Language      | Supported                                | Pull request                                         |
| ------------- | ---------------------------------------- | ---------------------------------------------------- |
| Rust          | ✅                                       | https://github.com/zed-industries/zed/pull/39714     |
| Bash          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| C             | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| C++           | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Git Commit    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Go            | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Javascript    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Python        | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| TSX           | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| TypeScript    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| YAML          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| HTML          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Dockerfile    | ⚠️                                       | https://github.com/zed-extensions/dockerfile/pull/25 |
| TOML          | ⚠️                                       | https://github.com/zed-extensions/toml/pull/2        |
| Make          | ⚠️                                       | https://github.com/caius/zed-make/pull/27            |

## Theme Overrides

Ideally, the colors for comments would be defined in themes by the `comment.todo`, `comment.info`, `comment.warn`, `comment.error`, and `comment.user` properties. However, these are not officially supported by Zed. Until they are, `constant`, `string`, `property`, `keyword`, and `emphasis` are used so that coloring works out of the box. There is really no rhyme or reason to these choices.

This extension uses a small hack to allow users to customize the colors used in comments without affecting the rest of the syntax highlighting. Below is a complete example you can add to your Zed settings and modify to fit your needs. If your settings file already contains a `experimental.theme_overrides` object, you can simply add the `syntax` object to it.

```json
{
  "experimental.theme_overrides": {
    "syntax": {
      "constant.comment.todo": {
        "color": "#4078f2ff",
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      },
      "string.comment.info": {
        "color": "#50a14fff"
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      },
      "keyword.comment.warn": {
        "color": "#c18401ff"
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      },
      "property.comment.error": {
        "color": "#ca1243ff"
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      },
      "emphasis.comment.user": {
        "color": "#000000dd"
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      }
    }
  }
}
```

To explain how and why this works, we'll use `constant.comment.todo` as an example.

This extension defines the syntax color node as `constant.comment.todo`. Zed will look for a corresponding color in your theme or override for this name. If it finds one, it will use that color. If not, then it will use the color corresponding to `constant.comment`, if available. If that is not available, it will use the color corresponding to `constant`, which nearly every theme supports.

Therefore, by defining coloring for `constant.comment.todo` in your overrides, you can change the color and style of just the `TODO` and `WIP` comments.

The text after the `:` can also be customized by adding a `.text` after the corresponding color node. For example, if you want to change the color or style of the text corresponding to an `ERROR:` comment:

```json
{
  "experimental.theme_overrides": {
    "syntax": {
      "property.comment.error.text": {
        "color": "#ff0000"
        // "background_color": "#00000000",
        // "font_weight": "bold",
        // "font_style": "italic"
      }
    }
  }
}
```

## Credits

Thanks to [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment) grammar.
