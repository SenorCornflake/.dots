local util = require("CONFIG.util")

-- Exconman manages the value of this variable
local colorscheme = "tokyonight"

vim.g.tokyonight_style = "night"
vim.cmd("colorscheme " .. colorscheme)
