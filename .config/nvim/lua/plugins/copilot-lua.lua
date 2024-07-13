return {
    'zbirenbaum/copilot.lua',
    Cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup()
    end
}
