" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/breton/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/breton/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/breton/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/breton/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/breton/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/breton/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  rnvimr = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-base16-colorschemes"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/vim-base16-colorschemes"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/breton/.local/share/nvim/site/pack/packer/start/vista.vim"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
