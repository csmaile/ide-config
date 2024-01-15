return {
  -- 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = require("config.theme").theme,
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end,
  },

  -- 状态栏
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = require("config.theme").lualine,
    config = function ()
      vim.api.nvim_create_autocmd({"QuitPre"}, {
        callback = function() vim.cmd("NvimTreeClose") end,
      })
    end
  },

  -- 目录树
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- 快捷键
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = false,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("config.mappings").setup()
    end,
  },

  -- 窗口管理
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
    },
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
        autotag = {
          enable = true,
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
      })
    end
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    -- event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      { "mason.nvim", cmd = "Mason", config = false },
      { "williamboman/mason-lspconfig.nvim", config = false },
    },
    config = function ()
      require("config.lsp").setup()
    end
  },
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = "Mason",
  --   keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  --   build = ":MasonUpdate",
  --   opts = {
  --     ensure_installed = {
  --       "stylua",
  --       "shfmt",
  --       -- "flake8",
  --     },
  --   },
  --   --@param opts MasonSettings | {ensure_installed: string[]}
  --   config = function(_, opts)
  --     require("mason").setup(opts)
  --     local mr = require("mason-registry")
  --     mr:on("package:install:success", function()
  --       vim.defer_fn(function()
  --         -- trigger FileType event to possibly load this newly installed LSP server
  --         require("lazy.core.handler.event").trigger({
  --           event = "FileType",
  --           buf = vim.api.nvim_get_current_buf(),
  --         })
  --       end, 100)
  --     end)
  --     local function ensure_installed()
  --       for _, tool in ipairs(opts.ensure_installed) do
  --         local p = mr.get_package(tool)
  --         if not p:is_installed() then
  --           p:install()
  --         end
  --       end
  --     end
  --     if mr.refresh then
  --       mr.refresh(ensure_installed)
  --     else
  --       ensure_installed()
  --     end
  --   end,
  -- },


  -- 自动补全
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --   -- install jsregexp (optional!).
  --   build = "make install_jsregexp",
  --   dependencies = { "rafamadriz/friendly-snippets" },
  --   init = function()
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --   end
  -- },
  {
    'hrsh7th/nvim-cmp',
    -- event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",

      "rafamadriz/friendly-snippets",
    },
    config = function ()
      require("config/cmp").setup()
    end
  },
  
  -- 代码注释
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },

  -- 自动补全括号
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- buffer 分割线
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "famiu/bufdelete.nvim",
    },
    config = function ()
      require("bufferline").setup{
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
              or (e == "warning" and " " or "" )
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left"
          }
        },
        left_mouse_command = function(bufnum)
          require('bufdelete').bufdelete(bufnum, true)
        end

      }
    end
  }
}
