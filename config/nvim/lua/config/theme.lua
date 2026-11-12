local M = {}

function M.setup()
  local mode = "auto"
  local busy = false
  local mac = vim.fn.has("macunix") == 1
  local command = { "defaults", "read", "-g", "AppleInterfaceStyle" }
  local group = vim.api.nvim_create_augroup("user_system_theme", { clear = true })

  local function apply(background)
    local scheme = background == "light" and "github_light" or "github_dark"
    if vim.o.background ~= background or vim.g.colors_name ~= scheme then
      vim.o.background = background
      vim.cmd.colorscheme(scheme)
    end
  end

  -- macOS omits AppleInterfaceStyle (exit status 1) in light mode.
  local function appearance(output, code)
    if code == 0 then
      return output:match("Dark") and "dark" or "light"
    elseif code == 1 then
      return "light"
    end
  end

  local function refresh()
    if mode ~= "auto" or not mac or busy then return end
    busy = true
    local output = ""
    local job = vim.fn.jobstart(command, {
      stdout_buffered = true,
      on_stdout = function(_, data) output = table.concat(data, "\n") end,
      on_exit = function(_, code)
        busy = false
        local background = appearance(output, code)
        if mode == "auto" and background then apply(background) end
      end,
    })
    if job <= 0 then busy = false end
  end

  -- Resolve appearance before the first colorscheme is drawn.
  if mac then
    local output = vim.fn.system(command)
    apply(appearance(output, vim.v.shell_error) or vim.o.background)
  else
    apply(vim.o.background)
  end

  vim.api.nvim_create_user_command("Theme", function(args)
    if not vim.tbl_contains({ "auto", "dark", "light" }, args.args) then
      vim.notify("Usage: :Theme auto|dark|light", vim.log.levels.ERROR)
      return
    end
    mode = args.args
    if mode == "auto" then refresh() else apply(mode) end
  end, {
    nargs = 1,
    complete = function() return { "auto", "dark", "light" } end,
    desc = "Set light/dark appearance or follow macOS",
  })

  vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = refresh })
  if mac then
    local timer = (vim.uv or vim.loop).new_timer()
    timer:start(3000, 3000, vim.schedule_wrap(refresh))
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      callback = function()
        timer:stop()
        timer:close()
      end,
    })
  end
end

return M
