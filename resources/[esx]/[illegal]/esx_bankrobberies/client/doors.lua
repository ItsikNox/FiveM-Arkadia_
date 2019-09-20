RegisterNetEvent("esx_bankrobbery:openDoor")
AddEventHandler("esx_bankrobbery:openDoor", function(bankId)
    OpenDoor(bankId)
end)

function ResetDoor(bankId)
    local Bank = BankHeists[bankId]
    local door = GetClosestObjectOfType(Bank['Bank_Vault']['x'], Bank['Bank_Vault']['y'], Bank['Bank_Vault']['z'], 3.0, Bank['Bank_Vault']['model'])

    SetEntityRotation(door, 0.0, 0.0, Bank["Bank_Vault"]["hStart"], 0.0)
end

function ResetDoors()
    for bank, values in pairs(BankHeists) do
        local door = GetClosestObjectOfType(values['Bank_Vault']['x'], values['Bank_Vault']['y'], values['Bank_Vault']['z'], 3.0, values['Bank_Vault']['model'])

        SetEntityRotation(door, 0.0, 0.0, values["Bank_Vault"]["hStart"], 0.0)

        FreezeEntityPosition(door, true)
    end
end

function OpenDoor(bankId)
    ResetDoor(bankId)

    local Bank = BankHeists[bankId]

    local door = GetClosestObjectOfType(Bank['Bank_Vault']['x'], Bank['Bank_Vault']['y'], Bank['Bank_Vault']['z'], 3.0, Bank['Bank_Vault']['model'])
    local rotation = GetEntityRotation(door)["z"]

	Citizen.CreateThread(function()
		FreezeEntityPosition(door, false)

        while rotation >= Bank["Bank_Vault"]["hEnd"] do
            Citizen.Wait(1)

            rotation = rotation - 0.25

            SetEntityRotation(door, 0.0, 0.0, rotation)
        end

		FreezeEntityPosition(door, true)
    end)

end
