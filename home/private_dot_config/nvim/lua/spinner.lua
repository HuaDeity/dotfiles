local M = {}

-- Default spinner symbols (fallback if vim.g.spinner_symbols is not set)
local DEFAULT_SPINNER_SYMBOLS = {
  "⠋",
  "⠙",
  "⠹",
  "⠸",
  "⠼",
  "⠴",
  "⠦",
  "⠧",
  "⠇",
  "⠏",
}

-- Active spinners registry
local active_spinners = {}

-- Get spinner symbols from vim.g or use defaults
local function get_spinner_symbols() return vim.g.spinner_symbols or DEFAULT_SPINNER_SYMBOLS end

-- Create a new spinner instance
local function create_spinner_instance(id, config)
  return {
    id = id,
    processing = false,
    spinner_index = 1,
    namespace_id = vim.api.nvim_create_namespace("Spinner_" .. id),
    timer = nil,
    config = vim.tbl_extend("force", {
      message = "Processing...",
      interval = 100,
      highlight = "Comment",
      position = "below", -- "above" or "below"
    }, config or {}),
  }
end

-- Find buffer by various criteria
function M.find_buffer(criteria)
  if type(criteria) == "number" then
    -- Buffer ID provided
    return vim.api.nvim_buf_is_valid(criteria) and criteria or nil
  elseif type(criteria) == "string" then
    -- Filetype provided
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == criteria then return buf end
    end
  elseif type(criteria) == "table" then
    -- Custom criteria function
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and criteria.filter(buf) then return buf end
    end
  end
  return nil
end

-- Update spinner animation
local function update_spinner_animation(spinner)
  if not spinner.processing then
    M.stop(spinner.id)
    return
  end

  local symbols = get_spinner_symbols()
  spinner.spinner_index = (spinner.spinner_index % #symbols) + 1

  local buf = spinner.target_buffer
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    M.stop(spinner.id)
    return
  end

  -- Clear previous virtual text
  vim.api.nvim_buf_clear_namespace(buf, spinner.namespace_id, 0, -1)

  local line_pos = spinner.config.line or (vim.api.nvim_buf_line_count(buf) - 1)
  local message = symbols[spinner.spinner_index] .. " " .. spinner.config.message

  local extmark_opts = {
    virt_lines = { { { message, spinner.config.highlight } } },
    virt_lines_above = spinner.config.position == "above",
  }

  vim.api.nvim_buf_set_extmark(buf, spinner.namespace_id, line_pos, 0, extmark_opts)
end

-- Start a spinner
function M.start(id, buffer_criteria, config)
  if active_spinners[id] then M.stop(id) end

  local buf = M.find_buffer(buffer_criteria)
  if not buf then
    vim.notify("Spinner: Could not find target buffer", vim.log.levels.WARN)
    return false
  end

  local spinner = create_spinner_instance(id, config)
  spinner.target_buffer = buf
  spinner.processing = true
  spinner.spinner_index = 0

  spinner.timer = vim.loop.new_timer()
  spinner.timer:start(0, spinner.config.interval, vim.schedule_wrap(function() update_spinner_animation(spinner) end))

  active_spinners[id] = spinner
  return true
end

-- Stop a specific spinner
function M.stop(id)
  local spinner = active_spinners[id]
  if not spinner then return end

  spinner.processing = false

  if spinner.timer then
    spinner.timer:stop()
    spinner.timer:close()
    spinner.timer = nil
  end

  if spinner.target_buffer and vim.api.nvim_buf_is_valid(spinner.target_buffer) then
    vim.api.nvim_buf_clear_namespace(spinner.target_buffer, spinner.namespace_id, 0, -1)
  end

  active_spinners[id] = nil
end

-- Stop all spinners
function M.stop_all()
  for id, _ in pairs(active_spinners) do
    M.stop(id)
  end
end

-- Check if a spinner is active
function M.is_active(id) return active_spinners[id] ~= nil and active_spinners[id].processing end

-- Get list of active spinner IDs
function M.get_active()
  local active = {}
  for id, spinner in pairs(active_spinners) do
    if spinner.processing then table.insert(active, id) end
  end
  return active
end

-- Update spinner message
function M.update_message(id, message)
  local spinner = active_spinners[id]
  if spinner then spinner.config.message = message end
end

-- Quick start for common use cases
function M.start_for_filetype(filetype, config)
  local id = "filetype_" .. filetype
  return M.start(id, filetype, config)
end

function M.stop_for_filetype(filetype)
  local id = "filetype_" .. filetype
  M.stop(id)
end

function M.start_for_buffer(buf_id, config)
  local id = "buffer_" .. buf_id
  return M.start(id, buf_id, config)
end

function M.stop_for_buffer(buf_id)
  local id = "buffer_" .. buf_id
  M.stop(id)
end

-- Setup function for easy configuration
function M.setup(opts)
  opts = opts or {}

  -- Set default spinner symbols if not already set
  if not vim.g.spinner_symbols and opts.symbols then vim.g.spinner_symbols = opts.symbols end

  -- Setup autocommands if provided
  if opts.autocommands then
    local group = vim.api.nvim_create_augroup("SpinnerAutocommands", { clear = true })

    for _, autocmd in ipairs(opts.autocommands) do
      vim.api.nvim_create_autocmd(autocmd.event, {
        pattern = autocmd.pattern,
        group = group,
        callback = function(args)
          if autocmd.on_start then autocmd.on_start(args) end
        end,
      })
    end
  end
end

return M
