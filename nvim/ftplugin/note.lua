-- Shim for note.nvim, sourced before its own ftplugin/note.lua because the
-- config directory comes first in 'runtimepath'.
--
-- note.nvim calls `require("nvim-treesitter.parsers").has_parser()`, an API that
-- nvim-treesitter's `main` branch removed, and it does not guard that call — so
-- opening a .note file throws. Provide the function through a metatable on the
-- parsers module, which keeps it out of `pairs()` so the parser registry stays
-- clean (no bogus "has_parser" entry in `:TSInstall` completion).
local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ok or type(parsers) ~= "table" or parsers.has_parser then
  return
end

local prev = getmetatable(parsers)
setmetatable(parsers, {
  __index = function(t, key)
    if key == "has_parser" then
      return function(lang)
        lang = lang or vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
        return (pcall(vim.treesitter.language.inspect, lang))
      end
    end
    if prev and prev.__index then
      return prev.__index(t, key)
    end
  end,
  __newindex = prev and prev.__newindex or nil,
})
