return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
    { "<leader>am", "<cmd>CodeCompanionSelectModel<cr>", mode = { "n", "v" }, desc = "AI Model" },
    { "<leader>ad", "<cmd>CodeCompanionSelectAdapter<cr>", mode = { "n", "v" }, desc = "AI Adapter" },
    { "<leader>as", "<cmd>CodeCompanionShowConfig<cr>", mode = { "n", "v" }, desc = "AI Status" },
  },
  config = function()
    local state = {
      adapter = "openrouter",
      model = "google/gemini-2.5-flash-lite",
    }

    local openrouter_models = {
      "openai/gpt-5.4-mini",
      "qwen/qwen3.6-plus",
      "google/gemini-2.5-flash-lite",
      "anthropic/claude-opus-4.6",
    }

    local function setup_codecompanion()
      require("codecompanion").setup({
        adapters = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openrouter", {
              env = {
                api_key = vim.env.OPENROUTER_API_KEY,
              },
              schema = {
                model = {
                  default = state.model,
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = state.adapter },
          inline = { adapter = state.adapter },
        },
      })
    end

    local function show_current_codecompanion_config()
      vim.notify(("CodeCompanion adapter: %s | model: %s"):format(state.adapter, state.model))
    end

    local function reload_codecompanion()
      setup_codecompanion()
      vim.notify(("CodeCompanion reloaded with %s (%s)"):format(state.adapter, state.model))
    end

    local function select_openrouter_model()
      vim.ui.select(openrouter_models, { prompt = "Select CodeCompanion model" }, function(choice)
        if not choice then
          return
        end
        state.model = choice
        reload_codecompanion()
      end)
    end

    local function select_codecompanion_adapter()
      vim.ui.select({ "openrouter" }, { prompt = "Select CodeCompanion adapter" }, function(choice)
        if not choice then
          return
        end
        state.adapter = choice
        reload_codecompanion()
      end)
    end

    setup_codecompanion()

    pcall(vim.api.nvim_del_user_command, "CodeCompanionSelectModel")
    pcall(vim.api.nvim_del_user_command, "CodeCompanionSelectAdapter")
    pcall(vim.api.nvim_del_user_command, "CodeCompanionShowConfig")

    vim.api.nvim_create_user_command("CodeCompanionSelectModel", select_openrouter_model, {})
    vim.api.nvim_create_user_command("CodeCompanionSelectAdapter", select_codecompanion_adapter, {})
    vim.api.nvim_create_user_command("CodeCompanionShowConfig", show_current_codecompanion_config, {})

    vim.cmd([[cab cc CodeCompanion]])
  end,
}
