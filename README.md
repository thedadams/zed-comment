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

This extension provides a new "language" called `comment`. In order for comments to be properly highlighted, this language must be injected into other languages. To do this, a snippet must be added to the `injections.scm` file for each language where comment syntax support is desired. An example might be:
```scheme
((comment) @content
 (#set! injection.language "comment")
)
```

See the [Dockerfile plugin](https://github.com/zed-extensions/dockerfile/blob/main/languages/dockerfile/injections.scm) as an example.

Note also that in a single `injections.scm` file, only one of `@content` or `@injections.content` is allowed, never both. So, if the language's `injections.scm` file is already using `@injections.content`, then the snippet should be:
```scheme
((comment) @injections.content
 (#set! injection.language "comment")
)
```

See the [Rust](https://github.com/zed-industries/zed/blob/main/crates/languages/src/rust/injections.scm) support built into Zed.

Finally, the `(comment)` part is also language-specific. In the Rust example linked above, the proper node name is `(line_comment)` instead.

The bottom line is that adding this injection is straightforward as long as you use:
- The `@content` or `@injections.content` snippet, depending on the language's `injections.scm` file.
- The proper node name for the comment syntax in the language.

## Credits

Thanks to [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment) grammar.
