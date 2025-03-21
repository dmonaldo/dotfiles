return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "fennel",
        "javascript",
        "typescript",
        "python",
        "tsx",
        "css",
        "json",
        "vim",
        "vimdoc",
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        disable = { "css" },
        additional_vim_regex_highlighting = false,
      },
      autopairs = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "python", "css" },
      },
    })
  end,
}
