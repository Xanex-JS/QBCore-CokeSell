local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPeds = {}
local cokePed

-- Ped Creation

function SetupCokeBuyer(coords)
    RequestModel(`a_m_m_og_boss_01`)
    while not HasModelLoaded(`a_m_m_og_boss_01`) do
    Wait(1)
    end
    cokebuyer = CreatePed(2, `a_m_m_og_boss_01`, coords.x, coords.y, coords.z-1.0, coords.w, false, false) -- Change coordinates here!
    SetPedFleeAttributes(cokebuyer, 0, 0)
    SetPedDiesWhenInjured(cokebuyer, false)
    TaskStartScenarioInPlace(cokebuyer, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(cokebuyer, true)
    SetBlockingOfNonTemporaryEvents(cokebuyer, true)
    SetEntityInvincible(cokebuyer, true)
    FreezeEntityPosition(cokebuyer, true)
end

function CreatePeds()
    for i = 1, #Config.Peds do
        if Config.Peds[i].type == 'cokebuyer' then
            SetupCokeBuyer(Config.Peds[i].position, i)
        end
    end
end

CreateThread(function()
    CreatePeds()
end)

--[[
local getCurrentPoliceActive = QBCore.Functions.TriggerCallback('ActivePolice', function(result)

    if result > Config.Pigs then 
        getPigsActive = true
        print(result)
        print("Pigs are active")
    else
        getPigsActive = false
        print("no pigs active cunt")
    end

end)
]]

-- Target Exports

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel('a_m_m_og_boss_01', {
        options = {
            {
                type = "client",
                event = "qb-cokesell:SellCokeItemCheck",
                icon = "fas fa-key",
                label = Lang:t("target.cokebuyer"),
            },
        },
        distance = 3.0
    })
end)

--[[ -- 
RegisterNetEvent('qb-cokesell:SellCokeItemCheck', function()
    QBCore.Functions.TriggerCallback('ActivePolice', function(result)
        if result > Config.PoliceNeeded then -- Two+ Police are needed to sell 
    QBCore.Functions.TriggerCallback("QBCore:HasItem", function(hasItem)
        if hasItem then
            SellCoke()
            NotifyPolice() -- send the alert
        else
            QBCore.Functions.Notify(Lang:t("error.no_coke"), "error")
        end
        end, "coke_brick")

        elseif result < Config.PoliceNeeded then  
            QBCore.Functions.Notify('Not Enough Police Online :3', 'error', 7500)
        end

end)
end)
]]

local DealerHasMoney = 

-- Change price if there's not enough coppas on
RegisterNetEvent('qb-cokesell:SellCokeItemCheck', function()
        -- if DealerHasMoney then 

    QBCore.Functions.TriggerCallback("QBCore:HasItem", function(hasItem)
    QBCore.Functions.TriggerCallback('ActivePolice', function(result) -- Check for active COPS

        if result > 1 then 

        -- check if the player has the item 
        if hasItem then
            SellCoke()

            local AlertPoliceCount = math.random(2, 4)
            print(AlertPoliceCount)

            if AlertPoliceCount == 3 then 
                -- QBCore.Functions.Notify('You hear a phone....', 'notify', 7500)
                exports['qb-dispatch']:DrugSale()
            end

        else
            QBCore.Functions.Notify(Lang:t("error.no_coke"), "error")
        end

        -- if no cops online run the below code

        elseif result < 2 and hasItem then  
            QBCore.Functions.Notify('Not Enough Police Needed the price will be extremely different :(', 'error', 7500)
            SellCokeNotEnough()
            -- AlertPolice() -- send the alert
        else
            QBCore.Functions.Notify('You Don\'t Have any Cocaine LOL', 'error', 7500)
        end
end) -- THIS CLOSES THE POLICE ONLINE CHECK
end, "coke_brick") -- THIS CLOSES THE HAS ITEM CALLBACK

-- else
    -- QBCore.Functions.Notify('The Dealer has no money', 'error', 7500)
-- end

end) -- THIS CLOSES THE REGISTERNETEVENT

function SellCokeNotEnough()
	QBCore.Functions.Progressbar("search_register", Lang:t("progress.selling_coke"), 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'mp_arresting',
		anim = 'a_uncuff',
		flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("qb-cokesell:SellCokeNotEnough")
		ClearPedTasks(GetPlayerPed(-1))
	end, function()
	    ClearPedTasks(GetPlayerPed(-1))
end)
end

-- end of change price

function SellCoke()
	QBCore.Functions.Progressbar("search_register", Lang:t("progress.selling_coke"), 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'mp_arresting',
		anim = 'a_uncuff',
		flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("qb-cokesell:SellCoke")
		ClearPedTasks(GetPlayerPed(-1))
	end, function()
	    ClearPedTasks(GetPlayerPed(-1))
end)
end