-- A little module that monkey-patches the Orchestrator.execute function. This function is called when tools are called.
-- When calling for a tool the user has to agree to that tool (if that tool is not on auto-approve) and then the tool output is shown in the chat
-- The monkey-patch makes sure that the tool call is also logged to the chat.

local fmt = string.format

-- Encode a table to JSON (fallback to vim.inspect). Accepts any Lua value.
local function json_or_inspect(target_args)
  if target_args == nil then
    return 'nothing'
  end
  if type(target_args) == 'table' and vim.tbl_isempty(target_args) then
    return 'nothing'
  end

  local ok, j = pcall(vim.json.encode, target_args)
  if ok then
    return j
  end
  return vim.inspect(target_args)
end

-- Add a response to the chat buffer regarding a tool's execution
local send_response_to_chat = function(exec, llm_message, user_message)
  exec.tools.chat:add_tool_output(exec.tool, llm_message, user_message)
end

local patched = false

local function patch_tool_orchestrator()
  local ok_orchestrator, Orchestrator = pcall(require, 'codecompanion.interactions.chat.tools.orchestrator')
  if patched or not ok_orchestrator or not Orchestrator.execute or Orchestrator._orig_execute then
    return
  end

  -- this is where the patching happens
  Orchestrator._orig_execute = Orchestrator.execute
  function Orchestrator:execute(cmd, input)
    local tool_name = (self.tool and self.tool.name) or 'unknown tool'
    local static_args = (self.tool and self.tool.args) or nil
    local msg = fmt('**`%s` Tool**: called with:\n\n````\n%s\n````\n\n', tool_name, json_or_inspect(static_args))

    send_response_to_chat(self, msg)

    -- run the actual logic
    return self:_orig_execute(cmd, input)
  end

  -- small race conditions fix
  patched = true
end

-- Public entry
local M = {}

function M.setup()
  -- Defer so that plugins finish loading
  vim.schedule(patch_tool_orchestrator)
end

return M
