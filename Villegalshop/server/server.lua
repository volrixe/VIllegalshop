ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterNetEvent("volrix:BuyWeaponCash")
AddEventHandler("volrix:BuyWeaponCash", function(label, model, price)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		xPlayer.addWeapon(model, 1)
		TriggerClientEvent('esx:showAdvancedNotification', _src, 'Vendeur', 'Achat', "Tenez votre ~y~x1~s~ ~b~"..label.."~s~ donne moi ~g~"..price.."$", 'CHAR_MP_BIKER_BOSS', 1)
		TriggerClientEvent('esx:showAdvancedNotification', _src, 'Banque', 'Payement', "Vous avez été debiter de ~g~"..price.."$", 'CHAR_BANK_FLEECA', 1)
	else 
		TriggerClientEvent('esx:showAdvancedNotification', _src, 'Vendeur', 'Payement', "~r~Tu te fous de moi , ta pas assez d'argent pour payer !?", 1)
	end
end)

RegisterServerEvent("vshopillegal:lspd")
AddEventHandler("vshopillegal:lspd", function()
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'police' then
               Citizen.Wait(0)
               TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Citoyens', '~b~Message LSPD', 'Une vente a eu lieux dans le nord !', 'CHAR_BLANK_ENTRY', 7) 
		end
	end
end)