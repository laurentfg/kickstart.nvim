-- Godot external editor talks to a running nvim server.
-- Windows has no unix socket, so this listens on TCP. Godot Exec Flags:
-- --server 127.0.0.1:6004 --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
local godot_project = vim.fs.find('project.godot', { upward = true, type = 'file' })[1]
if not godot_project then
  return
end

local addr = '127.0.0.1:6004'
for _, server in ipairs(vim.fn.serverlist()) do
  if server:find('6004', 1, true) then
    return
  end
end

pcall(vim.fn.serverstart, addr)