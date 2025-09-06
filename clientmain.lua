local QBCore = exports['qb-core']:GetCoreObject()
local ox_lib = exports.ox_lib

-- Mapping keys for hotkey
local Keys = {
    ["F5"] = 167
}

-- Open the server players menu
local function OpenPlayersMenu()
    local players = QBCore.Functions.GetPlayers() -- get all online player IDs
    local menuElements = {}

    for _, playerId in ipairs(players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            table.insert(menuElements, {
                label = player.PlayerData.charinfo.firstname.." "..player.PlayerData.charinfo.lastname.." ["..playerId.."]",
                value = playerId,
                desc = "Job: "..player.PlayerData.job.name.." | Ping: "..GetPlayerPing(playerId)
            })
        end
    end

    if #menuElements == 0 then
        table.insert(menuElements, {label = "No players online", value = "none"})
    end

    ox_lib:menu({
        title = "Server Players",
        align = "top-left",
        elements = menuElements,
        search = true,
        onSelect = function(menuData)
            if menuData.value ~= "none" then
                local targetId = menuData.value
                local targetPed = GetPlayerPed(targetId - 1)
                if targetPed and DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    SetNewWaypoint(targetCoords.x, targetCoords.y)
                    QBCore.Functions.Notify("Waypoint set to "..menuData.label, "success")
                else
                    QBCore.Functions.Notify("Unable to find player ped.", "error")
                end
            end
        end
    })
end

-- Command to open the menu
RegisterCommand("playersmenu", function()
    OpenPlayersMenu()
end)

-- Hotkey support
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, Keys["F5"]) then
            OpenPlayersMenu()
        end
    end
end)
