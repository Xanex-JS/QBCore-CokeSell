local QBCore = exports['qb-core']:GetCoreObject()
players = {}

-- Restore Dealers account when resources starts/restarts

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
	local information = {Money = Config.Dealer['SetDealerMoney']}
	
	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)
   end
end)

-- Give dealer money thread. 

function CokeBal()

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json") 
	local extract = {}
	extract = json.decode(loadFile)
	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(extract), -1)
	return extract.Money

end

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(Config.Dealer['RefreshTimer'])

		if CokeBal() < Config.Dealer['LowestBalance'] and Config.Dealer['OnlyGiveMoneyWhenBroke'] == true then 

		local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
		local information = {
			Money = Config.Dealer['ShipmentAmount']
		}

		TriggerClientEvent('QBCore:Notify', -1,  "The coke dealer has recived a money shipment of $" .. information.Money)
		print("Coke Dealer Shipment")
		
		SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

	elseif Config.Dealer['OnlyGiveMoneyWhenBroke'] == false then 		-- randomly give dealer money if the config OnlyGiveMoneyWhenBroke is false

		local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
		local information = {
			Money = Config.Dealer['ShipmentAmount']
		}

		TriggerClientEvent('QBCore:Notify', -1,  "The coke dealer has recived a money shipment of $" .. information.Money)
		print("Coke Dealer Shipment")
		
		SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

	end


	end
  end)

-- Coke dealer commands

QBCore.Commands.Add('SetCokeBal', 'Admin Force set the Coke Dealers Bank Account', {}, false, function(source, args)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
	local information = {Money = tonumber(args[1])}
	
	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

	TriggerClientEvent('QBCore:Notify', source,  "Success, Set the Coke Dealers Balance to $" .. args[1])

end, 'admin')

QBCore.Commands.Add('CokeBal', 'Check how much money the coke dealer has', {}, false, function(source, args)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json") 
	local extract = {}
	extract = json.decode(loadFile)

	print("The Coke Dealer Has ^2$" .. extract.Money .. "^0 In there bank account")

	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(extract), -1)

end)

QBCore.Functions.CreateCallback("CheckDealerBal", function(source, cb)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json") 
	local extract = {}
	extract = json.decode(loadFile)
	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(extract), -1)
	local result1 = extract.Money
	cb(result1)

end)

RegisterNetEvent('RemoveMoneyFromDealersAccount', function()

	for k, v in pairs(Config.CokeInfoNotEnough) do
		
		local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
		local information = {Money = v.price}
		
		SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

    end

end)
-- Get active police

QBCore.Functions.CreateCallback('ActivePolice', function(result, cb)
	local result = QBCore.Functions.GetDutyCount('police') -- Not a QBCore function?
	cb(result)
end)

function GetMoney()

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json") 
	local extract = {}
	extract = json.decode(loadFile)
	SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(extract), -1)
	return extract.Money

end

--  Selling Coke With not enough cops online function

RegisterNetEvent("qb-cokesell:SellCokeNotEnough", function()
	local src = source;
	local Player = QBCore.Functions.GetPlayer(src);
	local price = 0;
	local TakeMoney = 0;
	local MoneyGiven = 0;
	
	for k, v in next, Player.PlayerData.items do
		for i=1, #Config.CokeInfoNotEnough do
			local data = Config.CokeInfoNotEnough[i];
			if data.item == v.name then
				price = price + (data.price * v.amount);
				Player.Functions.RemoveItem(v.name, v.amount, k);

				local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
				local information = {Money = GetMoney() - price}
				
				SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], 'remove')


				break
			end
		end
	end
	
	Player.Functions.AddMoney("cash", price)
	TriggerClientEvent('QBCore:Notify', source, Lang:t("success.sold_coke"), 'success')
end) 


-- Selling Functions

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

				local loadFile = LoadResourceFile(GetCurrentResourceName(), "./money.json")
				local information = {Money = GetMoney() - price}
				
				SaveResourceFile(GetCurrentResourceName(), "money.json", json.encode(information), -1)

				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.name], 'remove')
				break
			end
		end
	end
	
	Player.Functions.AddMoney("cash", price)
	TriggerClientEvent('QBCore:Notify', source, Lang:t("success.sold_coke"), 'success')
end) 

RegisterNetEvent('qb-cokesell:hinta', function()
    TriggerClientEvent('QBCore:Notify', Lang:t("success.hint_first"), 'success')
end)