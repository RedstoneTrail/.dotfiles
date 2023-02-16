require("leap").add_default_mappings()

if vim.g.vscode then
    require("cfg.remap.vscode")
else
    require("cfg.remap.native")
end
