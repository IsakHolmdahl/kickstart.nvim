return {
  interaction = 'chat',
  is_workflow = true,
  description = 'Research and implement input from the user',
  opts = {
    index = 4,
    is_default = true,
    short_name = 'ri',
  },
  prompts = {
    {
      {
        role = 'system',
        content = [[

Below the user will ask you to help them with a coding task for @{buffer}{watch}.

- Assume that everything you know is biased and could be wrong
- use sequential thinking for all steps below.
- You have to use both Context7 and Ref to lookup documentation (High level and on specific implementation docs). If you can not find useful documentation then tell so clearly to the user
- Create an implementation plan
- Write new code in the chat
- review that code using the context that you have gathered, if there are gaps in knowledge to that context then enrich it with moore information from Context7 and Ref.
- update the provided file using the neovim tools provided and validate the code to the best of your abilities.
        ]],
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = [[
@{sequentialthinking} @{Ref} @{neovim}

        ]],
        opts = {
          auto_submit = false,
        },
      },
    },
  },
}
