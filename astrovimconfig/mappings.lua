-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
     L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
       desc = "Next buffer",
     },
    H = {
       function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
       desc = "Previous buffer",
     },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>ba"] = { ":%bd|e#|bd#<CR>", desc = "Close All Buffers" },
    ["<leader>le"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      desc="Floating diagnostic",
    },
    ["<leader>lp"] = {
      -- "<CMD>Lspsaga hover_doc<CR>",
      function()
        require("pretty_hover").hover()
      end,
      desc = "󱙼 Hover lsp",
    },
    ["<leader>fs"] = { "<cmd>Telescope resume<CR>", desc= "Redo Search" },
    ["<leader>mp"] = { ":Glow<CR>", desc= "Markdown preview" },
    ["<leader>rf"] = {
      function() 
         require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc= "Run file test"
    },
    ["<leader>rn"] = {
      function() 
         require("neotest").run.attach()
      end,
      desc= "Run Nearest test"
    },
    ["<leader>ro"] = {
      function() 
        require("neotest").summary.open()
      end,
      desc= "Run Jest file test"
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
