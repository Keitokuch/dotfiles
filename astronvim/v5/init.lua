-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.

-- Detect when the working directory is on a network filesystem. Uses
-- fs_statfs() type magic, so this only triggers for actual network mounts;
-- a native machine where /lustre is a local disk stays on the default path.
-- Consumed by Neo-tree and other plugins with expensive filesystem features.
local uv = vim.uv or vim.loop
local NETWORK_FS_TYPES = {
  [0x0BD00BD0] = true, -- lustre
  [0x65735546] = true, -- fuse (sshfs, etc.)
  [0x6969] = true, -- nfs
  [0xFF534D42] = true, -- cifs/smb
}
local function path_on_network_fs(path)
  if not path or path == "" then return false end
  if not uv or not uv.fs_statfs then return false end
  local candidate = vim.fn.fnamemodify(path, ":p")
  while candidate and candidate ~= "" do
    local stat = uv.fs_statfs(candidate)
    if stat then
      if NETWORK_FS_TYPES[stat.type] then
        vim.g.network_fs_type = stat.type
        vim.g.network_fs_path = candidate
        return true
      end
      return false
    end
    local parent = vim.fn.fnamemodify(candidate, ":h")
    if not parent or parent == candidate then break end
    candidate = parent
  end
  return false
end
local function detect_network_fs()
  if vim.env.NVIM_NETWORK_FS == "1" then return true end
  if vim.env.NVIM_NETWORK_FS == "0" then return false end
  if path_on_network_fs(vim.fn.getcwd()) then return true end
  for _, arg in ipairs(vim.fn.argv()) do
    if path_on_network_fs(arg) then return true end
  end
  return false
end
vim.g.network_fs = detect_network_fs()

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
