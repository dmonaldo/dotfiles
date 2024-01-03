-- NOTE: I don't think these are working

-- Auto-refresh signify when saving a file
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    command = "SignifyRefresh"
})

-- Auto-refresh signify periodically during editing
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    command = "SignifyRefresh"
})
