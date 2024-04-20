local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("php", {
  s(
    "for",
    fmt(
      [[
        for(${} = 0; ${} < {}; {}++) {{
            {}
        }}
      ]], {
        i(1, "i"),
        rep(1),
        i(2),
        rep(1),
        i(0)
      }
    )
  ),

  s(
    "foreach",
    fmt(
      [[
        foreach(${} as {}) {{
            {}
        }}
      ]], {
        i(1),
        c(2, {
          sn(nil, {t"$", i(1, "value")}),
          sn(nil, {t"$", i(1, "key"), t" => $", i(2, "value")})
        }),
        i(0)
      }
    )
  ),

  s("dt", { t("(new \\DateTime())->format('Y-m-d H:i:s')") }),

  s("constructor",
    fmt(
      [[
      function __construct($config = [])
      {{
          foreach($config as $name => $value) {{
              $this->$name = $value;
          }}
      }}
      ]], {}
    )
  ),

  s("fn",
    fmt(
      [[
        public static function {}To{}(${}):
        {{
            if(!isset(self::{}S_BY_{}[ ${} ])) {{
                throw new \Exception('Invalid {}.');
            }}
            return self::{}S_BY_{}[ ${} ];
        }}
      ]], {
        i(1),
        i(2),
        rep(1),
        l(l._2:gsub('([a-z])([A-Z])', '%1_%2'):upper(), {1, 2}),
        l(l._1:gsub('([a-z])([A-Z])', '%1_%2'):upper(), 1),
        rep(1),
        rep(1),
        l(l._2:gsub('([a-z])([A-Z])', '%1_%2'):upper(), {1, 2}),
        l(l._1:gsub('([a-z])([A-Z])', '%1_%2'):upper(), 1),
        rep(1)
      }
    )
  ),

  s("fnto",
    fmt(
      [[
        public static function {}To{}(${}):
        {{
            if(!isset(self::{}S_BY_{}[ ${} ])) {{
                throw new \Exception('Invalid {}.');
            }}
            return self::{}S_BY_{}[ ${} ];
        }}
      ]], {
        i(1),
        i(2),
        rep(1),
        l(l._2:gsub('([a-z])([A-Z])', '%1_%2'):upper(), {1, 2}),
        l(l._1:gsub('([a-z])([A-Z])', '%1_%2'):upper(), 1),
        rep(1),
        rep(1),
        l(l._2:gsub('([a-z])([A-Z])', '%1_%2'):upper(), {1, 2}),
        l(l._1:gsub('([a-z])([A-Z])', '%1_%2'):upper(), 1),
        rep(1)
      }
    )
  ),

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
      ->leftJoin('{}', '{}.id = {}')
    ]], {i(1), rep(1), i(0)}
  )),

  s({
    trig = "yr",
    name = "yii2 active record relation",
  }, fmt(
    [[
      public function get{}(): yii\db\ActiveQuery
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

  s("yha",
    { t "Html::a('", i(1), t "', ['", i(2), t "']", c(3, { t "", t ", ['class' => 'btn btn-primary m-1', 'data-method' => 'post']" }), t ")" }
  )
})
