-- All surround maps under gs* so the bare `s` stays free for flash.

return {
  "nvim-mini/mini.surround",
  version = false,
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
}
