-- A plugin made especially for seeing changes made by code agents
return {
  'koushikxd/resu.nvim',
  dependencies = {
    'sindrets/diffview.nvim',
  },
  config = function()
    require('resu').setup()
  end,
}
