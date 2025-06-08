-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirectiona

vim.keymap.set('', 'hw', function()
  hop.hint_words()
end, {remap=true})

vim.keymap.set('', 'hc', function()
  hop.hint_words({ current_line_only = true })
end, {remap=true})

vim.keymap.set('', 'hl', function()
  hop.hint_lines()
end, {remap=true})


