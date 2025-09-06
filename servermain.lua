-- THIS FILE IS FULLY OPTIONAL AND IS FOR ADMIN USE (YOU CAN ADD YOUR OWN ACTIONS)

local QBCore = exports['qb-core']:GetCoreObject()

-- Example: heal a player (admin-only)
RegisterNetEvent("custom:healPlayer", function(targetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Only allow admins
    if Player.PlayerData.job.name == "admin" or Player.PlayerData.permission_level >= 1 then
        local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
        if TargetPlayer then
            TriggerClientEvent("QBCore:Notify", targetId, "You have been healed by an admin!", "success")
            TriggerClientEvent("hospital:client:Revive", targetId) -- Optional: revive
        else
            TriggerClientEvent("QBCore:Notify", src, "Player not found!", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have permission to do this!", "error")
    end
end)

-- Example: teleport to a player (admin-only / Note: You can add your own actions/commands/events.
RegisterNetEvent("custom:teleportToPlayer", function(targetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "admin" or Player.PlayerData.permission_level >= 1 then
        local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
        if TargetPlayer then
            TriggerClientEvent("custom:teleportToCoords", src, GetEntityCoords(GetPlayerPed(targetId - 1)))
        else
            TriggerClientEvent("QBCore:Notify", src, "Player not found!", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have permission!", "error")
    end
end)
