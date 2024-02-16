return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of importing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    -- { import = "astrocommunity.colorscheme.catppuccin" },
    -- { import = "astrocommunity.completion.copilot-lua-cmp" },
    {import = "astrocommunity.pack.typescript"},
    {import = "astrocommunity.pack.json"},
    {import = "astrocommunity.pack.bash"},
    {import = "astrocommunity.diagnostics.trouble-nvim"},
    -- { import = "astrocommunity.git.git-blame-nvim" },
    {import = "astrocommunity.git.blame-nvim"},
    {import = "astrocommunity.motion.leap-nvim"},
    {import = "astrocommunity.motion.flit-nvim"},
    {import = "astrocommunity.motion.nvim-surround"},
    {import = "astrocommunity.search.nvim-hlslens"},
    {import = "astrocommunity.scrolling.neoscroll-nvim"},
    {import = "astrocommunity.syntax.hlargs-nvim"},
    {import = "astrocommunity.colorscheme.dracula-nvim"},
    {import = "astrocommunity.workflow.hardtime-nvim"},
    {import = "astrocommunity.editing-support.auto-save-nvim"},
    {import = "astrocommunity.test.neotest"},
    {
        "nvim-neotest/neotest",
        ft = {"jest"},
        dependencies = {
            "nvim-neotest/neotest-jest",
            {
                "folke/neodev.nvim",
                opts = function(_, opts)
                    opts.library = opts.library or {}
                    if opts.library.plugins ~= true then
                        opts.library.plugins =
                            require("astronvim.utils").list_insert_unique(opts.library.plugins, "neotest")
                    end
                    opts.library.types = true
                end
            }
        },
        opts = function()
            return {
                -- your neotest config here
                adapters = {
                    require("neotest-jest")(
                        {
                            jestCommand = "pnpm test:ci --",
                            env = {CI = true},
                            cwd = function(path)
                                return vim.fn.getcwd()
                            end
                        }
                    )
                }
            }
        end
    }
}
