((tag
  (prefix)? @constant.comment.todo.prefix
  (name) @_name @constant.comment.todo
  ("(" @constant.comment.todo.bracket
    (user) @constant.comment.todo.user
    ")" @constant.comment.todo.bracket)?
  (
    (prefix)? @constant.comment.todo.prefix
    (text)? @constant.comment.todo.text)
  )
  (#match? @_name "^[</#*;+\\-!| \t]*(TODO|WIP|MAYBE)$"))

((tag
  (prefix)? @string.comment.info.prefix
  (name) @_name @string.comment.info
  ("(" @string.comment.info.bracket
    (user) @string.comment.info.user
    ")" @string.comment.info.bracket)?
  (
    (prefix)? @string.comment.info.prefix
    (text)? @string.comment.info.text)
  )
(#match? @_name "^[</#*;+\\-!| \t]*(NOTE|XXX|INFO|DOCS|PERF|TEST)$"))

((tag
  (prefix)? @property.comment.error.prefix
  (name) @_name @property.comment.error
  ("(" @property.comment.error.bracket
    (user) @property.comment.error.user
    ")" @property.comment.error.bracket)?
  (
    (prefix)? @property.comment.error.prefix
    (text)? @property.comment.error.text)
  )
(#match? @_name "^[</#*;+\\-!| \t]*(FIXME|BUG|ERROR|DELETE)$"))

((tag
  (prefix)? @keyword.comment.warn.prefix
  (name) @_name @keyword.comment.warn
  ("(" @keyword.comment.warn.bracket
    (user) @keyword.comment.warn.user
    ")" @keyword.comment.warn.bracket)?
  (
    (prefix)? @keyword.comment.warn.prefix
    (text)? @keyword.comment.warn.text)
  )
(#match? @_name "^[</#*;+\\-!| \t]*(HACK|WARNING|WARN|FIX|SAFETY)$"))
