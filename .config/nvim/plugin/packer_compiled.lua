-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/a/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/a/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/a/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/a/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/a/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Catppuccino.nvim"] = {
    commands = { "colorscheme" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/Catppuccino.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\1\2G\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0,neovim_configuration.plugins.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/bufferline.nvim"
  },
  ["codeschool.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/codeschool.nvim"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\1\2C\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0(neovim_configuration.plugins.feline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/feline.nvim"
  },
  ["fzf-lua"] = {
    commands = { "FzfLua" },
    config = { "\27LJ\1\2w\0\0\2\0\5\0\b4\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\3\0%\1\4\0>\0\2\1G\0\1\0%neovim_configuration.plugins.fzf\frequire#doautocmd User load_fzf_plugin\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/fzf-lua"
  },
  ["github-nvim-theme"] = {
    commands = { "colorscheme" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2E\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0*neovim_configuration.plugins.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/gruvbox-material"
  },
  ["hop.nvim"] = {
    commands = { "HopChar1", "HopChar2", "HopLine", "HopWord" },
    config = { "\27LJ\1\2@\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0%neovim_configuration.plugins.hop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  kommentary = {
    config = { "\27LJ\1\2G\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0,neovim_configuration.plugins.kommentary\frequire\0" },
    keys = { { "n", "<leader>cc" }, { "n", "<leader>c" }, { "v", "<leader>c" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/kommentary"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)neovim_configuration.plugins.lspkind\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/lspkind-nvim"
  },
  ["material.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/material.nvim"
  },
  ["mkdir.nvim"] = {
    commands = { "w" },
    config = { "\27LJ\1\2%\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\nmkdir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/mkdir.nvim"
  },
  ["monochrome.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/monochrome.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2F\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0+neovim_configuration.plugins.autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-base16"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-base16"
  },
  ["nvim-compe"] = {
    after_files = { "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\1\2B\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0'neovim_configuration.plugins.compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-fzf"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-fzf"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2F\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0+neovim_configuration.plugins.lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2G\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0,neovim_configuration.plugins.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)neovim_configuration.plugins.project\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/project.nvim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\1\2E\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0*neovim_configuration.plugins.surround\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/surround.nvim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\1\2F\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0+neovim_configuration.plugins.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermNew" },
    config = { "\27LJ\1\2E\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0*neovim_configuration.plugins.floaterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-fugitive"] = {
    commands = { "Git" },
    config = { "\27LJ\1\2\v\0\0\1\0\0\0\1G\0\1\0\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    commands = { "HexokinaseToggle" },
    config = { "\27LJ\1\2G\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0,neovim_configuration.plugins.hexokinase\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-hexokinase"
  },
  ["vim-moonfly-colors"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-moonfly-colors"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-nightfly-guicolors"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["wilder.nvim"] = {
    config = { "\27LJ\1\2C\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0(neovim_configuration.plugins.wilder\frequire\0" },
    keys = { { "", ":" }, { "", "?" }, { "", "/" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/wilder.nvim"
  },
  ["winshift.nvim"] = {
    commands = { "WinShift" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/winshift.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: kommentary
time([[Setup for kommentary]], true)
try_loadstring("\27LJ\1\2D\0\0\2\0\3\0\0054\0\0\0007\0\1\0)\1\1\0:\1\2\0G\0\1\0'kommentary_create_default_mappings\6g\bvim\0", "setup", "kommentary")
time([[Setup for kommentary]], false)
-- Setup for: symbols-outline.nvim
time([[Setup for symbols-outline.nvim]], true)
try_loadstring("\27LJ\1\2L\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0001neovim_configuration.plugins.symbols-outline\frequire\0", "setup", "symbols-outline.nvim")
time([[Setup for symbols-outline.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopChar1 lua require("packer.load")({'hop.nvim'}, { cmd = "HopChar1", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopWord lua require("packer.load")({'hop.nvim'}, { cmd = "HopWord", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopChar2 lua require("packer.load")({'hop.nvim'}, { cmd = "HopChar2", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FzfLua lua require("packer.load")({'fzf-lua'}, { cmd = "FzfLua", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file WinShift lua require("packer.load")({'winshift.nvim'}, { cmd = "WinShift", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file w lua require("packer.load")({'mkdir.nvim'}, { cmd = "w", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file colorscheme lua require("packer.load")({'Catppuccino.nvim', 'github-nvim-theme'}, { cmd = "colorscheme", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopLine lua require("packer.load")({'hop.nvim'}, { cmd = "HopLine", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HexokinaseToggle lua require("packer.load")({'vim-hexokinase'}, { cmd = "HexokinaseToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[vnoremap <silent> <leader>c <cmd>lua require("packer.load")({'kommentary'}, { keys = "<lt>leader>c", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>cc <cmd>lua require("packer.load")({'kommentary'}, { keys = "<lt>leader>cc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ? <cmd>lua require("packer.load")({'wilder.nvim'}, { keys = "?", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> : <cmd>lua require("packer.load")({'wilder.nvim'}, { keys = ":", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>c <cmd>lua require("packer.load")({'kommentary'}, { keys = "<lt>leader>c", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> / <cmd>lua require("packer.load")({'wilder.nvim'}, { keys = "/", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "php" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au User load_nightfly_theme ++once lua require("packer.load")({'vim-nightfly-guicolors'}, { event = "User load_nightfly_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_github_theme ++once lua require("packer.load")({'github-nvim-theme'}, { event = "User load_github_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_codeschool_theme ++once lua require("packer.load")({'codeschool.nvim'}, { event = "User load_codeschool_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_gruvbox-material_theme ++once lua require("packer.load")({'gruvbox-material'}, { event = "User load_gruvbox-material_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_base16_theme ++once lua require("packer.load")({'nvim-base16'}, { event = "User load_base16_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_catppuccino_theme ++once lua require("packer.load")({'Catppuccino.nvim'}, { event = "User load_catppuccino_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_material_theme ++once lua require("packer.load")({'material.nvim'}, { event = "User load_material_theme" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'feline.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au User load_fzf_plugin ++once lua require("packer.load")({'nvim-fzf'}, { event = "User load_fzf_plugin" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'surround.nvim', 'nvim-treesitter', 'gitsigns.nvim', 'nvim-lspconfig', 'bufferline.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au User load_moonfly_theme ++once lua require("packer.load")({'vim-moonfly-colors'}, { event = "User load_moonfly_theme" }, _G.packer_plugins)]]
vim.cmd [[au User load_monochrome_theme ++once lua require("packer.load")({'monochrome.nvim'}, { event = "User load_monochrome_theme" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs', 'nvim-compe', 'lspkind-nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au User load_project_plugin ++once lua require("packer.load")({'project.nvim'}, { event = "User load_project_plugin" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
