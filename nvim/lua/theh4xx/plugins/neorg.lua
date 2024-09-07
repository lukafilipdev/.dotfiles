return {
    "nvim-neorg/neorg",
    lazy = false,    -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "v8.9.0", -- Pin Neorg to a compatible version
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        })

        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}
