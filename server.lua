local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

desmanche = Tunnel.getInterface("desmanche")

marto = {}
Tunnel.bindInterface("desmanche", marto)


function marto.pagamentodesmanche ()
    local source = source 
    local user_id = vRP.getUserId(source)
        for k, v in pairs(Config.itens) do 
        local randomQuantidade = math.random(v.quantidade.min, v.quantidade.max)
        vRP.giveInventoryItem(user_id, v.item, randomQuantidade)
        TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>" .. v.item ..  " <b> "  ..randomQuantidade.. "x" )
    end
end

	
