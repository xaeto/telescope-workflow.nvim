local actions = require "telescope.actions"
local config = require("telescope.config").values
local pickers = require "telescope.pickers"

local _actions = require "telescope._extensions.workflow.actions"
local _finders = require "telescope._extensions.workflow.finders"

local M = {}

M.setup = function(setup_config) end

M.template_methods = function(opts, prompt_bufnr)
  pickers.new(opts or {}, {
    prompt_title = "Select a Method",
    results_title = "Methods",
    finder = _finders.method_finder(opts, prompt_bufnr),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local on_method_selected = function(prompt_bufnr)
        _actions.execute_method(prompt_bufnr)
      end
      actions.select_default:replace(on_method_selected)
      return true
    end,
  }):find()
end

M.template_actions = function(opts)
  pickers.new(opts or {}, {
    prompt_title = "Select a language",
    results_title = "Languages",
    finder = _finders.language_finder(opts),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local on_language_selected = function(prompt_bufnr)
        M.template_methods(opts, prompt_bufnr)
      end
      actions.select_default:replace(on_language_selected)
      return true
    end,
  }):find()
end

return M
