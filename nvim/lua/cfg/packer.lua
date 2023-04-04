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
	use({
		"navarasu/onedark.nvim",
		as = "onedark"
	})
	use("ThePrimeagen/vim-be-good")
	use("alec-gibson/nvim-tetris")
	use("linrongbin16/lsp-progress.nvim")
	use("nvim-telescope/telescope.nvim")

	-- Git
	use("tpope/vim-fugitive")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("simrat39/rust-tools.nvim")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		}
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
