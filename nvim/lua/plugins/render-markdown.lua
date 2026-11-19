-- ✍️ Persistent markdown rendering for plain markdown files and ipynb.nvim
-- markdown cells (headings, links, lists, tables rendered in Notebook mode).
--
-- The `ipynb` filetype works because ipynb.nvim exposes markdown cells through
-- treesitter language injection, which render-markdown.nvim follows. The
-- notebook buffer must stay `filetype=ipynb` — switching it to `markdown` or
-- `ipynb.markdown` breaks the parser that finds cell boundaries.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "ipynb" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    overrides = {
      filetype = {
        ipynb = {
          -- Keep the cursor line rendered in the notebook facade, so moving
          -- through a markdown cell doesn't make it flicker back to raw text.
          anti_conceal = { enabled = false },
        },
      },
    },
    -- LaTeX rendering needs the `latex2text` binary from pylatexenc, which
    -- isn't installed. Enable this after `pip install pylatexenc`, otherwise
    -- every buffer with math in it reports a missing-executable error.
    latex = { enabled = false },
  },
}
