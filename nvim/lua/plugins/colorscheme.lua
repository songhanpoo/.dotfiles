return {
  -- 🌒 1. Add and Configure the Nordic Theme
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bold_keywords = false,
      italic_comments = true,
      reduced_blue = true, -- Softens the harsh base Nord blues slightly
      on_highlight = function(highlights, palette)
        -- 🌟 FIXED: Explicit bright hex background selection that works with transparency
        highlights.Visual = { bg = "#4c566a", fg = "none", bold = true }

        -- Your existing custom telescope styling
        highlights.TelescopePromptTitle = {
          fg = palette.red.bright,
          bg = palette.green.base,
          italic = true,
          underline = true,
          sp = palette.yellow.dim,
          undercurl = false,
        }
      end,

      -- 🧊 Configure Nordic's native decoupled transparency engine
      transparent = {
        bg = true, -- Strips out primary layout backgrounds
        float = true, -- Strips out standard float backgrounds
      },
    },
    config = function(_, opts)
      -- Setup options using nordic's interface
      require("nordic").setup(opts)

      -- Safe activation step once fully registered
      vim.cmd.colorscheme("nordic")
    end,
  },
  -- 🚀 2. Tell LazyVim Core to lock onto Onedarkpro
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
  -- 🌪️ 2. Central Workspace Hook to force transparency across your UI & Explorer
  {
    "nvim-lspconfig",
    init = function()
      -- Establish global brightness utility script
      _G.is_hex_color_light = function(color)
        local raw_color = color:gsub("#", ""):gsub("%s+", "")
        local red = tonumber(raw_color:sub(1, 2), 16) or 0
        local green = tonumber(raw_color:sub(3, 4), 16) or 0
        local blue = tonumber(raw_color:sub(5, 6), 16) or 0
        local brightness = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        return brightness > 155
      end

      -- Clear solid background elements dynamically for Nordic
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl_groups = {
            -- Core Workspace Elements
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "SignColumn",
            "StatusLine",
            "StatusLineNC",
            "WinBar",
            "WinBarNC",
            "WinSeparator",
            "MsgArea",
            "EndOfBuffer",

            -- 🍿 Snacks Explorer & Picker Layers
            "SnacksNormal",
            "SnacksNormalNC",
            "SnacksFloatNormal",
            "SnacksFloatBorder",
            "SnacksLayoutBox",
            "SnacksPicker",
            "SnacksPickerBorder",
            "SnacksPickerList",
            "SnacksPickerTree", -- Strips sidebar file explorer node backgrounds

            -- Overlays & Menus
            "TelescopeNormal",
            "TelescopeBorder",
            "LeaderGuide",
            "WhichKeyFloat",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
          }

          for _, group in ipairs(hl_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE", force = true })
          end
        end,
      })
    end,
  },
}
