local cmp = require "plugins.configs.cmp"
local plugins = {
    {
        "David-Kunz/gen.nvim",
        event = "VeryLazy",
        -- Custom Parameters (with defaults)
            opts = {
                --model = "deepseek-coder:6.7b",
                model = "deepseek-coder:latest",
                --model = "mistral:instruct", -- The default model to use.
                --model = "codellama", -- The default model to use.
                host = "localhost", -- The host running the Ollama service.
                port = "11434", -- The port on which the Ollama service is listening.
                display_mode = "split", -- The display mode. Can be "float" or "split".
                show_prompt = false, -- Shows the Prompt submitted to Ollama.
                show_model = false, -- Displays which model you are using at the beginning of your chat session.
                quit_map = "q", -- set keymap for quit
                no_auto_close = true, -- Never closes the window automatically.
                init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
                -- Function to initialize Ollama
                command = function(options)
                    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
                end,
                -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
                -- This can also be a command string.
                -- The executed command must return a JSON object with { response, context }
                -- (context property is optional).
                -- list_models = '<omitted lua function>', -- Retrieves a list of model names
                debug = false -- Prints errors and the command which is run.
            },
                config = function(_, opts)
                    require("gen").setup(opts)
                end,
  },
  {
    "danymat/neogen",
    event = "VeryLazy",
    config ={ 
      enabled = true,
      require("core.utils").load_mappings("neo")
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy",
    opts = {
        cmake_build_directory = "build",
        cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" }
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      }
    },
  },
  {
    "mfussenegger/nvim-dap",
     config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.rustaceanvim"
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('plugins.configs.cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
    ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "lua-language-server",
        "rust-analyzer",
      }
    }
  }
}
return plugins
