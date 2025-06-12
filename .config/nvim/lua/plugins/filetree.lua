return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- TODO: add image support
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = { filtered_items = { hide_dotfiles = false, hide_gitignored = false } },
      window = {
        mappings = {
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
              -- use_image_nvim = true,  -- using 3rd/image.nvim requires more setup
            },
          },
        },
      },
    })
  end,
}
