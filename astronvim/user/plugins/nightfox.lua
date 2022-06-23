require("nightfox").setup {
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  },
  -- disable extra plugins that AstroNvim doesn't use (this is optional)
  modules = {
    barbar = false,
    dashboard = false,
    fern = false,
    fidget = false,
    gitgutter = false,
    glyph_palette = false,
    illuminate = false,
    lightspeed = false,
    lsp_saga = false,
    lsp_trouble = false,
    modes = false,
    neogit = false,
    nvimtree = false,
    pounce = false,
    sneak = false,
    symbols_outline = false,
  },
  groups = {
    all = {
      -- add highlight group for AstroNvim's built in URL highlighting
      HighlightURL = { style = "underline" },
    },
  },
}
