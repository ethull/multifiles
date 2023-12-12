--[[
-- ethull lua neovim configuration
--]]

require("general.settings")
require("general.keybindings")

-- only load plugins if not running in vscode
if not vim.g.vscode then
    require("general.plugins")
--else
--    require("plugins")
--end
