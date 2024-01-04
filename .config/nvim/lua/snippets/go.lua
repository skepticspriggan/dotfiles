local ls = require "luasnip"

ls.add_snippets("go", {
   s("fn", fmt("func {}({}) {} {{\n\t{}\n}}", { i(1, "name"), i(2), i(3), i(0) })),
})
