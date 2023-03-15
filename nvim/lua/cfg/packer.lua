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
        as = "onedark",
        config = function()
            vim.cmd("colorscheme onedark")
        end
    })

    if vim.g.vscode then

    else
        use("nvim-lualine/lualine.nvim")
        use("ThePrimeagen/vim-be-good")
        use("alec-gibson/nvim-tetris")
        use({
            "nvim-telescope/telescope.nvim",
            config = function()
                local telescope = require("telescope.builtin")

                vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
                vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
                vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
                vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
            end
        })
        use {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v1.x",
            requires = {
                -- LSP Support
                { "neovim/nvim-lspconfig" },
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
            },
            config = function()
                require("cfg.lsp")
            end
        }
    end


    if packer_bootstrap then
        require("packer").sync()
        vim.cmd([[autocmd User PackerComplete ++once lua require("cfg.setup")]])
    else
        require("cfg.setup")
    end
end)
