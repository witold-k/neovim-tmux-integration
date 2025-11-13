-- Open binary files
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.pdf", },
  callback = function(args)
    local filename = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart({"zathura", "--mode=fullscreen", filename}, {detach = true})
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force=true })
      end
    end)
  end
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.png", "*.jpg", "*.JPG", "*.jpeg", "*.gif", "*.webp" },
  callback = function(args)
    local filename = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart({"feh", "-F", "--start-at", filename}, {detach = true})
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force=true })
      end
    end)
  end
})
