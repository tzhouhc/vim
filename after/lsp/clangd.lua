-- c
-- Note that clangd requires manual installation on some architectures.
return {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
}
