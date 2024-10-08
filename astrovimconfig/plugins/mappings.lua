return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- navigate buffer tabs with `H` and `L`
          L = {
            function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
            desc = "Next buffer",
          },
          H = {
            function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
            desc = "Previous buffer",
          },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          ["<leader>ba"] = { ":%bd|e#|bd#<CR>", desc = "Close All Buffers" },
          ["<leader>fs"] = { "<cmd>Telescope resume<CR>", desc = "Redo Search" },
          ["<leader>mp"] = { ":Glow<CR>", desc = "Markdown preview" },
          ["<leader>mo"] = { ":ObsidianNew<CR>", desc = "New Obsidian note" },
          ["<leader>mf"] = { ":ObsidianQuickSwitch<CR>", desc = "Find Obsidian note" },
          ["<leader>ms"] = { ":ObsidianSearch<CR>", desc = "Search Obsidian note" },
          ["<leader>mi"] = { ":ObsidianPasteImg<CR>", desc = "Add Image to Obsidian note" },
          ["<leader>mv"] = { ":ObsidianFollowLink vsplit<CR>", desc = "Vertical split obsidian note" },
          ["<leader>mr"] = { ":ObsidianRename<CR>", desc = "Rename obsidian note" },
          ["<leader>bM"] = { ":%s/\r$//g<CR>", desc = "Remove carriage returns" },

          ["<Leader>HA"] = { ":HurlRunner<CR>", desc = "Run All requests" },
          ["<Leader>Ha"] = { ":HurlRunnerAt<CR>", desc = "Run API requests" },
          ["<Leader>re"] = { ":%s/\r$//g<CR>", desc = "Remove Line Endings" },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader>m"] = { name = "Markdown" },
          ["<Leader>H"] = { name = "Hurl API" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = {
          ["<Leader>m"] = { name = "Markdown" },
          ["<leader>me"] = { ":ObsidianExtractNote<CR>", desc = "Extract to new Obsidian note" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["<leader>le"] = {
            function() vim.diagnostic.open_float { border = "rounded" } end,
            desc = "Floating diagnostic",
          },
          ["<leader>lp"] = {
            -- "<CMD>Lspsaga hover_doc<CR>",
            function() require("pretty_hover").hover() end,
            desc = "󱙼 Hover lsp",
          },
        },
      },
    },
  },
}
