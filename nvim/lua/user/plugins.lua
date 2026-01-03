local fn = vim.fn

-- Automatically install packer
local lazy_path = fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
	    "--branch=stable",
        lazy_path,
    }
    print "lazy installed"
end

vim.opt.rtp:prepend(lazy_path)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup("user/custom_plugins", {})
