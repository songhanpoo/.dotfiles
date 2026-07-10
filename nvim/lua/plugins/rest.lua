return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    {
      "<leader>rr",
      function()
        require("kulala").run()
      end,
      desc = "Run HTTP Request under cursor",
    },
    {
      "<leader>ra",
      function()
        require("kulala").run_all()
      end,
      desc = "Run All HTTP Requests in file",
    },
    {
      "<leader>ri",
      function()
        require("kulala").inspect()
      end,
      desc = "Inspect raw cURL command",
    },
    {
      "<leader>rp",
      function()
        require("kulala").jump_prev()
      end,
      desc = "Jump to Previous Request",
    },
    {
      "<leader>rn",
      function()
        require("kulala").jump_next()
      end,
      desc = "Jump to Next Request",
    },
    {
      "<leader>co",
      function()
        require("kulala").copy()
      end,
      desc = "Copy Request as cURL",
    },
    {
      "<leader>ct",
      function()
        require("kulala").toggle_view()
      end,
      desc = "Toggle Response Headers/Body View",
    },
  },
  opts = {
    -- Automatically format the resulting JSON/HTML payloads
    response_format = {
      indent = 2,
    },
  },
}
