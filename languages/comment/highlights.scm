((tag
  (name) @constant
  ("(" @punctuation.bracket
    (user) @emphasis
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @constant "TODO" "WIP"))

((tag
  (name) @emphasis
  ("(" @punctuation.bracket
    (user) @emphasis
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
(#any-of? @emphasis "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))

((tag
  (name) @property
  ("(" @punctuation.bracket
    (user) @emphasis
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
(#any-of? @property "FIXME" "BUG" "ERROR"))

((tag
  (name) @keyword
  ("(" @punctuation.bracket
    (user) @emphasis
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
(#any-of? @keyword "HACK" "WARNING" "WARN" "FIX"))
