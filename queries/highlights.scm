; Variables
(ident_expr) @variable

; Basic tokens
(bool_expr
  ["true" "false"] @constant.builtin)

(int_expr) @constant.numeric
(float_expr) @constant.numeric
(str_expr) @string
(nil_expr) @constant.builtin
(comment) @comment

; Keywords
[
  "@end"
  "@dump"
  "@breakIf"
  "@continueIf"
  "@breakif"
  "@continueif"
  "@if"
  "@elseif"
  "@else"
  "@else"
  "@each"
  "@for"
  "@component"
  "@insert"
  "@reserve"
  "@slotif"
  "@slot"
  "@use"
 ] @type.builtin

; Statements
(break_dir) @type.builtin
(continue_dir) @type.builtin

["+" "-" "*" "/" "%"] @operator

["(" ")"] @punctuation.bracket

(call_expr
  function: (ident_expr) @function.method)

(global_call_expr
  function: (ident_expr) @function.method)

(dot_expr
  key: (ident_expr) @property)

(each_dir
  "in" @constant.builtin)
