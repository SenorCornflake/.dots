local util = require("CONFIG.util")

util.bind("n", "<leader>gc", ":Git commit<CR>")
util.bind("n", "<leader>ga", ":Git add ", { noremap = true, silent = false })
util.bind("n", "<leader>gp", ":Git push<CR>")
util.bind("n", "<leader>gP", ":Git pull<CR>")
util.bind("n", "<leader>gb", ":Git blame<CR>")
util.bind("n", "<leader>gl", ":Git log<CR>")
