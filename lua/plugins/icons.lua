-- icons
if os.getenv("NERDFONT") == "2" then
  return { { "nvim-tree/nvim-web-devicons", tag = "nerd-v2-compat" } }
else
  return { { "nvim-tree/nvim-web-devicons" } }
end
