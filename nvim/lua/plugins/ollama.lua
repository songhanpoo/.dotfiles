return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  keys = {
    -- Keybind to open the interactive prompts menu (uses <c-u> to preserve selection context)
    { "<leader>oo", "<cmd>Ollama<cr>", desc = "Ollama Prompts Menu", mode = { "n", "v" } },
    { "<leader>om", "<cmd>OllamaModel<cr>", desc = "Select Ollama Model" },
  },
  opts = {
    -- Directs Neovim HTTP requests to your GPU-accelerated server
    url = "http://192.168.1.99:11434",

    model = "llama3.2",

    -- Disables autostarting a local server instance, since we are using your remote Instinct MI50
    serve = {
      on_start = false,
    },
  },
}
