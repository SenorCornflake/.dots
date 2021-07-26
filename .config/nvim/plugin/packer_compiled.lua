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
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["awesome-vim-colorschemes"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/awesome-vim-colorschemes"
  },
  ["buftabline.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/buftabline.nvim"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  neon = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/night-owl.vim"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-base16"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/a/.local/share/nvim/site/pack/packer/opt/packer.nvim"
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
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-code-dark"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-kitty"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-nix"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/a/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
