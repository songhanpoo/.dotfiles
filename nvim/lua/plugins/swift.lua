return {
  {
    "devswiftzone/swift.nvim",
    ft = "swift", -- Only load when opening a Swift file (keeps Neovim startup fast)
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim", -- Required if you want interactive target selectors
    },
    config = function()
      -- Initialize swift.nvim with standard configurations
      require("swift").setup({
        -- If you want your editor to automatically run swiftformat or swift-format when saving
        features = {
          formatting = {
            format_on_save = true,
          },
          linting = {
            lint_on_save = true,
          },
          project_detector = {
            show_notification = true, -- Displays a clear popup telling you what type of project it recognized
          },
        },
      })

      -- Keymaps configured safely to avoid conflicts with standard LazyVim maps
      local map = vim.keymap.set
      map("n", "<leader>Sb", "<cmd>SwiftBuild<cr>", { desc = "Swift: Build Project" })
      map("n", "<leader>Sr", "<cmd>SwiftRun<cr>", { desc = "Swift: Run Executable" })
      map("n", "<leader>St", "<cmd>SwiftTest<cr>", { desc = "Swift: Run Tests" })
      map("n", "<leader>ST", "<cmd>SwiftSelectTarget<cr>", { desc = "Swift: Select Active Target" })

      -- Debugging Keymaps (Toggles the built-in non-dap LLDB environment)
      map("n", "<F9>", "<cmd>SwiftBreakpointToggle<cr>", { desc = "Swift Debug: Toggle Breakpoint" })
      map("n", "<F5>", "<cmd>SwiftBuildAndDebug<cr>", { desc = "Swift Debug: Start/Continue" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    keys = {
      -- Group prefix description
      { "<leader>d", desc = "+Debug", mode = { "n" } },

      -- Keymaps using string commands
      { "<leader>dd", "<cmd>lua require('xcodebuild.integrations.dap').build_and_debug()<cr>", desc = "Build & Debug" },
      {
        "<leader>dr",
        "<cmd>lua require('xcodebuild.integrations.dap').debug_without_build()<cr>",
        desc = "Debug Without Building",
      },
      { "<leader>dt", "<cmd>lua require('xcodebuild.integrations.dap').debug_tests()<cr>", desc = "Debug Tests" },
      {
        "<leader>dT",
        "<cmd>lua require('xcodebuild.integrations.dap').debug_class_tests()<cr>",
        desc = "Debug Class Tests",
      },
      {
        "<leader>b",
        "<cmd>lua require('xcodebuild.integrations.dap').toggle_breakpoint()<cr>",
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>B",
        "<cmd>lua require('xcodebuild.integrations.dap').toggle_message_breakpoint()<cr>",
        desc = "Toggle Message Breakpoint",
      },
      {
        "<leader>dx",
        "<cmd>lua require('xcodebuild.integrations.dap').terminate_session()<cr>",
        desc = "Terminate Debugger",
      },
    },
    config = function()
      local xcodebuild = require("xcodebuild.integrations.dap")

      -- 🍏 Updated for Xcode 16+: codelldb path is removed completely.
      -- setup() now only takes an optional boolean to manage breakpoint loading.
      xcodebuild.setup(true)
    end,
  },
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      -- Group prefix description for which-key
      { "<leader>i", group = "iOS / XcodeBuild", mode = { "n" } },

      -- Conflict-free iOS shortcuts
      { "<leader>il", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Xcodebuild Logs" },
      { "<leader>ib", "<cmd>XcodebuildBuild<cr>", desc = "Build Project" },
      { "<leader>ir", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project" },
      { "<leader>ii", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", desc = "Reload SwiftUI Preview" },
      { "<leader>it", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
      { "<leader>id", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
      { "<leader>I", "<cmd>XcodebuildPicker<cr>", desc = "Show All Xcodebuild Actions" },
    },
    config = function()
      require("xcodebuild").setup({
        code_coverage = { enabled = true },
        -- 🍏 Added this here to automate showing your logs live
        logs = {
          auto_open_on_run_start = true,
          live_logs = true,
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- 🍏 Fixed: Installed missing required dependency to stop initialization crashes
    },
    lazy = true,
    config = function()
      require("dapui").setup({
        controls = {
          element = "repl",
          enabled = true,
        },
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        icons = { collapsed = "", expanded = "", current_frame = "" },
        layouts = {
          {
            elements = {
              { id = "stacks", size = 0.25 },
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 60,
          },
          {
            elements = {
              { id = "repl", size = 0.35 },
              { id = "console", size = 0.65 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
