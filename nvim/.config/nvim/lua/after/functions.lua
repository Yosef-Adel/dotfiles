-- Lua function to open a scratch buffer on the right
function Open_scratch_buffer()
  -- Create a new vertical split
  vim.cmd("vsplit")

  -- Create a new buffer
  vim.cmd("enew")

  -- Set buffer options
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.wo.wrap = false
end

local function search_workspace()
  local workspaces = vim.fn.glob('packages/*', 0, 1)
  table.insert(workspaces, 1, '.')
  vim.ui.select(workspaces, {
    prompt = 'Select workspace:',
    format_item = function(item)
      return item == '.' and 'Root' or item
    end,
  }, function(choice)
    if choice then
      require('telescope.builtin').find_files({
        cwd = choice,
        prompt_title = 'Files in ' .. choice,
      })
    end
  end)
end

vim.keymap.set('n', '<leader>sw', search_workspace)

local function go_to_workspace()
  local workspaces = vim.fn.glob('packages/*', 0, 1)
  table.insert(workspaces, 1, '.') -- add root project dir

  vim.ui.select(workspaces, {
    prompt = 'Select workspace:',
    format_item = function(item)
      return item == '.' and 'Root' or item
    end,
  }, function(choice)
    if choice then
      vim.cmd('Oil ' .. vim.fn.fnameescape(choice))
    end
  end)
end

vim.keymap.set('n', '<leader>gw', go_to_workspace, { desc = "Search workspaces with Oil" })

local function grep_in_workspace()
  local workspaces = vim.fn.glob('packages/*', 0, 1)
  vim.ui.select(workspaces, {
    prompt = 'Grep in Workspace:',
    format_item = function(item)
      return vim.fn.fnamemodify(item, ':t')
    end,
  }, function(choice)
    if choice then
      require('telescope.builtin').live_grep({ cwd = choice })
    end
  end)
end

vim.keymap.set('n', '<leader>lw', grep_in_workspace, { desc = 'Grep in workspace' })
