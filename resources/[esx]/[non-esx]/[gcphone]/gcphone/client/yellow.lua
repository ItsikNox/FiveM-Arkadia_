--====================================================================================
-- # Discord gcphone#7085
--====================================================================================

RegisterNetEvent("gcphone:yellow_getPagess")
AddEventHandler("gcphone:yellow_getPagess", function(pagess)
  SendNUIMessage({event = 'yellow_pagess', pagess = pagess})
end)

RegisterNetEvent("gcphone:yellow_newPagess")
AddEventHandler("gcphone:yellow_newPagess", function(pages)
  SendNUIMessage({event = 'yellow_newPages', pages = pages})
end)

RegisterNetEvent("gcphone:yellow_showError")
AddEventHandler("gcphone:yellow_showError", function(title, message)
  SendNUIMessage({event = 'yellow_showError', message = message, title = title})
end)

RegisterNetEvent("gcphone:yellow_showSuccess")
AddEventHandler("gcphone:yellow_showSuccess", function(title, message)
  SendNUIMessage({event = 'yellow_showSuccess', message = message, title = title})
end)

RegisterNUICallback('yellow_getPagess', function(data, cb)
  TriggerServerEvent('gcphone:yellow_getPagess', data.firstname, data.phone_number)
end)

RegisterNUICallback('yellow_postPages', function(data, cb)
  TriggerServerEvent('gcphone:yellow_postPagess', data.firstname or '', data.phone_number or '', data.lastname or '', data.message)
end)

RegisterNUICallback('deleteYellow', function(data)
  TriggerServerEvent('gcphone:deleteYellow', data.id)
end)



