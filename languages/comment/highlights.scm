((tag
  (name) @_name @constant.comment.todo
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter
  (text)? @constant.comment.todo.text)
  (#any-of? @_name "TODO" "WIP"))

((tag
  (name) @_name @string.comment.info
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter
  (text)? @string.comment.info.text)
(#any-of? @_name "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))

((tag
  (name) @_name @property.comment.error
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter
  (text)? @property.comment.error.text)
(#any-of? @_name "FIXME" "BUG" "ERROR"))

((tag
  (name) @_name @keyword.comment.warn
  ("(" @punctuation.bracket
    (user) @emphasis.comment.user
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter
  (text)? @keyword.comment.warn.text)
(#any-of? @_name "HACK" "WARNING" "WARN" "FIX"))
