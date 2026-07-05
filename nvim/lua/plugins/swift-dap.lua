return {
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
}
