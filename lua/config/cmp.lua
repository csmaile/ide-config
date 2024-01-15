local M = {}


local cmp = require("cmp")
local luasnip = require('luasnip')
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

function M.setup()
  -- Set up nvim-cmp.
  --

end

return M
