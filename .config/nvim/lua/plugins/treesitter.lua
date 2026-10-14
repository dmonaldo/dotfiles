return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "javascript",
        "typescript",
        "python",
        "ruby",
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
