addEvent("onZombieWasted",true)
addEventHandler("onZombieWasted",root,
function (killer)
    givePlayerMoney(killer,50)
end)
