local ls = require "luasnip"

ls.add_snippets("pandoc", {
  s({
    trig = "cb",
    name = "code block"
  }, fmt(
    [[
      ```{}
      {}
      ```
    ]], {
    i(1),
    i(2),
  })),

  s({
    trig = "l",
    name = "link"
  }, {
    t "[",
    i(1, "label"),
    t "](",
    i(2, "url"),
    t ")"
  }),

  s({
    trig = "i",
    name = "image"
  }, {
    t "![",
    i(1, "label"),
    t "](",
    i(2, "path"),
    t ")"
  }),
})
