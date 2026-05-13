-- Open binary files
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.pdf", "*.PDF", },
  callback = function(args)
    local filename = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart(
        {"zathura", "--mode=fullscreen", filename},
        {
            detach = true,
            env = { LD_LIBRARY_PATH = "" },
        }
    )
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force=true })
      end
    end)
  end
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.png", "*.jpg", "*.JPG", "*.jpeg", "*.gif", "*.webp", },
  callback = function(args)
    local filename = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart(
        {"feh", "-F", "--start-at", filename},
        {
            detach = true,
            env = { LD_LIBRARY_PATH = "" },
        }
    )
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force=true })
      end
    end)
  end
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.mp4", "*.MP4", "*.webm", "*.m4v", "*.mkv", "*.divx", "*.avi", },
  callback = function(args)
    local filename = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart(
        {"mpv", filename},
        {
            detach = true,
            env = { LD_LIBRARY_PATH = "" },
        }
    )
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force=true })
      end
    end)
  end
})
