-- requires on java extra from lazy vim
return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      cmd = {
        "jdtls",
        "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar"),
      },
    },
  },
}
