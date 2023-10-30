-- colorscheme rotator
-- local date = os.time()
-- local day2year = 365.242            -- days in a year
-- local sec2hour = 60 * 60            -- seconds in an hour
-- local sec2day = sec2hour * 24       -- seconds in a day
-- local sec2week = sec2day * 7
-- local sec2year = sec2day * day2year -- seconds in a year
-- week
-- local week = date % sec2year / sec2week
-- week = math.ceil(week)

-- local colorschemeArray = { "gruvbox", "monokai_soda", "slate", "aurora" }
-- local index = week % #colorschemeArray
-- local index = date % #colorschemeArray
-- lvim.colorscheme = colorschemeArray[index + 1]
lvim.colorscheme = "aurora"
vim.g.aurora_transparent = 1
vim.g.aurora_bold = 1
vim.g.aurora_darker = 1

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
vim.opt.colorcolumn = "120"
--

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "goimports" },
  { name = "fixjson" },
  {
    name = "markdown_toc",
    filetypes = { "markdown", "vimwiki" },
  },
  {
    name = "markdownlint",
    filetypes = { "markdown", "vimwiki" },
  },
  { name = "sqlfmt" },
  { name = "buf" },
}
--

-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "codespell" },
  { name = "jsonlint" },
  { name = "golangci_lint" },
  {
    name = "markdownlint",
    filetypes = { "markdown", "vimwiki" },
  },
  { name = "buf" },
}
--

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- Centers cursor when moving 1/2 page down
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
-- Remap save key so we can use vimwiki default mappings
lvim.builtin.which_key.mappings['w'] = {}
lvim.builtin.which_key.mappings['W'] = { ":w<CR>", "Save" }
-- Remap LSP keys to use goto-preview as default
lvim.lsp.buffer_mappings.normal_mode['gpd'] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
  "Show documentation" }
lvim.lsp.buffer_mappings.normal_mode['gpi'] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
  "Show implementation" }
lvim.lsp.buffer_mappings.normal_mode['gpc'] = { "<cmd>lua require('goto-preview').close_all_win()<CR>",
  "Close all windows" }
lvim.lsp.buffer_mappings.normal_mode['<C-k>'] = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
  "Show type definition" }
lvim.lsp.buffer_mappings.normal_mode['gpr'] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
  "Show references" }



-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
--

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.size = vim.o.columns * 0.4
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 50

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "json",
  "lua",
  "yaml",
  "go",
  "sql",
  "proto",
}

-- Additional Plugins
lvim.plugins = {
  { "vimwiki/vimwiki" },
  { "leoluz/nvim-dap-go" },
  { "MattesGroeger/vim-bookmarks" },
  { "vim-test/vim-test" },
  { "folke/todo-comments.nvim" },
  { "tyru/open-browser.vim" },
  { "aklt/plantuml-syntax" },
  { "weirongxu/plantuml-previewer.vim" },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  { "ray-x/lsp_signature.nvim" },
  { "phaazon/hop.nvim" },
  { "ryanoasis/vim-devicons" },
  { "ray-x/aurora" },
  {
    'wfxr/minimap.vim',
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,             -- Width of the floating window
        height = 40,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false,           -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil     -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
      }
    end
  },
}

-- hop
require "hop".setup({ keys = "asdfjkl;" })
lvim.builtin.which_key.mappings["h"] = {
  name = "HOP",
  h = { "<cmd>HopChar2<cr>", "HOP with 2 chars" },
}

-- lsp_signature
local cfg = {} -- add your config here
require "lsp_signature".setup(cfg)

-- vimwiki
vim.g.vimwiki_list = { { path = "~/vimwiki/", syntax = "markdown", ext = ".md" } }

-- Debugger
-- https://github.com/leoluz/nvim-dap-go
require "dap-go".setup()

lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require'dap-go'.debug_test()<cr>", "Start" },
  q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Specture - Search and Replace",
  o = { "<cmd>lua require'spectre'.open()<cr>", "Open Spectre" },
  w = { "<cmd>lua require'spectre'.open_visual({select_word=true})<CR>", "Search current word" },
}

-- Todo
require("todo-comments").setup()

lvim.builtin.which_key.mappings["T"] = {
  name = "Todo",
  T = { "<cmd>TodoTelescope<cr>", "View todo's in telescope" },
}



-- Test
lvim.builtin.which_key.mappings["t"] = {
  name = "Testing",
  n = { "<cmd>TestNearest<cr>", "Nearest" },
  f = { "<cmd>TestFile<cr>", "File" },
  s = { "<cmd>TestSuite<cr>", "Suite" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "**/diary.md" },
  -- generate diary links
  command = "VimwikiDiaryGenerateLinks",
})

-- goto-preview
