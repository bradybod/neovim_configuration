local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>cb"] = {
      "<cmd> CMakeBuild <CR>",
      "Run CMakeBuild",
    },
    ["<leader>cr"] = {
      "<cmd> CMakeRun <CR>",
      "Run CMake",
    },
    ["<leader>cd"] = {
      "<cmd> CMakeDebug <CR>",
      "Run CMakeDebug",
    },
  }
}

M.neo = {
  plugin = true,
  n ={
    ["<leader>gn"] = {
      "<cmd> Neogen <CR>",
      "Run NeoGen",
    },
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

return M
