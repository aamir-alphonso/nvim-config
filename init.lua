print("Welcome home Aamir!")

require("config.lazy")

vim.opt.mouse = ""
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.conceallevel = 2
vim.opt.number = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlinting when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function ()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function ()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

local job_id = 0
vim.keymap.set("n", "<space>st", function ()

    vim.cmd.vnew()
    vim.cmd.terminal()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)

    job_id = vim.bo.channel
end)


local current_command = ""
vim.keymap.set("n", "<space>te", function()
  current_command = vim.fn.input("Command: ")
end)

vim.keymap.set("n", "<space>tr", function()
  if current_command == "" then
    current_command = vim.fn.input("Command: ")
  end

  vim.fn.chansend(job_id, { current_command .. "\r\n" })
end)


