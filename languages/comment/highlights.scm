((tag
  (name) @_name @constant.comment.todo
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":"? @punctuation.delimiter
  (text)? @constant.comment.todo.text)
  (#match? @_name "^[</#*;+\\-!| \t]*(TODO|WIP)$"))

((tag
  (name) @_name @string.comment.info
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":"? @punctuation.delimiter
  (text)? @string.comment.info.text)
(#match? @_name "^[</#*;+\\-!| \t]*(NOTE|XXX|INFO|DOCS|PERF|TEST)$"))

((tag
  (name) @_name @property.comment.error
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":"? @punctuation.delimiter
  (text)? @property.comment.error.text)
(#match? @_name "^[</#*;+\\-!| \t]*(FIXME|BUG|ERROR)$"))

((tag
  (name) @_name @keyword.comment.warn
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":"? @punctuation.delimiter
  (text)? @keyword.comment.warn.text)
(#match? @_name "^[</#*;+\\-!| \t]*(HACK|WARNING|WARN|FIX)$"))
