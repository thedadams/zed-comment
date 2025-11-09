((tag
  (name) @_name @constant.comment.todo
  ("(" @constant.comment.todo.bracket
    (user) @constant.comment.todo.user
    ")" @constant.comment.todo.bracket)?
  (text)? @constant.comment.todo.text)
  (#match? @_name "^[</#*;+\\-!| \t]*(TODO|WIP|MAYBE)$"))

((tag
  (name) @_name @string.comment.info
  ("(" @string.comment.info.bracket
    (user) @string.comment.info.user
    ")" @string.comment.info.bracket)?
  (text)? @string.comment.info.text)
(#match? @_name "^[</#*;+\\-!| \t]*(NOTE|XXX|INFO|DOCS|PERF|TEST)$"))

((tag
  (name) @_name @property.comment.error
  ("(" @property.comment.error.bracket
    (user) @property.comment.error.user
    ")" @property.comment.error.bracket)?
  (text)? @property.comment.error.text)
(#match? @_name "^[</#*;+\\-!| \t]*(FIXME|BUG|ERROR)$"))

((tag
  (name) @_name @keyword.comment.warn
  ("(" @keyword.comment.warn.bracket
    (user) @keyword.comment.warn.user
    ")" @keyword.comment.warn.bracket)?
  (text)? @keyword.comment.warn.text)
(#match? @_name "^[</#*;+\\-!| \t]*(HACK|WARNING|WARN|FIX)$"))
