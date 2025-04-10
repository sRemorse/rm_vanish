-- Keep track of who is currently vanished (by server ID)
local vanishedPlayers = {}

-- Listen to server telling us to update a player's visibility
RegisterNetEvent("vanish:updateVisibility")
AddEventHandler("vanish:updateVisibility", function(serverId, shouldVanish)
    local clientPlayer = GetPlayerFromServerId(serverId)
    if clientPlayer == -1 then return end  -- Player not valid (probably disconnected)

    local ped = GetPlayerPed(clientPlayer)
    if not DoesEntityExist(ped) then return end

    if shouldVanish then
        vanishedPlayers[serverId] = true

        -- Hide the player
        SetEntityVisible(ped, false, false)
        SetEntityAlpha(ped, 0, false)

        -- No collisions or AI interaction
        SetEntityCollision(ped, false, false)
        SetEveryoneIgnorePlayer(ped, true)
        SetPedCanBeTargetted(ped, false)
    else
        vanishedPlayers[serverId] = nil

        -- Reveal the player
        SetEntityVisible(ped, true, false)
        ResetEntityAlpha(ped)

        -- Restore collisions and AI interaction
        SetEntityCollision(ped, true, true)
        SetEveryoneIgnorePlayer(ped, false)
        SetPedCanBeTargetted(ped, true)
    end
end)

AddEventHandler("onClientResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerServerEvent("vanish:requestStates")
    end
end)
