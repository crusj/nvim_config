vim.cmd([[
let g:dbs = {
\  'crp-test': 'mysql://root:cloud%26root@192.168.2.121:13306/cloud',
\  'crp-dev': 'mysql://root:cloud%26root@192.168.2.121:13306/cloud_dev'
\ }
]])
vim.cmd([[
nnoremap <leader>db <cmd>DBUIToggle<cr>
]])
