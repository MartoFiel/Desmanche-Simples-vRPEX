local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

marto = Tunnel.getInterface("desmanche")

local servico 
local cdsBlip = Config.blip
local x,y,z = Config.blip.x, Config.blip.y, Config.blip.z

CreateThread(function() -- Cria a função 
    while true do 
        local ped = PlayerPedId() -- Pega o id da Entidade (player)
        local playerCds = GetEntityCoords(ped) --- Pega a cds do player 
        local distancia = #(playerCds - vec3(cdsBlip.x, cdsBlip.y, cdsBlip.z)) --- Calculo para saber se o player esta perto do blip 
        if distancia < 8 and not servico then --- Caso esteja 8 Metros do blip e fora de serviço, ele vai aparecer 
            DrawMarker(27, cdsBlip.x, cdsBlip.y, cdsBlip.z-1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 200, false, false, 2, true) --- Desenho do Blip e local
            if distancia < 1.2 then 
                if IsControlJustPressed(0, 38) then --- Verifica se o player apertou [E] e se ja nao estava em serviço
                    TriggerEvent("Notify", "sucesso", "Va ate o local de desmanche e aperte [E]", 5000) --- Notificação na tela por 5 segundos
                    servico = true 
                    emServico()
                end
            end   
        end
        Wait(5)
    end 
end)

function emServico()
    CreateThread(function()
        while servico do 
            for k, v in pairs(Config.lugar) do
                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)

                if Config.lugar[k] then 
                    local cdslugar = vec3(Config.lugar.x, Config.lugar.y, Config.lugar.z)
                    local distancia = #(playerCoords - cdslugar)
                    local veiculo = GetVehiclePedIsUsing(ped)
                    local veiculote = GetVehiclePedIsIn(ped, true)
                    if distancia < 5 then 
                        DrawMarker(27, cdslugar.x, cdslugar.y, cdslugar.z-1, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 5.0, 255, 0, 255, 200, false, false, 2, true)
                        if distancia < 3 then 
                            if IsPedInAnyVehicle(ped, true) and IsControlJustPressed(0, 38) then 
                                FreezeEntityPosition(veiculo, true) 
                                TriggerEvent("progress",10000,"DESMANCHANDO") Wait(10000)
                                DeleteEntity(veiculote)
                                marto.pagamentodesmanche()
                                servico = false 
                                FreezeEntityPosition(ped, false)
                            end
                        end     
                    end
                end
            end
            Wait(5)
        end
    end)
end

