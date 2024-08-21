-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.completion.codeium-vim" },
  -- { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.search.nvim-hlslens" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
  -- import/override with your plugins folder
}
