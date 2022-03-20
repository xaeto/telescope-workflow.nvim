local has_telescope, telescope = pcall(require, "telescope")
local main = require "telescope._extensions.template_actions.main"
local utils = require "telescope._extensions.template_actions.utils"

if not has_telescope then
  error "this plugin requires nvim-telescope/telescope.nvim"
end

return telescope.register_extension {
  setup = main.setup,
  exports = {
    template_actions = main.template_actions,
  },
}
