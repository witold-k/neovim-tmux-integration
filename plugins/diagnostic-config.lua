-- :h diagnostic-signs

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ", -- '', -- or other icon of your choice here, this is just what my config has:
            [vim.diagnostic.severity.WARN] = "󰀪 ", -- '',
            [vim.diagnostic.severity.INFO] = " ", -- '',
            [vim.diagnostic.severity.HINT] = "󰌶 ", -- '󰌵',
        },
    },
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

local function goto_diagnostic_related()
  local diagnostics = vim.diagnostic.get(0, {
    lnum = vim.fn.line(".") - 1,
  })

  if #diagnostics == 0 then
    vim.notify("No diagnostic on this line", vim.log.levels.INFO)
    return
  end

  for _, diagnostic in ipairs(diagnostics) do
    local related = diagnostic.user_data
      and diagnostic.user_data.lsp
      and diagnostic.user_data.lsp.relatedInformation

    if related and #related > 0 then
      local info = related[1]
      local location = info.location

      if location then
        local uri = location.uri
        local range = location.range

        local bufnr = vim.uri_to_bufnr(uri)
        vim.fn.bufload(bufnr)

        vim.api.nvim_set_current_buf(bufnr)
        vim.api.nvim_win_set_cursor(0, {
          range.start.line + 1,
          range.start.character,
        })

        return
      end
    end
  end

  vim.notify("No related source location", vim.log.levels.INFO)
end

vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })

vim.keymap.set("n", "]r", goto_diagnostic_related, {
  desc = "Jump to diagnostic source",
})

