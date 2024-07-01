--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
--- Support/Dev Discord https://discord.com/invite/Da9EM2Dgf3
local ServerSlots = GetConvarInt("sv_maxclients", 48)
local ESX
local QBCore
if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local ServerCallback = function(...)
    if Config.Framework == 'esx' then
        ESX.RegisterServerCallback(...)
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        QBCore.Functions.CreateCallback(...)
    end
end

local GetCurrentPlayers = function()
    if Config.Framework == 'esx' then
        return ESX.GetExtendedPlayers()
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        local Players = QBCore.Functions.GetQBPlayers()
        return Players
    end
end


local GetName = function(target)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(target)
        return xPlayer.getName()
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        local xPlayer = QBCore.Functions.GetPlayer(target)
        return xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    end
end

local GetIdentifier = function(target)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(target)
        return xPlayer.identifier
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        return QBCore.Functions.GetIdentifier(target, 'license')
    end
end

local GetJobLabel = function(target) 
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(target)
        return xPlayer.job.label
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        local xPlayer = QBCore.Functions.GetPlayer(target)
        return xPlayer.PlayerData.job.label
    end
end

local GetGradeLabel = function(target)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(target)
        return xPlayer.job.grade_label
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        local xPlayer = QBCore.Functions.GetPlayer(target)
        return xPlayer.PlayerData.job.grade.name
    end
end

local GetGroup = function(target)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(target)
        return xPlayer.group
    elseif Config.Framework == 'qb' or 'qbcore' or 'qbox' then
        local perm
        local perms = QBCore.Functions.HasPermission(target, 'god')
        if perms then perm = 'God' else perm = 'User' end
        return perm
    end
end

ServerCallback("wezi-Scoreboard:GetPlayers", function(source, cb)
    local id 
    local xPlayers = GetCurrentPlayers()
    local SentPlayers = {}
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        if Config.Framework == 'esx' then id = xPlayer.source elseif Config.Framework == 'qb' or 'qbox' then id = xPlayer.PlayerData.source end
        local PlayerPed = GetPlayerPed(id)
        local PlayerHealth = math.floor(GetEntityHealth(PlayerPed) / GetEntityMaxHealth(PlayerPed) * 100) or "N/A"
        local PlayerArmour = GetPedArmour(PlayerPed)
        SentPlayers[#SentPlayers + 1] = {
            Name = GetName(id),
            identifier = GetIdentifier(id),
            Id = id,
            Ping = GetPlayerPing(id),
            FiveMName = GetPlayerName(id),
            Job = GetJobLabel(id),
            JobGrade = GetGradeLabel(id),
            Group = GetGroup(id),
            Health = PlayerHealth,
            Armour = PlayerArmour
        }
    end
    cb(SentPlayers, #xPlayers)
end)

ServerCallback("wezi-scoreboard:GetSlotCount", function(source, cb)
    cb(ServerSlots)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('[^6INFO^7] ^2' .. resourceName .. '^7 has been ^2Started.^7')
end)
