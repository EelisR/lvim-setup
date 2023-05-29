vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

lvim.lsp.buffer_mappings.normal_mode['H'] = { vim.lsp.buf.hover, "Show documentation" }
lvim.plugins = {
  {"github/copilot.vim"},
  {"olimorris/onedarkpro.nvim"},
  {"nvim-lua/plenary.nvim"},
  {"theprimeagen/harpoon"}
}

vim.opt.termguicolors = true
lvim.colorscheme = "onedark"
lvim.builtin.lualine.style = "default"
vim.opt.relativenumber = true

vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

lvim.builtin.which_key.mappings["h"] = {
  name = "Harpoon",
  t = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Quick Menu"},
  a = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File"},
}

for i = 0, 9 do
  vim.api.nvim_set_keymap("n", "<leader>" .. i, "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<cr>", { silent = true })
end
