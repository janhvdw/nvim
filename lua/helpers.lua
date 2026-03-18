local is_wsl = (function()
  local output = vim.fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end)()

local is_mac = vim.fn.has("macunix") == 1

local is_linux = not is_wsl and not is_mac

local is_windows = vim.fn.has("win32") == 1

local function is_cwdin_vault()
  local re = vim.regex("^" .. vim.fn.expand("~/vaults/"))
  return not not re:match_str(vim.fn.getcwd())
end

local function augroup(name)
  return vim.api.nvim_create_augroup("local_config_" .. name, { clear = true })
end

return {
  is_wsl = is_wsl,
  is_mac = is_mac,
  is_linux = is_linux,
  is_windows = is_windows,
  is_cwd_in_vault = is_cwdin_vault,
  augroup = augroup,
}
