-- cmp
local cmp_higlights = {
    PmenuSel = { bg = "#443c59", },
    Pmenu = { bg = "Normal" },
    CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
    CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
    CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
    CmpItemMenu = { fg = "white", bg = "NONE", fmt = "italic" },
    CmpItemKindField = { fg = "#B5585F" },
    CmpItemKindProperty = { fg = "#B5585F" },
    CmpItemKindEvent = { fg = "#B5585F" },
    CmpItemKindText = { fg = "#9FBD73" },
    CmpItemKindEnum = { fg = "#9FBD73" },
    CmpItemKindKeyword = { fg = "#9FBD73" },
    CmpItemKindConstant = { fg = "#D4BB6C" },
    CmpItemKindConstructor = { fg = "#D4BB6C" },
    CmpItemKindReference = { fg = "#D4BB6C" },
    CmpItemKindFunction = { fg = "#A377BF" },
    CmpItemKindStruct = { fg = "#A377BF" },
    CmpItemKindClass = { fg = "#A377BF" },
    CmpItemKindModule = { fg = "#A377BF" },
    CmpItemKindOperator = { fg = "#A377BF" },
    CmpItemKindVariable = { fg = "#7E8294" },
    CmpItemKindFile = { fg = "#7E8294" },
    CmpItemKindUnit = { fg = "#D4A959" },
    CmpItemKindSnippet = { fg = "#D4A959" },
    CmpItemKindFolder = { fg = "#D4A959" },
    CmpItemKindMethod = { fg = "#6C8ED4" },
    CmpItemKindValue = { fg = "#6C8ED4" },
    CmpItemKindEnumMember = { fg = "#6C8ED4" },
    CmpItemKindInterface = { fg = "#58B5A8" },
    CmpItemKindColor = { fg = "#58B5A8" },
    CmpItemKindTypeParameter = { fg = "#58B5A8" },
}

for group, highlight in pairs(cmp_higlights) do
    vim.cmd(string.format("highlight %s guifg=%s guibg=%s gui=%s", group, highlight.fg or "NONE", highlight.bg or "NONE",
    highlight.fmt or "NONE"))
end
