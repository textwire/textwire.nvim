; Variables
(identifier) @variable

; Basic tokens
(boolean_literal
  ["true" "false"] @constant.builtin)

(integer_literal) @constant.numeric
(float_literal) @constant.numeric
(string_literal) @string
(nil_literal) @constant.builtin
(comment) @comment

; Keywords
[
  "@end"
  "@dump"
  "@breakIf"
  "@continueIf"
  "@if"
  "@elseif"
  "@else"
  "@else"
  "@each"
  "@for"
  "@component"
  "@insert"
  "@reserve"
  "@slot"
  "@slot("
  "@slot ("
  "@slot  ("
  "@use"
 ] @type.builtin

; Statements
(break_statement) @type.builtin
(continue_statement) @type.builtin

["+" "-" "*" "/" "%"] @operator

["(" ")"] @punctuation.bracket

(call_expression
  function: (identifier) @function.method)

(global_call_expression
  function: (identifier) @function.method)

(dot_expression
  key: (identifier) @property)

(each_statement
  "in" @constant.builtin)
