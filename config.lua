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
    { item = "coke_brick", price = math.random(10000, 35000) }, -- Chance of 10k-35k with no cops online
}

Config.SetDealerMoney = 550000 -- This sets the money of the dealer when the server/script restarts.
Config.RequiredMoney = 50000 -- This sets how much money minimum the dealer needs to make a sale (see readme.md for more)

-- Ped Spawns

Config.Peds = {
    {
        type = 'cokebuyer',
        position = vector4(240.83, 371.16, 105.74, 249.62)
    },
}