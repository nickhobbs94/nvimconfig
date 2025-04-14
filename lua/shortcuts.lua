
function GoToLog()
  vim.cmd([[edit ~/Documents/Logs/2025.md]])
end

function GoToHome()
  vim.cmd([[edit ~/Documents/Home.txt]])
end

vim.api.nvim_create_user_command('Log', GoToLog, {})
vim.api.nvim_create_user_command('Home', GoToHome, {})

