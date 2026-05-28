(tag
  (name) @name
  (
      "(" @context
      (user) @context
      ")" @context
  )?
  .
  (text)? @context
  (#match? @name "^(TODO|WIP|MAYBE|QUESTION|\\?|NOTE|XXX|INFO|DOCS|PERF|TEST|\\*|FIXME|FIX|BUG|ERROR|DELETE|!|HACK|WARNING|WARN|SAFETY|IMPORTANT|#)$")
  ) @item
