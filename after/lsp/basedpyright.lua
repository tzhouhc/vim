return {
  cmd = { "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      }
    }
  }
}
