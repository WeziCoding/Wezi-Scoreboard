--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3

local ServerSlots = 48
CreateThread(function()
    ESX.TriggerServerCallback("wezi-scoreboard:GetSlotCount", function(SlotCount)
        ServerSlots = SlotCount
    end)
end)


local sec = function(data)
    local options = {{
        icon = "fa-solid fa-person",
        title = 'Player Name: '..data.FiveMName,
        description = 'Ingame Name',
    }}

    if Config.Options.ID.toggle then
        options[#options+1] = {
            icon = Config.Options.ID.icon or "fa-solid fa-person",
            title = Config.Options.ID.title..' '.. data.Id,
            description = Config.Options.ID.description
        }
    end
    if Config.Options.Ping.toggle then
        options[#options+1] = {
            icon = Config.Options.Ping.icon or "fa-solid fa-person",
            title = Config.Options.Ping.title..' '..data.Ping..'MS',
            description = Config.Options.Ping.description
        }
    end
    if Config.Options.Health.toggle then
        options[#options+1] = {
            icon = Config.Options.Health.icon or "fa-solid fa-person",
            title = Config.Options.Health.title..' '..tostring(data.Health),
            description = Config.Options.Health.description
        }
    end
    if Config.Options.Armour.toggle then
        options[#options+1] = {
            icon = Config.Options.Armour.icon or "fa-solid fa-person",
            title = Config.Options.Armour.title..' '..data.Armour,
            description = Config.Options.Armour.description
        }
    end
    if Config.Options.Job.toggle then
        options[#options+1] = {
            icon = Config.Options.Job.icon or "fa-solid fa-person",
            title = Config.Options.Job.title..' '..data.Job..' ' ..data.JobGrade,
            description = Config.Options.Job.description
        }
    end
    if Config.Options.Group.toggle then
        options[#options+1] = {
            icon = Config.Options.Group.icon or "fa-solid fa-person",
            title = Config.Options.Group.title..' '..data.Group,
            description = Config.Options.Group.description
        }
    end
    lib.registerContext({
        id = 'das',
        title = data.Name,
        menu = 'tdsdasdsadsa',
        onExit = function()
            if Config.Animation then
                if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD") then
                    ClearPedTasks(PlayerPedId())
                end
            end
        end,
        options = options        
      })
      lib.showContext('das')
end

function Menu()
    local header 
    ESX.TriggerServerCallback("wezi-Scoreboard:GetPlayers", function(SentPlayers, PlayerCount)
    local Elements = {}

    if Config.Options.Header.toggle then
        header = "Online Players: " .. PlayerCount .. "/" ..ServerSlots
    else
        Elements[#Elements+1] ={icon = "fas fa-info-circle",title = "Online Players: " .. PlayerCount .. "/" ..ServerSlots}
        header = Config.Options.Header.translation
    end

    for i=1, #SentPlayers do
        Elements[#Elements + 1] = {
            title = SentPlayers[i].FiveMName,
            icon = "fa-solid fa-person",
            value = "player",

            onSelect = function()  --SentPlayers[i]
             sec(SentPlayers[i])
            end

        }
    end
    Elements[#Elements + 1] = {
        icon = "fa-solid fa-xmark",
        title = "Close",
        value = "close"
    }

        lib.registerContext({
            id = 'tdsdasdsadsa',
            title = header,
            menu = 'tdsdasdsadsa',
            onExit = function()
                if Config.Animation then
                    if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD") then
                        ClearPedTasks(PlayerPedId())
                    end
                end
            end,
            options = Elements,
            onSelect = function(args)
                print(args)
            end
          })
          lib.showContext('tdsdasdsadsa')
    end)
end

if Config.Key.toggle then
RegisterKeyMapping("showsc", "Open Scoreboard", "keyboard", Config.Key.key)
end

RegisterCommand('showsc', function(source, args, rawCommand) 
    if Config.Animation then
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true);
        Menu() 
    else
        Menu() 
    end
end, false)



