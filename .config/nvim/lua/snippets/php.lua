local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("php", {
  s({
    trig = "yins",
    name = "yii2 db insert command"
  }, fmt("Yii::$app->db->createCommand()\n\t->insert('{}', [\n\t\t'{}' => '{}',\n\t])->execute();", { i(1, "table"), i(2, "column"), i(0, "value") })),
  s({
    trig = "yupd",
    name = "yii2 db update command"
  }, fmt("Yii::$app->db->createCommand()\n\t->update('{}', [\n\t\t'{}' => '{}',\n\t], '{}')->execute();", { i(1, "table"), i(2, "column"), i(3, "value"), i(0, "condition") })),
  s({
    trig = "ydel",
    name = "yii2 db delete command"
  }, fmt("Yii::$app->db->createCommand()\n\t->delete('{}', [\n\t\t'{}' => '{}',\n\t])->execute();", { i(1, "table"), i(2, "column"), i(0, "value") })),
  s({
    trig = "ylj",
    name = "yii2 db query left join",
  }, fmt(
    [[
      ->leftJoin('{}', '{}.id = {}.{}')
    ]], {i(1), rep(1), i(2), i(0)}
  )),
  s({
    trig = "yr",
    name = "yii2 active record relation",
  }, fmt(
    [[
      public function get{}()
      {{
          return $this->has{}({}::class, ['{}' => '{}']){};
      }}
    ]], {
      i(1),
      c(2, { t "One", t "Many" }),
      rep(1),
      i(3),
      i(4),
      c(5, { t "", t "->andOnCondition(['x' => 'y'])" })
    }
  )),
})
