require("options")
require("plugins")

function Markdown()
    vim.opt_local.wrap = true           -- Enable line wrapping for this buffer
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true      -- Break lines at word boundaries
    vim.opt_local.textwidth = 0         -- Disable hard text wrapping
    vim.opt_local.colorcolumn = "80"    -- Show a guide at 80 characters (optional)

    -- Buffer-local key mappings
    vim.keymap.set(
        "n",
        "k",
        "g<Up>",
        { buffer = 0, desc = "Move up one display line" }
    )
    vim.keymap.set(
        "n",
        "j",
        "g<Down>",
        { buffer = 0, desc = "Move down one display line" }
    )

    require('wrapping').soft_wrap_mode() -- Enable soft wrapping mode
end

vim.api.nvim_create_user_command('Markdown', Markdown, {})

--vim.api.nvim_create_autocmd("FileType", {
--    pattern = "*",
--    callback = function()
--      if vim.bo.filetype == "markdown" then
--        Markdown()
--      else
--        vim.opt_local.wrap = false
--      end
--    end,
--})

