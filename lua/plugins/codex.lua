return {
  {
    "johnseth97/codex.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Let the plugin install/update the codex CLI for you if it is missing.
      -- Set to false if you prefer to manage `@openai/codex` yourself.
      autoinstall = false,

      -- Optional UI behavior
      border = "rounded",
      width = 0.85,
      height = 0.85,

      -- Optional: override the command if `codex` is not on PATH
      cmd = { "codex" },
    },
    keys = {
      { "<leader>cc", "<cmd>Codex<cr>", desc = "Open Codex" },
      { "<leader>ce", "<cmd>CodexExplain<cr>", mode = "v", desc = "Explain selection" },
      { "<leader>cf", "<cmd>CodexFix<cr>", mode = "v", desc = "Fix selection" },
      { "<leader>cr", "<cmd>CodexReview<cr>", mode = "v", desc = "Review selection" },
    },
  },
}
