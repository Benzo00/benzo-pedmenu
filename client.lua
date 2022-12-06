local function Menu()
    local elements = {{
        unselectable = true,
        title = "Ped Menu",
        icon = "fa-sharp fa-solid fa-check"

    }, {
        title = "Restore",
        icon = "fa-solid fa-person",
        value = "restore"
    }}
    for i = 1, #Config.Peds do
        elements[#elements + 1] = {
            title = Config.Peds[i].title,
            spawnname = Config.Peds[i].spawnname,
            icon = Config.Peds[i].icon,
            value = "ped"
        }
    end
    ESX.OpenContext(Config.MenuPosition, elements, function(menu, element)
        local spawnname = element.spawnname
        if element.value == "restore" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                local isMale = skin.sex == 0
                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end)
        end
        if element.value == "ped" then
            if IsModelInCdimage(spawnname) and IsModelValid(spawnname) then
                RequestModel(spawnname)
                while not HasModelLoaded(spawnname) do
                    Wait(0)
                end
                SetPlayerModel(PlayerId(), spawnname)
                SetModelAsNoLongerNeeded(spawnname)
            else
                ESX.ShowNotification("Invalid Model", "error")
            end
        end

    end)
end

RegisterCommand("pedmenu", function()
    Menu()
end)

RegisterKeyMapping('pedmenu', 'Ped Menu', 'keyboard', 'i')
