-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
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
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\1\2A\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0&CONFIG.PLUGINS.dashboard.bindings\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/dashboard-nvim"
  },
  ["emmet-vim"] = {
    config = { "\27LJ\1\2:\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\31CONFIG.PLUGINS.emmet.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  everforest = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/everforest"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { '\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.gitsigns.setup\frequire\0' },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    commands = { "HopChar1" },
    config = { "\27LJ\1\2`\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0 CONFIG.PLUGINS.hop.bindings\29CONFIG.PLUGINS.hop.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  kommentary = {
    config = { "\27LJ\1\2n\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0'CONFIG.PLUGINS.kommentary.bindings$CONFIG.PLUGINS.kommentary.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\1\2<\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0!CONFIG.PLUGINS.lspkind.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/lspkind-nvim"
  },
  neon = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\1\2>\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.neoscroll.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim"
  },
  ["neovim-ayu"] = {
    config = { '\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.nvim-ayu.setup\frequire\0' },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/neovim-ayu"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/night-owl.vim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)CONFIG.PLUGINS.nvim-bufferline.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-compe"] = {
    after_files = { "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\1\2:\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\31CONFIG.PLUGINS.compe.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.treesitter.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_context_vt = {
    config = { "\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)CONFIG.PLUGINS.nvim_context_vt.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim_context_vt"
  },
  ["omni.vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/omni.vim"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["packer.nvim"] = {
    config = { "\27LJ\1\2>\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.packer.bindings\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["photon.vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/photon.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  rnvimr = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["srcery-vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/srcery-vim"
  },
  ["symbols-outline.nvim"] = {
    config = { "\27LJ\1\2x\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0,CONFIG.PLUGINS.symbols-outline.bindings)CONFIG.PLUGINS.symbols-outline.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\2l\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0&CONFIG.PLUGINS.telescope.bindings#CONFIG.PLUGINS.telescope.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.tokyonight.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleToggle" },
    config = { "\27LJ\1\2h\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.trouble.bindings!CONFIG.PLUGINS.trouble.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-code-dark"
  },
  ["vim-floaterm"] = {
    config = { '\27LJ\1\2j\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0%CONFIG.PLUGINS.floaterm.bindings"CONFIG.PLUGINS.floaterm.setup\frequire\0' },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\1\2@\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0%CONFIG.PLUGINS.fugitive.bindings\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    config = { "\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.hexokinase.setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-hexokinase"
  },
  ["vim-kitty"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-kitty"
  },
  ["vim-nix"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/vim-nix"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\1\2f\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.rooter.bindings CONFIG.PLUGINS.rooter.setup\frequire\0" },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["which-key.nvim"] = {
    config = { '\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.whichkey.setup\frequire\0' },
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: dashboard-nvim
time([[Setup for dashboard-nvim]], true)
try_loadstring("\27LJ\1\2>\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.dashboard.setup\frequire\0", "setup", "dashboard-nvim")
time([[Setup for dashboard-nvim]], false)
time([[packadd for dashboard-nvim]], true)
vim.cmd [[packadd dashboard-nvim]]
time([[packadd for dashboard-nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)CONFIG.PLUGINS.nvim-bufferline.setup\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.treesitter.setup\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: emmet-vim
time([[Config for emmet-vim]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\31CONFIG.PLUGINS.emmet.setup\frequire\0", "config", "emmet-vim")
time([[Config for emmet-vim]], false)
-- Config for: symbols-outline.nvim
time([[Config for symbols-outline.nvim]], true)
try_loadstring("\27LJ\1\2x\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0,CONFIG.PLUGINS.symbols-outline.bindings)CONFIG.PLUGINS.symbols-outline.setup\frequire\0", "config", "symbols-outline.nvim")
time([[Config for symbols-outline.nvim]], false)
-- Config for: vim-rooter
time([[Config for vim-rooter]], true)
try_loadstring("\27LJ\1\2f\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.rooter.bindings CONFIG.PLUGINS.rooter.setup\frequire\0", "config", "vim-rooter")
time([[Config for vim-rooter]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring('\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.whichkey.setup\frequire\0', "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\1\2@\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0%CONFIG.PLUGINS.fugitive.bindings\frequire\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\1\2l\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0&CONFIG.PLUGINS.telescope.bindings#CONFIG.PLUGINS.telescope.setup\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\1\2>\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0#CONFIG.PLUGINS.packer.bindings\frequire\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: neovim-ayu
time([[Config for neovim-ayu]], true)
try_loadstring('\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.nvim-ayu.setup\frequire\0', "config", "neovim-ayu")
time([[Config for neovim-ayu]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring('\27LJ\1\2=\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0"CONFIG.PLUGINS.gitsigns.setup\frequire\0', "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim_context_vt
time([[Config for nvim_context_vt]], true)
try_loadstring("\27LJ\1\2D\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0)CONFIG.PLUGINS.nvim_context_vt.setup\frequire\0", "config", "nvim_context_vt")
time([[Config for nvim_context_vt]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\1\2n\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0'CONFIG.PLUGINS.kommentary.bindings$CONFIG.PLUGINS.kommentary.setup\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring('\27LJ\1\2j\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\1G\0\1\0%CONFIG.PLUGINS.floaterm.bindings"CONFIG.PLUGINS.floaterm.setup\frequire\0', "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$CONFIG.PLUGINS.tokyonight.setup\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\1\2A\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0&CONFIG.PLUGINS.dashboard.bindings\frequire\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file HopChar1 lua require("packer.load")({'hop.nvim'}, { cmd = "HopChar1", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType kitty ++once lua require("packer.load")({'vim-kitty'}, { ft = "kitty" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType nix ++once lua require("packer.load")({'vim-nix'}, { ft = "nix" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "php" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-hexokinase'}, { ft = "html" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-compe'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'lspkind-nvim', 'neoscroll.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/a/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]], true)
vim.cmd [[source /home/a/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]]
time([[Sourcing ftdetect script at: /home/a/.local/share/nvim/site/pack/packer/opt/vim-nix/ftdetect/nix.vim]], false)
time([[Sourcing ftdetect script at: /home/a/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]], true)
vim.cmd [[source /home/a/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]]
time([[Sourcing ftdetect script at: /home/a/.local/share/nvim/site/pack/packer/opt/vim-kitty/ftdetect/kitty.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
