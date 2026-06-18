vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.wildmenu = true
vim.opt.number = true -- Shows absolute line number on the current line
vim.opt.relativenumber = true -- Shows relative line numbers on all other lines

vim.pack.add(
    {
        {
            src = "https://github.com/nvim-mini/mini.icons"
        },
        {
            src = "https://github.com/nvim-mini/mini.pairs"
        },
        {
            src = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
        },
        {
            src = "https://github.com/nvim-mini/mini.pick"
        },
        {
            src = "https://github.com/Saghen/blink.cmp",
            version = vim.version.range("1")
        },
        {
            src = "https://github.com/sainnhe/everforest"
        }
    }
)
require("mini.pairs").setup()
require("render-markdown").setup(
    {
        completions = {blink = {enabled = true}},
        heading = {
            enabled = true,
            icons = {"", "", "", "", "", ""},
            width = "block",
            position = "eol"
        }
    }
)
require("mini.pick").setup(
    {
        source = {items = vim.fn.readdir(".")}
    }
)
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme everforest")

vim.lsp.enable(
    {
        "clangd"
    }
)

vim.diagnostic.config(
    {
        -- 1. Enable end-of-line messages
        virtual_text = {
            spacing = 4, -- Distance (in spaces) from the end of your code
            severity_sort = true -- Puts critical errors before minor warnings
        },
        -- 2. Disable under-the-line messages (if previously enabled)
        virtual_lines = false,
        -- 3. Additional helpful visual aids
        underline = false, -- Add a squiggly underline directly under the broken code
        signs = true -- Show warning/error icons in the left side gutter
    }
)

vim.lsp.inlay_hint.enable(true)
require("blink.cmp").setup(
    {
        --keymap = {preset = 'super-tab'},
        keymap = {
            preset = "default",
            ["<CR>"] = {"select_and_accept", "fallback"},
            --['<Esc>'] = { 'cancel', 'fallback' },
            ["<Esc>"] = {
                function(cmp)
                    cmp.cancel()
                    return false
                end,
                "fallback"
            },
            ["<Tab>"] = {"select_next", "fallback"},
            ["<S-Tab>"] = {"select_prev", "fallback"}
        },
        signature = {
            enabled = true,
            window = {
                show_documentation = true,
                treesitter_highlighting = true
            }
        },
        completion = {
            accept = {
                auto_brackets = {enabled = true}
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false
                }
            },
            documentation = {
                auto_show = true
            }
        },
        sources = {
            default = {"lsp", "path", "buffer"}
        }
    }
)
vim.keymap.set(
    "n",
    "<Leader><Leader>",
    function()
        local ok, pick = pcall(require, "mini.pick")
        if ok then
            pick.builtin.files()
        else
            vim.notify("mini.pick plugin is not loaded.", vim.log.levels.ERROR)
        end
    end,
    {desc = "Pick Files (double leader)"}
)
vim.keymap.set(
    "n",
    "<Leader>ts",
    function()
        local ok, pick = pcall(require, "mini.pick")
        if ok then
            pick.builtin.grep_live()
        else
            vim.notify("mini.pick plugin is not loaded.", vim.log.levels.ERROR)
        end
    end,
    {desc = "Grep live (Leader + t + s)"}
)
