ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj 
end)

local open = false 
local MenuArmurerie = RageUI.CreateMenu("", "Interaction")
local sub_menuleger = RageUI.CreateSubMenu(MenuArmurerie, "", "INTERACTION") 
MenuArmurerie.Display.Header = true 
MenuArmurerie.Close = function()
    open = false 
end

local label = 0
local model = 0
local price = 0

function OpenMenuArmurerie()
    if open then 
        open = false 
        RageUI.Visible(MenuArmurerie, true)
        return 
    else 
        open = true 
        RageUI.Visible(MenuArmurerie, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(MenuArmurerie, function()
                    RageUI.Button("~c~→~s~ Shop Illegal", nil, {RightLabel = ""}, true, {}, sub_menuleger)
                end)
                 
                RageUI.IsVisible(sub_menuleger, function()
                    for k,v in pairs(Config.Armes) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                            onSelected = function() -- si le joueur sélectionne ce bouton
                                TriggerServerEvent("volrix:BuyWeaponCash", label, model, price)
                                ESX.ShowAdvancedNotification("Vendeur", "~r~Message", "~r~Soyer prudent quelqu'un vous a vus !", "CHAR_MP_FAM_BOSS", 7)
                                TriggerServerEvent("vshopillegal:lspd")
                                label = v.Label
                                model = v.Model
                                price = v.Price                             
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end 
end

local position = {
    {x = 15.5, y = 6435.68, z = 32.10}
}

Citizen.CreateThread(function()
    while true do
		local wait = 750

			for k in pairs(Config.pos) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.pos
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= Config.MarkerDistance then
                wait = 0
                Visual.Subtitle("Appuyer sur [~b~E~s~] pour discuter avec le vendeur")
                DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end

			if dist <= 1.5 then
                wait = 0
                if IsControlJustPressed(1,51) then
                    discu()
                    OpenMenuArmurerie()
                end
		    end
		end
    Wait(wait)
    end
end)

local positionPedAmmu = {
	{x = 15.57, y = 6436.71, z = 30.40, h = 175.09} 
}

function discu()
    FreezeEntityPosition(PlayerPedId(), true)
    Visual.Subtitle("[~r~Vous~s~] YO J'aurai besoin d'une arme !", 3000)
    Wait(3000)
    Visual.Subtitle("[~b~Vendeur~s~]YO Man C'est Quoi ton budget ?", 3000)
    Wait(3000)
    local count = KeyboardInput("YO Man C'est Quoi ton budget ?", nil, 8)
    count = tonumber(count)
    Wait(500)
    Visual.Subtitle("[~r~Vous~s~] J'ai ~r~"..count.."$~s~ comme budget !", 3000)
    Wait(3000)
    Visual.Subtitle("[~b~Vendeur~s~] Je te laisse Regarder les produits alors", 3000)
    Wait(3000)
    FreezeEntityPosition(PlayerPedId(), false)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

Citizen.CreateThread(function()
    local hash = GetHashKey("g_m_y_mexgoon_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	for k,v in pairs(positionPedAmmu) do
	ped = CreatePed("PED_TYPE_CIVMALE", "g_m_y_mexgoon_01", v.x, v.y, v.z, v.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
	end
end)