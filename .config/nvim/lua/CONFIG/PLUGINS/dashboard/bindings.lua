local util = require("CONFIG.util")
util.bind("n", "<leader>sl", ":lua require('CONFIG.util').sessions()<cr>")
util.bind("n", "<leader>ss", ":SessionSave<CR>")
