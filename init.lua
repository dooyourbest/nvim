-- 使用 Packer.nvim 安装插件
require('packer').startup(function()
    -- Packer 自身
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'phpactor/phpactor'
    use {'neoclide/coc.nvim', branch = 'master', run = 'npm ci'}
    use {
        'kyazdani42/nvim-tree',
        requires = 'kyazdani42/nvim-web-devicons'
    }


    -- LSP 相关插件
    use 'neovim/nvim-lspconfig' -- nvim-lspconfig 插件
    use 'hrsh7th/nvim-compe' -- 补全插件

    -- 代码外观增强
    use 'kyazdani42/nvim-web-devicons'
    use 'glepnir/galaxyline.nvim'
end)

-- LSP 配置
local lspconfig = require('lspconfig')

-- C++ LSP 配置
lspconfig.clangd.setup{}

-- golang lasp 配置
lspconfig.gopls.setup{}

-- Python LSP 配置
require'lspconfig'.pyright.setup {
    cmd = { "/home/zs/.virtualenvs/myenv/bin/pyright-langserver", "--stdio" }
}

-- nvim-compe 设置
require'compe'.setup {
    enabled = true;            -- 启用补全
    autocomplete = true;       -- 自动完成
    min_length = 1;            -- 触发补全的最小字符数
    preselect = 'enable';      -- 自动选择第一个补全项
    throttle_time = 80;        -- 补全延迟时间（毫秒）
    source_timeout = 200;      -- 补全来源超时时间（毫秒）
    incomplete_delay = 400;    -- 补全延迟时间（毫秒）
    max_abbr_width = 100;      -- 补全项最大缩写宽度
    max_kind_width = 100;      -- 补全项最大类型宽度
    max_menu_width = 100;      -- 补全项最大菜单宽度
    documentation = true;      -- 显示补全项文档
}

-- 基础配置
vim.cmd('syntax enable')         -- 启用语法高亮
vim.cmd('filetype plugin indent on')  -- 启用文件类型检测和缩进
vim.cmd('colorscheme tokyonight')

-- 快捷键映射
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>!g++ % -o %< && ./%< <CR>', { noremap = true, silent = true })  -- 编译 C++ 文件
vim.api.nvim_set_keymap('n', '<F6>', '<Cmd>!python3 % <CR>', { noremap = true, silent = true })           -- 运行 Python 文件

-- 外观设置
vim.o.mouse = 'a'               -- 启用鼠标支持
vim.o.termguicolors = true      -- 启用 24 位真彩色
vim.o.background = 'dark'       -- 指定背景为暗Fl色

vim.o.number = true             -- 显示行号
-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set


local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
