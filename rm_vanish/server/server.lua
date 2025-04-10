local vanishedUsers = {}

RegisterCommand("vanish", function(source, args, rawCommand)

    local isVanished = vanishedUsers [source] == true
    
    if not IsPlayerAceAllowed(source, "command.vanish") then
        print("No permission")
        return
    end

    if isVanished then
        UpdatePlayerVisibility(source, nil)
    else
        UpdatePlayerVisibility(source, true)
    end

    -- Notify all regular clients to vanish the player
    function UpdatePlayerVisibility(vanishedId, isVanished)
        for _, targetId in ipairs(GetPlayers()) do
            targetId = tonumber(targetId)
            if not vanishedUsers[targetId] or targetId == vanishedId then
                TriggerClientEvent("vanish:updateVisibility", targetId, vanishedId, isVanished)
            end
        end
    end

    TriggerClientEvent("chat:addMessage", source, {
        args = { "[VANISH]", not isVanished and "Vanish Enabled." or "Vanish Disabled." }
    })

end, false)

-- Handle Events

AddEventHandler("playerJoining", function()
    local joiningPlayer = source
    for serverId, _ in pairs(vanishedUsers) do
        TriggerClientEvent("vanish:updateVisibility", joiningPlayer, serverId, true)
    end
end)

AddEventHandler("playerDropped", function()
    vanishedUsers[source] = nil
end)

RegisterNetEvent("vanish:requestStates", function()
    local requestingPlayer = source
    for serverId, _ in pairs(vanishedUsers) do
        TriggerClientEvent("vanish:updateVisibility", requestingPlayer, serverId, true)
    end
end)