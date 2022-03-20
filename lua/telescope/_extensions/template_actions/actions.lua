local actions_state = require "telescope.actions.state"
local Job = require "plenary.job"

local M = {}

M.execute_method = function(prompt_bufnr)
  local method = actions_state.get_selected_entry(prompt_bufnr)
  local params = {}

  for _, value in pairs(method.params) do
    local input = vim.fn.input("Input for " .. value .. ": ", "") or ""
    if not input or input == "" then
      error("Missing " .. value .. " Parameter")
      return
    end
    params[value] = input
  end

  -- validate params
  for key, param in pairs(params) do
    if not method.params[key] then
      return
    end
  end

  if type(method.pre) == "function" then
    method.pre(method, params)
  end

  Job
    :new({
      command = method.executable,
      cwd = params.cwd,
      args = method.args,
    })
    :sync()

  if type(method.post) == "function" then
    method.post(method, params)
  end
end

return M
