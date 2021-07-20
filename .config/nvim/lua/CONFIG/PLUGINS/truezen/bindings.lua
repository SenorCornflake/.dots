local util = require("CONFIG.util")

util.bind("n", "<leader>za", ":TZAtaraxis<CR>")
util.bind("n", "<leader>zf", ":TZFocus<CR>", { noremap = true, silent = false })
util.bind("n", "<leader>zm", ":TZMinimalist<CR>")
