local ls = require "luasnip"

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
})
