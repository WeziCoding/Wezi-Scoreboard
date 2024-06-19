--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3


Config = {}

Config.Command = 'showsc'

Config.Key = {
    toggle = true, -- true if u want keybind to open the scoreboard
    key = 'DELETE'
}


Config.Options = {
    Header = {
        toggle = true, -- if set to true it will display player count as the header, if set to false then it will use the translation below for the scoreboard title
        translation = 'Dev Scoreboard',
    },
    ID = {
        icon = false, -- false to use default icon 
        toggle = true,
        title = 'ID:',
        description = 'Ingame ID'
    },
    Ping = {
        icon = false, 
        toggle = true,
        title = 'Ping:',
        description = 'Ingame Ping'
    },
    Health = {
        icon = false, 
        toggle = true,
        title = 'Health: ',
        description = 'Players Health'
    },
    Armour = {
        icon = false,
        toggle = true,
        title = 'Armour: ',
        description = 'Players Armour'
    },
    Job = {
        icon = false,
        toggle = true,
        title = 'Job: ',
        description = 'Players Job'
    },
    Group = {
        icon = false,
        toggle = true,
        title = 'Group: ',
        description = 'Players Rank'  
    }
}
