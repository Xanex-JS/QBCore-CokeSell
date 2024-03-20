Config = {}

-- Blip Creation

Config.UseBlip = false

Config.BlipLocation = {
	{title="Coke Dealer", colour=1, id=51, x = 240.83, y = 371.16, z = 105.74}
} 

-- Coke Selling

Config.EnableSelling = true

Config.CokeInfo  = {
    { item = "coke_brick", price = 50000 },
}
-- Not enough police needed change price ALOT
Config.CokeInfoNotEnough  = {
    { item = "coke_brick", price = math.random(10000, 20000) }, -- Chance of 10k-20k with no cops online
}

-- This is the config table for everything just dealer money related.

Config.Dealer = { 
    ['SetDealerMoney'] = 550000, -- This sets the money of the dealer when the server/script restarts.
    ['RequiredMoney'] = 50000, -- This sets how much money minimum the dealer needs to make a sale (see readme.md for more)
    ['RefreshTimer'] = 1800000, -- Wait 30 minutes before giving the dealer random money
    ['OnlyGiveMoneyWhenBroke'] = false,  -- if this is set to true the dealer will only be given money when he has ran out of money. otherwise false the dealer will be given x amount of cash every x minutes
    ['LowestBalance'] = 50000, -- the lowest amount of money the dealer can have, don't worry about this if the above config is false.
    ['ShipmentAmount'] = math.random(100000, 999999), -- The amount of money the dealer could get in a shipment
}

-- Ped Spawns

Config.Peds = {
    {
        type = 'cokebuyer',
        position = vector4(240.83, 371.16, 105.74, 249.62)
    },
}