local Path = require "plenary.path"

local M = {}
local store = {}

M.register = function(template)
  table.insert(store, template)
end

M.get_entries = function()
  return store
end

M.merge_cmd = function(value, params)
  local p = value
  for k, v in pairs(params) do
    p = string.gsub(p, "@" .. k, v)
  end
  return p
end

M.build_cmd = function(cmd, params)
  local _cmd
  params.cwd = "."

  for _, value in pairs(cmd) do
    if not _cmd then
      _cmd = M.merge_cmd(value, params)
    else
      _cmd = _cmd .. " " .. M.merge_cmd(value, params)
    end
  end

  return _cmd
end

M.create_dir = function(path)
  local dir = Path:new(path)
  if not dir:exists() then
    dir:mkdir()
  end
end

M.set_method_args = function(method, params)
  for key, value in pairs(method.args) do
    if params[value] then
      method.args[key] = params[value]
    end
  end
end

return M
