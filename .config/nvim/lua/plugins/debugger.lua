return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
      },
      -- Python adapter
      "mfussenegger/nvim-dap-python",
      -- JavaScript/TypeScript adapter
      "microsoft/vscode-js-debug",
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = { "microsoft/vscode-js-debug" },
      },
      -- Ruby adapter
      "suketa/nvim-dap-ruby",
      -- Virtual text for DAP
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local virtual_text = require("nvim-dap-virtual-text")

      -- Basic DAP setup
      virtual_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })

      -- Configure DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
      })

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymappings
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Debug: Set Log Point" })
      vim.keymap.set("n", "<leader>dT", dap.terminate, { desc = "Debug: Terminate" })
      vim.keymap.set("n", "<leader>dD", function()
        dap.disconnect({ terminateDebuggee = false })
      end, { desc = "Debug: Detach (No Terminate)" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: Open REPL" })
      vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Debug: Toggle UI" })

      -- -- focus dap watch panel
      -- vim.keymap.set("n", "<leader>dw", function()
      --   dapui.elements.watches.focus()
      -- end, { desc = "Debug: Focus Watches" })

      -- clear all breakpoints
      vim.keymap.set("n", "<leader>dR", function()
        dap.clear_breakpoints()
        vim.notify("All breakpoints cleared", vim.log.levels.INFO)
      end, { desc = "Debug: Clear All Breakpoints" })

      -- attach to debugger, prompt for port number
      vim.keymap.set("n", "<leader>da", function()
        local port = vim.fn.input("Port: ")

        vim.notify("Attempting to connect to Ruby debugger on port " .. port, vim.log.levels.INFO)
        dap.run({
          type = "ruby",
          name = "Attach to Ruby",
          request = "attach",
          localfs = true,
          port = port,
          server = "127.0.0.1",
          options = {
            source_filetype = 'ruby',
          },
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Debug: Attach to Ruby" })

      dap.configurations.ruby = {
        -- Configuration for attaching to Rails API server
        {
          type = 'ruby',
          name = 'Attach Rails API',
          request = 'attach',
          localfs = true,
          port = 7000,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          cwd = vim.fn.getcwd(),
        },
        -- Configuration for attaching to Sidekiq worker
        {
          type = 'ruby',
          name = 'Attach Sidekiq Worker',
          request = 'attach',
          localfs = true,
          port = 7001,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          cwd = vim.fn.getcwd(),
        }
      }

      -- Python adapter setup
      -- require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

      -- Ruby adapter setup
      require("dap-ruby").setup()

      -- -- Add error handling for debugging issues
      -- dap.listeners.after.event_error["dapui_config"] = function(_, body)
      --   vim.notify("DAP Error: " .. vim.inspect(body), vim.log.levels.ERROR)
      -- end
      --
      -- -- Add custom handler for source file resolution
      -- dap.listeners.before.loadedSources["dapui_sources"] = function(session, body)
      --   vim.notify("DAP Sources Loaded: " .. vim.inspect(body), vim.log.levels.DEBUG)
      -- end
      --
      -- -- Add custom handler for breakpoint verification
      -- dap.listeners.after.breakpointValidated["breakpoint_feedback"] = function(_, body)
      --   vim.notify("Breakpoint validated: " .. vim.inspect(body), vim.log.levels.INFO)
      -- end
      --
      -- -- Add custom handler for breakpoint verification failures
      -- dap.listeners.after.breakpointError["breakpoint_error"] = function(_, body)
      --   vim.notify("Breakpoint error: " .. vim.inspect(body), vim.log.levels.ERROR)
      -- end

      -- -- TypeScript/JavaScript adapter setup
      -- require("dap-vscode-js").setup({
      --   -- node_path = "node", -- Path to node executable
      --   debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      --   adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      -- })

      -- Configure TypeScript/React debugger
      -- for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      --   dap.configurations[language] = {
      --     -- Debug React web application
      --     {
      --       type = "pwa-chrome",
      --       request = "launch",
      --       name = "Launch Chrome against localhost",
      --       url = "http://localhost:3000",
      --       webRoot = "${workspaceFolder}",
      --       userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
      --     },
      --     -- Attach to running Chrome debugger
      --     {
      --       type = "pwa-chrome",
      --       request = "attach",
      --       name = "Attach to Chrome",
      --       port = 9222,
      --       webRoot = "${workspaceFolder}",
      --     },
      --     -- Debug Node.js backend
      --     {
      --       type = "pwa-node",
      --       request = "launch",
      --       name = "Launch Node.js Program",
      --       program = "${file}",
      --       cwd = "${workspaceFolder}",
      --       sourceMaps = true,
      --     },
      --     -- Attach to running Node process
      --     {
      --       type = "pwa-node",
      --       request = "attach",
      --       name = "Attach to Node Process",
      --       processId = require("dap.utils").pick_process,
      --     },
      --   }
      -- end
    end,
  },
}
