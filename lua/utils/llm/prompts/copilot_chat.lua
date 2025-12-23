local copilot_chat = function(model)
  return {
    interaction = 'chat',
    description = 'Copilot chat',
    opts = {
      adapter = {
        name = 'copilot',
        model = model,
      },
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an experienced developer',
      },
    },
  }
end

return copilot_chat
