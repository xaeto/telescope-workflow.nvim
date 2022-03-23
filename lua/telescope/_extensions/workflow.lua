local has_telescope, telescope = pcall(require, "telescope")
local main = require "telescope._extensions.workflow.main"
local utils = require "telescope._extensions.workflow.utils"

if not has_telescope then
  error "this plugin requires nvim-telescope/telescope.nvim"
end

return telescope.register_extension {
  setup = main.setup,
  register = utils.register,
  exports = {
    workflow = main.workflow,
  },
}
