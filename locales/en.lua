local Translations = {
    error = {
        ["canceled"]                    = "Canceled..",
        ["no_coke"]  = "You don't have any coke..",
    },
    success = {
        ["sold_coke"]                           = "You sold all your Cocaine..",
        ["hint_first"]  = "Your first letter is W...",
    },
    target = {
        ["cokebuyer"]                     = "Sell Cocaine",
    },
    progress = {
        ["selling_coke"]                      = "You are selling your Coke..",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
