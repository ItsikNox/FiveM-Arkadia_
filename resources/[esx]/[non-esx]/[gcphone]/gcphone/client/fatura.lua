--====================================================================================
-- # Discord gcphone#7085
--====================================================================================
RegisterNetEvent("gcphone:fatura_getBilling")
AddEventHandler("gcphone:fatura_getBilling", function(billingg)
  SendNUIMessage({event = 'fatura_billingg', billingg = billingg})
end)

RegisterNUICallback('fatura_getBilling', function(data, cb)
  TriggerServerEvent('gcphone:fatura_getBilling', data.label, data.amount, data.sender)
end)

RegisterNUICallback('faturapayBill', function(data)
  TriggerServerEvent('gcphone:faturapayBill', data.id, data.sender, data.amount, data.target)
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
