vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

local lualineTheme = require("lualine/lualineTheme").theme()

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
  { "github/copilot.vim" },
  { "nvim-lua/plenary.nvim" },
  { "folke/tokyonight.nvim", config = function ()
    require("tokyonight").setup({
      transparent = true,
    })
  end},
  { "navarasu/onedark.nvim", config = function ()
    require("onedark").setup({
      transparent = true
    })
  end}
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {"solargraph"})
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "ruby_lsp"
end, lvim.lsp.automatic_configuration.skipped_servers)

vim.opt.cursorline = false
lvim.transparent_window = true
lvim.colorscheme = "onedark"
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = lualineTheme
lvim.builtin.treesitter.rainbow.enable = true
vim.opt.relativenumber = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
