local util = require("CONFIG.util")

util.bind("n", "<leader>cc", "<Plug>kommentary_line_default", { silent = true })
util.bind("n", "<leader>c", "<Plug>kommentary_motion_default", { silent = true })
util.bind("v", "<leader>c", "<Plug>kommentary_visual_default", { silent = true })
