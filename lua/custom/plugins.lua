local plugins = {
  {
    "David-Kunz/gen.nvim",
    event = "VeryLazy",
   -- opts = {
   --     model = "mistral", -- The default model to use.
   --     host = "localhost", -- The host running the Ollama service.
   --     port = "11434", -- The port on which the Ollama service is listening.
   --     quit_map = "q", -- set keymap for close the response window
   --     retry_map = "<c-r>", -- set keymap to re-send the current prompt
   --     init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
   --     -- Function to initialize Ollama
   --     command = function(options)
   --         local body = {model = options.model, stream = true}
   --         return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
   --     end,
   --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
   --     -- This can also be a command string.
   --     -- The executed command must return a JSON object with { response, context }
   --     -- (context property is optional).
   --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
   --     display_mode = "float", -- The display mode. Can be "float" or "split".
   --     show_prompt = false, -- Shows the prompt submitted to Ollama.
   --     show_model = false, -- Displays which model you are using at the beginning of your chat session.
   --     no_auto_close = false, -- Never closes the window automatically.
   --     debug = false -- Prints errors and the command which is run.
   -- },
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  --{
  --  "nomnivore/ollama.nvim",
  --  event = "VeryLazy",
  --  dependencies = {
  --    "nvim-lua/plenary.nvim",
  --  },  
  --  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  --},
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = true,
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
    "williamboman/mason.nvim",
    opts = {
    ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
      }
    }
  }
}
return plugins
