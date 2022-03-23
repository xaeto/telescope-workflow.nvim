local actions_state = require "telescope.actions.state"
local Job = require "plenary.job"

local M = {}

M.execute_method = function(prompt_bufnr)
  local method = actions_state.get_selected_entry(prompt_bufnr)
  method.params = method.params or {}
  local params = {}

  for paramName, paramOptions in pairs(method.params) do
    local param = paramOptions.text or paramName

    local input 
    if paramOptions.type then
      input =  vim.fn.input(param .. ": ", "", paramOptions.type or "none") or ""
    else
      input =  vim.fn.input(param .. ": ", "") or ""
    end

    if not input or input == "" then
      error("Missing " .. paramName .. " Parameter")
      return
    end

    local validator = paramOptions.validator
    if validator then
      local valid = validator(input)
      print(valid)
      if not valid then
	error(input .. " doesn't match requirements for parameter " .. paramName)
	return
      end
    end
    params[paramName] = input
  end

  if not params then
    return
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
