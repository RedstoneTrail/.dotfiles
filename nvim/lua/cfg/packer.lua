local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("ggandor/leap.nvim")
	use("ThePrimeagen/vim-be-good")
	use({
		"catppuccin/nvim",
		as = "catppuccin"
	})
	use("alec-gibson/nvim-tetris")
	use("tpope/vim-commentary")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		}
	})

	-- Git
	use("tpope/vim-fugitive")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/mason-lspconfig.nvim")
	use("williamboman/mason.nvim")

	use("simrat39/rust-tools.nvim")
	use("folke/neodev.nvim")
	use("j-hui/fidget.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/playground")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
