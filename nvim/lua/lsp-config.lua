local cmp = require 'cmp'

cmp.setup({
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})
    },
    sources = {{name = 'nvim_lsp'}, {name = 'vsnip'}, {name = 'buffer'}}
})
local servers = {
    'pyright', 'sumneko_lua', 'html', 'clangd', 'tsserver', 'cssls'
}
for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities())
    }
end
