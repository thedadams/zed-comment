# zed-comment
[![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.zed.dev%2Fextensions%2Fcomment&query=%24.data%5B0%5D.download_count&label=download&cacheSeconds=60)](https://zed.dev/extensions?query=comment)

An extension for the Zed text editor to highlight according to the corresponding theme color comments beginning with:
- TODO, WIP, MAYBE, ? (`constant`)
- INFO, NOTE, XXX, DOCS, PERF, TEST, * (`string`)
- ERROR, FIXME, BUG, DELETE, ! (`property`)
- WARN, HACK, WARNING, FIX, SAFETY, # (`keyword`)
- By default, the user (in the case of something like `NOTE(thedadams):`) and anything after the name and/or user is highlighted the same as the name (`TODO`, `INFO`, `ERROR`, etc). See [Theme Overrides](#theme-overrides) for customization.
- By default, the prefix (the `//` or the `#` that starts the comment) is styled the same as the type of comment as well, but can also be customized using the [Theme Overrides](#theme-overrides). Similarly for any `*` that starts a line in a multi-line comment.

Ideally, the coloring would be supported by definitions like `comment.info` and `comment.warning`, but those aren't officially supported by Zed themes. However, it is possible to customize these colors using the [Theme Overrides](#theme-overrides) below.

## Breaking Changes

Prior to version v0.4.0, for a comment like `HACK(thedadams)`, the parenthesis and user were styled the same regardless as the type of comment. As of v0.4.0, the parenthesis and user are styled the same as the type of comment, but can be customized using the [Theme Overrides](#theme-overrides). In particular, the user was styled using the `emphasis.comment.user` theme node. This is no longer the case.

## Installation

Search "comment" in extension page, and install it. See the Compatibility section for details on what is needed from _each_ language for proper highlighting.

## Multi-line Comments

For languages that support multi-line comments, the extension will highlight consecutive lines with the same color. A line with no text in the comment will reset the parser.

For example, the text in the following comment will all be highlighted as a `TODO` comment.

```java
/*
 * TODO: This is a multi-line comment.
 * It will be highlighted with the same color.
 */
```

This comment has two blocks, the first will be highlighted as a `TODO` comment, and the second will be highlighted as an `INFO` comment.

```java
/*
 * TODO: This is a multi-line comment.
 * It will be highlighted with the same color.
 * HACK: This is highlighted the same as above and not as a HACK
 * because there is no empty line between the two blocks.
 *
 * INFO: This is another multi-line comment.
 * It will be highlighted with the same color.
 */
```

This applies to multi-comment lines only. So, for example, the following would be highlighted as two separate blocks.

```java
// TODO: This is a single-line comment and will be highlighted as a TODO.
// HACK: This is a single-line comment and will be highlighted as a HACK.
```

This screenshot shows an illustration of this behavior:
![Highlighting example](/static/HighlightingExample.png?raw=true)

> [!NOTE]
> In order to use `*` as a tag name in multi-line comments, you need to have have two `*` with a space between them; the first `*` is treated as a prefix and the second as a tag name.

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
> In a single `injections.scm` file, only one of `@content` or `@injection.content` is allowed, never both.
> Check which variant the existing file uses (if any) and use the same one.

#### Using `@content`:

```scheme
((comment) @content
  (#set! injection.language "comment"))
```

#### Using `@injection.content`:

```scheme
((comment) @injection.content
  (#set! injection.language "comment"))
```

> [!IMPORTANT]
> Replace `comment` in `((comment)` with the proper node name for the comment syntax in your target language. This varies per language (see examples below).

### 3. Examples

| Language      | Relative Path                            | Node Name | Snippet                                                     |
| ------------- | ---------------------------------------- | --------- | ----------------------------------------------------------- |
| Scheme (.scm) | `scheme/languages/scheme/injections.scm` | `comment` | `((comment) @content (#set! injection.language "comment"))` |

---

> [!NOTE]
> You may have to restart the language server or Zed to get the injections to work properly. Also, you are likely to need to redo the edits made here any time the extension is updated. Because of this, it is highly recommended to submit a PR to the extension with the edits you are making.

### Supported languages

The table below lists each language’s comment injection status: ✅ supported; ⚠️ not yet supported (PR submitted).

| Language      | Supported                                | Pull request                                         |
| ------------- | ---------------------------------------- | ---------------------------------------------------- |
| AsciiDoc      | ✅                                       | https://github.com/dunyakirkali/zed-asciidoc/pull/10 |
| Bash          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| C             | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Clojure       | ✅                                       | https://github.com/zed-extensions/clojure/pull/13    |
| C#            | ✅                                       | N/A                                                  |
| C++           | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| CSS           | ✅                                       | https://github.com/zed-industries/zed/pull/41710     |
| D             | ✅                                       | N/A                                                  |
| Dart          | ✅                                       | https://github.com/zed-extensions/dart/pull/35       |
| Diff          | ✅                                       | https://github.com/zed-industries/zed/pull/41710     |
| Dockerfile    | ✅                                       | https://github.com/zed-extensions/dockerfile/pull/25 |
| Elixir        | ✅                                       | https://github.com/zed-extensions/elixir/pull/38     |
| Git Commit    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Gleam         | ⚠️                                       | https://github.com/gleam-lang/zed-gleam/pull/20      |
| Go            | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Haskell       | ✅                                       | https://github.com/zed-extensions/haskell/pull/7     |
| HTML          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Java          | ✅                                       | N/A                                                  |
| Javascript    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| JSONC         | ✅                                       | https://github.com/zed-industries/zed/pull/41710     |
| Kotlin        | ✅                                       | https://github.com/zed-extensions/kotlin/pull/51     |
| Lua           | ⚠️                                       | https://github.com/zed-extensions/lua/pull/37        |
| Make          | ✅                                       | https://github.com/caius/zed-make/pull/27            |
| PHP           | ✅                                       | https://github.com/zed-extensions/php/pull/66        |
| Python        | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| R             | ✅                                       | N/A                                                  |
| RBS           | ✅                                       | https://github.com/zed-industries/zed/pull/15778     |
| Ruby          | ✅                                       | https://github.com/zed-extensions/ruby/pull/203      |
| Rust          | ✅                                       | https://github.com/zed-industries/zed/pull/39714     |
| Scala         | ✅                                       | N/A                                                  |
| Scheme        | ✅                                       | https://github.com/zed-extensions/scheme/pull/5      |
| SQL           | ⚠️                                       | https://github.com/zed-extensions/sql/pull/38        |
| Svelte        | ✅                                       | https://github.com/zed-extensions/svelte/pull/52     |
| Swift         | ✅                                       | https://github.com/zed-extensions/swift/pull/43      |
| Terraform/HCL | ✅                                       | https://github.com/zed-extensions/terraform/pull/7   |
| TOML          | ✅                                       | https://github.com/zed-extensions/toml/pull/2        |
| TSX           | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| TypeScript    | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| YAML          | ✅                                       | https://github.com/zed-industries/zed/pull/39884     |
| Zig           | ✅                                       | N/A                                                  |

## Theme Overrides

Ideally, the colors for comments would be defined in themes by the `comment.todo`, `comment.info`, `comment.warn`, `comment.error`, and `comment.user` properties. However, these are not officially supported by Zed. Until they are, `constant`, `string`, `property`, and `keyword` are used so that coloring works out of the box. There is really no rhyme or reason to these choices.

This extension uses a small hack to allow users to customize the colors used in comments without affecting the rest of the syntax highlighting. You can access your settings file via the command palette ("zed: Open Settings" - `cmd-,` on macOS, `ctrl-,` on Linux) and add a `theme_overrides` section.

Below is a complete example you can add to your Zed settings and modify to fit your needs. If your settings file already contains a `theme_overrides` object, you can add these entries to the appropriate theme.

```jsonc
{
  "theme_overrides": {
    "YourThemeName": {
      "syntax": {
        "constant.comment.todo": {
          "color": "#4078f2ff"
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
        }
      }
    }
  }
}
```

**Note:** Replace `YourThemeName` with the actual name of your active theme (e.g., "One Dark", "Ayu Light", etc.).

To explain how and why this works, we'll use `constant.comment.todo` as an example.

This extension defines the syntax color node as `constant.comment.todo`. Zed will look for a corresponding color in your theme or override for this name. If it finds one, it will use that color. If not, then it will use the color corresponding to `constant.comment`, if available. If that is not available, it will use the color corresponding to `constant`, which nearly every theme supports.

Therefore, by defining coloring for `constant.comment.todo` in your overrides, you can change the color and style of just the `TODO` and `WIP` comments.

The text after the `:` can also be customized by adding a `.text` after the corresponding color node. For example, if you want to change the color or style of the text corresponding to an `ERROR:` comment:

```jsonc
{
  "theme_overrides": {
    "YourThemeName": {
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
}
```

Similarly, the prefix (the `//`, `#` or `*` that starts a comment line), parenthesis, and user corresponding to an `ERROR:` comment can be styled as follows:

```jsonc
{
  "theme_overrides": {
    "YourThemeName": {
      "syntax": {
        "property.comment.error.prefix": {
          "color": "#ff0000"
          // "background_color": "#00000000",
          // "font_weight": "bold",
          // "font_style": "italic"
        },
        "property.comment.error.bracket": {
          "color": "#000000dd"
          // "background_color": "#00000000",
          // "font_weight": "bold",
          // "font_style": "italic"
        },
        "property.comment.error.user": {
          "color": "#000000dd"
          // "background_color": "#00000000",
          // "font_weight": "bold",
          // "font_style": "italic"
        }
      }
    }
  }
}
```

## Credits

Thanks to [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment) grammar.
