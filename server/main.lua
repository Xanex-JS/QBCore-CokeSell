local QBCore = exports['qb-core']:GetCoreObject()
players = {}

-- Get active police

QBCore.Functions.CreateCallback('ActivePolice', function(result, cb)
	local result = QBCore.Functions.GetDutyCount('police') -- Not a QBCore function?
	cb(result)
end)

--  Selling Coke With not enough cops online function

RegisterNetEvent("qb-cokesell:SellCokeNotEnough", function()
	local src = source;
	local Player = QBCore.Functions.GetPlayer(src);
	local price = 0;
	
	for k, v in next, Player.PlayerData.items do
		for i=1, #Config.CokeInfoNotEnough do
			local data = Config.CokeInfoNotEnough[i];
			if data.item == v.name then
				price = price + (data.price * v.amount);
				Player.Functions.RemoveItem(v.name, v.amount, k);
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], 'remove')
				break
			end
		end
	end
	
	Player.Functions.AddItem("cash", price);
	TriggerClientEvent('QBCore:Notify', source, Lang:t("success.sold_coke"), 'success')
end) 


-- Selling Function

RegisterNetEvent("qb-cokesell:SellCoke", function()
	local src = source;
	local Player = QBCore.Functions.GetPlayer(src);
	local price = 0;
	
	for k, v in next, Player.PlayerData.items do
		for i=1, #Config.CokeInfo do
			local data = Config.CokeInfo[i];
			if data.item == v.name then
				price = price + (data.price * v.amount);
				Player.Functions.RemoveItem(v.name, v.amount, k);
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], 'remove')
				break
			end
		end
	end
	
	Player.Functions.AddItem("cash", price);
	TriggerClientEvent('QBCore:Notify', source, Lang:t("success.sold_coke"), 'success')
end) 

RegisterNetEvent('qb-cokesell:hinta', function()
    TriggerClientEvent('QBCore:Notify', Lang:t("success.hint_first"), 'success')
end)