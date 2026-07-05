-- 🍎 Xcode build system
return {
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
    })
  end,
}
