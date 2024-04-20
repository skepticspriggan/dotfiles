function count(base, pattern)
  return select(2, string.gsub(base, pattern, ""))
end

-- vim.keymap.set({ "n", "v"}, "<C-h>", "<Esc>hF,vf,hol")
-- vim.keymap.set({ "n", "v"}, "<C-j>", "<Esc>jF,vf,hol")
-- vim.keymap.set({ "n", "v"}, "<C-k>", "<Esc>kF,vf,hol")
-- vim.keymap.set({ "n", "v"}, "<C-l>", "<Esc>lF,vf,hol")
directions = {
  up = 1,
  right = 2,
  down = 3,
  left = 4
}

function split(string, separator)
  local array = {}
  local pattern = string.format("([^%s]*)", separator)
  for index in string.gmatch(string .. separator, "([^"..separator.."]*)" .. separator) do
    table.insert(array, index)
  end
  return array
end

function selectField(row, index)
  -- print("select field (row, index) = (" .. row .. ", " .. index .. ")")
  local line = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), row - 1, row, false)[1]
  local fieldCount = count(line, ",") + 1
  vim.api.nvim_win_set_cursor(0, {row, 0})
  local fields = split(line, ",")
  -- P(fields)

  local keysString = ""
  if fieldCount == 1 then
    if fields[1] == "" then
      keysString = "<Esc>i"
    else
      keysString = "<Esc>0v$"
    end
  else
    if index == 0 then
      if fields[1] == "" then
        keysString = "<Esc>i"
      else
        keysString = "<Esc>0vt,"
      end
    elseif index == (fieldCount - 1) then
      if fields[index + 1] == "" then
        keysString = "<Esc>$a"
      else
        keysString = "<Esc>$vT,"
      end
    else
      if fields[index + 1] == "" then
        keysString = "<Esc>0" .. index .. "f,a"
      else
        keysString = "<Esc>0" .. index .. "f,lvt,"
      end
    end
  end

  local keys = vim.api.nvim_replace_termcodes(keysString, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

function moveField(direction)
  local lineCount = vim.api.nvim_buf_line_count(0)
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  print("cursor location (row, col) = (" .. row .. ", " .. col .. ")")
  local left = string.sub(line, 0, col)
  local fieldCount = count(line, ",") + 1
  local index = count(left, ",")
  if direction == directions.up then
    if row == 1 then
      return
    end
    targetRow = row - 1
    targetIndex = index
  elseif direction == directions.down then
    if row == lineCount then
      return
    end
    targetRow = row + 1
    targetIndex = index
  elseif direction == directions.left then
    if index == 0 then
      return
    end
    targetIndex = index - 1
    targetRow = row
  elseif direction == directions.right then
    if index == (fieldCount - 1) then
      return
    end
    targetIndex = index + 1
    targetRow = row
  end
  selectField(targetRow, targetIndex)
end

vim.keymap.set({ "n", "v", "i" }, "<A-h>", function()
  moveField(directions.left)
end)
vim.keymap.set({ "n", "v", "i" }, "<A-j>", function()
  moveField(directions.down)
end)
vim.keymap.set({ "n", "v", "i" }, "<A-k>", function()
  moveField(directions.up)
end)
vim.keymap.set({ "n", "v", "i" }, "<A-l>", function()
  moveField(directions.right)
end)

function fieldNameToIndex(name)
  local header = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, 1, false)[1]
  a, _ = string.find(header, name)
  local left = string.sub(header, 0, a)
  return count(left, ",")
end

function fillField(row, index, value)
  local line = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), row - 1, row, false)[1]
  local fieldCount = count(line, ",") + 1
  vim.api.nvim_win_set_cursor(0, {row, 0})
  local fields = split(line, ",")
  -- P(fields)

  local keysString = ""
  if fieldCount == 1 then
    if fields[1] == "" then
      keysString = "<Esc>i" .. value
    else
      keysString = "<Esc>0v$c" .. value
    end
  else
    if index == 0 then
      if fields[1] == "" then
        keysString = "<Esc>i" .. value
      else
        keysString = "<Esc>0vt,c" .. value
      end
    elseif index == (fieldCount - 1) then
      if fields[index + 1] == "" then
        keysString = "<Esc>$a" .. value
      else
        keysString = "<Esc>$vT,c" .. value
      end
    else
      if fields[index + 1] == "" then
        keysString = "<Esc>0" .. index .. "f,a" .. value
      else
        keysString = "<Esc>0" .. index .. "f,lvt,c" .. value
      end
    end
  end

  local keys = vim.api.nvim_replace_termcodes(keysString, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

vim.keymap.set({ "n" }, "<A-i>", function()
  local currentRow, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local rows = {
    {
      ["keyword"] = "AB Vakwerk",
      ["category%-1"] = "werk", -- the dash is a special character in patterns that needs to be escaped
      ["category%-2"] = "uitzendkracht",
      ["type"] = "income",
      ["account"] = "Betaalrekening",
      ["recurring"] = 1,
      ["by"] = "A",
      ["for"] = "A"
    }
  }
  for _, row in ipairs(rows) do
    if string.find(line, row["keyword"]) then
      for key, value in pairs(row) do
        if key ~= "keyword" then
          fillField(currentRow, fieldNameToIndex(key), row[key])
        end
      end
    end
  end
end)
