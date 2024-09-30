return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      opts.win_options = vim.tbl_deep_extend("force", opts.win_options or {}, {
        conceallevel = {
          default = 0,
        },
      })
    end,
  },
}
