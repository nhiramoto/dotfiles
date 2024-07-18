return {
  { "rebelot/kanagawa.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = true },
        functions = { italic = true },
      }
    },
  },
  { 'projekt0n/github-nvim-theme' }
}
