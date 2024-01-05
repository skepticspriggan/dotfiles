local M = {}

local unused -- generates hint diagnostic
unused = nothing -- generates warning diagnostic

-- save the original diagnostics handler
local underline_handler = vim.diagnostic.handlers.underline
local virtual_text_handler = vim.diagnostic.handlers.virtual_text
local signs_handler = vim.diagnostic.handlers.signs

-- define our custom diagnostics namespace
local ns = vim.api.nvim_create_namespace("my_diagnostics")

local filter_diagnostics = function(diagnostics, level)
  local subset = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity <= level then
      table.insert(subset, 1, diagnostic)
    end
  end
  return subset
end
 
M.set_level = function(level)
  -- Register our custom handler
  vim.diagnostic.handlers.underline = {
    -- our custom show method
    show = function(_, bufnr, _, opts)
      -- get all diagnostics for whole buffer
      local diagnostics = vim.diagnostic.get(bufnr)
      -- filter diags based on severity
      filtered = filter_diagnostics(diagnostics, level)
      underline_handler.show(ns, bufnr, filtered, opts)
    end,
    hide = function(_, bufnr)
      underline_handler.hide(ns, bufnr)
    end
  }
  -- vim.diagnostic.handlers.virtual_text = {
  --   -- our custom show method
  --   show = function(_, bufnr, _, opts)
  --     print("show virtual text")
  --     -- get all diagnostics for whole buffer
  --     local diagnostics = vim.diagnostic.get(bufnr)
  --     -- filter diags based on severity
  --     filtered = filter_diagnostics(diagnostics, level)
  --     virtual_text_handler.show(ns, bufnr, filtered, opts)
  --   end,
  --   hide = function(_, bufnr)
  --     virtual_text_handler.hide(ns, bufnr)
  --     print("hide virtual text")
  --   end
  -- }
  -- vim.diagnostic.handlers.signs = {
  --   -- our custom show method
  --   show = function(_, bufnr, _, opts)
  --     print("show signs")
  --     -- get all diagnostics for whole buffer
  --     local diagnostics = vim.diagnostic.get(bufnr)
  --     -- filter diags based on severity
  --     filtered = filter_diagnostics(diagnostics, level)
  --     print(filtered)
  --     signs_handler.show(ns, bufnr, filtered, opts)
  --   end,
  --   hide = function(_, bufnr)
  --     signs_handler.hide(ns, bufnr)
  --     print("hide signs")
  --   end
  -- }

  local bufnr = vim.api.nvim_get_current_buf()
  -- hide all diagnostics
  vim.diagnostic.hide(nil, bufnr)
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics == 0 then
    return
  end
  local filtered = filter_diagnostics(diagnostics, level)
  vim.diagnostic.show(ns, bufnr, filtered)
  -- print(vim.inspect(filtered))
  -- print(vim.inspect(diagnostics))
end

-- local bufnr = vim.api.nvim_get_current_buf()
vim.diagnostic.hide(nil, bufnr)

-- P2(vim.diagnostic.handlers)

-- :lua require("filter-diagnostics").set_level(vim.diagnostic.severity.WARN)
return M
