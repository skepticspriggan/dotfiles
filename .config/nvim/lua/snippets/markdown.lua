local ls = require "luasnip"

ls.add_snippets("markdown", {
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

  s({
    trig = "issue-specific",
    name = "Specific issue"
  }, fmt(
    [[
      # Issue {}

      **{}?**

      _What are the steps to reproduce the problem?_

      {}

      _What is the expected result?_

      {}

      _What happens instead?_

      {}

      _Answer_

      {}
    ]], {
      i(1),
      i(2),
      i(3),
      i(4),
      i(5),
      i(0),
    }
  )),

  s({
    trig = "issue-general",
    name = "General issue"
  }, fmt(
    [[
      # Issue {}

      **{}?**

      _Answer_

      {}
    ]], {
      i(1),
      i(2),
      i(0),
    }
  )),
})
