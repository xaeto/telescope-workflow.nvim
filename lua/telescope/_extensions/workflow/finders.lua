local finders = require "telescope.finders"
local entry_display = require "telescope.pickers.entry_display"
local strings = require "plenary.strings"
local action_state = require "telescope.actions.state"
local utils = require "telescope._extensions.workflow.utils"

local M = {}

M.method_finder = function(opts, prompt_bufnr)
  local language = action_state.get_selected_entry(prompt_bufnr)
  local widths = {
    text = 60,
  }
  for _, method in pairs(language.methods) do
    local displayer = entry_display.create {
      seperator = " ",
      items = {
        { width = widths.text },
      },
    }

    local make_display = function(method)
      return displayer {
        { method.text },
      }
    end

    return finders.new_table {
      results = language.methods,
      entry_maker = function(method)
        method.value = method
        method.ordinal = method.text
        method.display = make_display
        return method
      end,
    }
  end
end

M.language_finder = function(opts)
  local languages = utils.get_entries()
  local widths = {
    name = 50,
  }

  for _, lang in pairs(languages) do
    local displayer = entry_display.create {
      seperator = " ",
      items = {
        { width = widths.name },
      },
    }

    local make_display = function(lang)
      return displayer {
        { lang.name },
      }
    end

    return finders.new_table {
      results = languages,
      entry_maker = function(lang)
        lang.value = lang
        lang.ordinal = lang.name
        lang.display = make_display
        return lang
      end,
    }
  end
end

return M
