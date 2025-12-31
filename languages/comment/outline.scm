(tag
  (name) @name
  (
      "(" @context
      (user) @context
      ")" @context
  )?
  (text)? @context
  (#match? @name "^[</#*;+\\-!| \t]*(TODO|WIP|MAYBE|NOTE|XXX|INFO|DOCS|PERF|TEST|FIXME|BUG|ERROR|DELETE|HACK|WARNING|WARN|FIX|SAFETY)$")
  ) @item
