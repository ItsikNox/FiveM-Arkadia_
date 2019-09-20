------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--


local pedInSameVehicleLast=false
local vehicle
local lastVehicle
local vehicleClass
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0
local isBrakingForward = false
local isBrakingReverse = false

local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0
local tireBurstLuckyNumber

local repairCost = 0

math.randomseed(GetGameTimer());

local tireBurstMaxNumber = cfg.randomTireBurstInterval * 1200; 												-- the tire burst lottery runs roughly 1200 times per minute
if cfg.randomTireBurstInterval ~= 0 then tireBurstLuckyNumber = math.random(tireBurstMaxNumber) end			-- If we hit this number again randomly, a tire will burst.

local fixMessagePos = math.random(repairCfg.fixMessageCount)
local noFixMessagePos = math.random(repairCfg.noFixMessageCount)

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- Display blips on map
Citizen.CreateThread(function()
	if (cfg.displayBlips == true) then
		for _, item in pairs(repairCfg.mechanics) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
	end
end)

local function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

local function isPedDrivingAVehicle()
	local ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		-- Check if ped is in driver seat
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			-- We don't want planes, helicopters, bicycles and trains
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end

local function IsNearMechanic()
	local ped = GetPlayerPed(-1)
	local pedLocation = GetEntityCoords(ped, 0)
	for _, item in pairs(repairCfg.mechanics) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  pedLocation["x"], pedLocation["y"], pedLocation["z"], true)
		if distance <= item.r then
			return true
		end
	end
end

local function fscale(inputValue, originalMin, originalMax, newBegin, newEnd, curve)
	local OriginalRange = 0.0
	local NewRange = 0.0
	local zeroRefCurVal = 0.0
	local normalizedCurVal = 0.0
	local rangedValue = 0.0
	local invFlag = 0

	if (curve > 10.0) then curve = 10.0 end
	if (curve < -10.0) then curve = -10.0 end

	curve = (curve * -.1)
	curve = 10.0 ^ curve

	if (inputValue < originalMin) then
	  inputValue = originalMin
	end
	if inputValue > originalMax then
	  inputValue = originalMax
	end

	OriginalRange = originalMax - originalMin

	if (newEnd > newBegin) then
		NewRange = newEnd - newBegin
	else
	  NewRange = newBegin - newEnd
	  invFlag = 1
	end

	zeroRefCurVal = inputValue - originalMin
	normalizedCurVal  =  zeroRefCurVal / OriginalRange

	if (originalMin > originalMax ) then
	  return 0
	end

	if (invFlag == 0) then
		rangedValue =  ((normalizedCurVal ^ curve) * NewRange) + newBegin
	else
		rangedValue =  newBegin - ((normalizedCurVal ^ curve) * NewRange)
	end

	return rangedValue
end



local function tireBurstLottery()
	local tireBurstNumber = math.random(tireBurstMaxNumber)
	if tireBurstNumber == tireBurstLuckyNumber then
		-- We won the lottery, lets burst a tire.
		if GetVehicleTyresCanBurst(vehicle) == false then return end
		local numWheels = GetVehicleNumberOfWheels(vehicle)
		local affectedTire
		if numWheels == 2 then
			affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
		elseif numWheels == 4 then
			affectedTire = (math.random(4)-1)
			if affectedTire > 1 then affectedTire = affectedTire + 2 end	-- 0, 1, 4, 5
		elseif numWheels == 6 then
			affectedTire = (math.random(6)-1)
		else
			affectedTire = 0
		end
		SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
		tireBurstLuckyNumber = math.random(tireBurstMaxNumber)			-- Select a new number to hit, just in case some numbers occur more often than others
	end
end


RegisterNetEvent('iens:repair')
AddEventHandler('iens:repair', function()
	if isPedDrivingAVehicle() then
		local ped = GetPlayerPed(-1)		
		vehicle = GetVehiclePedIsIn(ped, false)		
		local engineHealth  = GetVehicleEngineHealth(vehicle)
		local repairCost = math.floor((1000 - engineHealth)/1000*cfg.price*cfg.DamageMultiplier)
		
		if engineHealth == 1000 then
			repairCost = 150
		end
		
		if IsNearMechanic() then
			if GetIsVehicleEngineRunning(vehicle) then
				notification("~g~Engine must be turned off to repair")
				return
			else
				local mechNumb = math.random(1,3)
				if PlayerData.job.name == 'mecano' then
					SetVehicleUndriveable(vehicle,false)
					SetVehicleFixed(vehicle)
					healthBodyLast=1000.0
					healthEngineLast=1000.0
					healthPetrolTankLast=1000.0
					SetVehicleEngineOn(vehicle, true, false )
					notification("~g~You fixed the car!")
					return			
				else
					if mechNumb == 1 then
						notification("~g~Dave the mechanic is looking at your car")
						Citizen.Wait(11000)
						notification("~g~Dave is working on your car")
						Citizen.Wait(11000)
						if GetIsVehicleEngineRunning(vehicle) then
							notification("~g~Engine must remain off for repair")
							return
						else
							SetVehicleUndriveable(vehicle,false)
							SetVehicleFixed(vehicle)
							healthBodyLast=1000.0
							healthEngineLast=1000.0
							healthPetrolTankLast=1000.0
							SetVehicleEngineOn(vehicle, true, false )
							if cfg.chargeForRepairs then
								TriggerServerEvent('rvFailure:takemoney', repairCost)
								notification("~g~Dave repaired your car for $" .. repairCost .. "!")
								return
							else
								notification("~g~Dave repaired your car!")
								return
							end
						end
					elseif mechNumb == 2 then
						notification("~g~Mike the mechanic is looking at your car")
						Citizen.Wait(11000)
						notification("~g~Mike looks confused")
						Citizen.Wait(11000)
						notification("~g~Mike starts hitting things with a hammer")
						Citizen.Wait(11000)
						notification("~g~Mike goes to look for help")
						Citizen.Wait(11000)
						notification("~g~Mike's Manager comes back and starts working on your car")
						Citizen.Wait(11000)	
						notification("~g~The Manager is also hitting things with a hammer")
						Citizen.Wait(11000)	
						if GetIsVehicleEngineRunning(vehicle) then
							notification("~g~Engine must remain off for repair")
							return
						else				
							SetVehicleUndriveable(vehicle,false)
							SetVehicleFixed(vehicle)
							healthBodyLast=1000.0
							healthEngineLast=1000.0
							healthPetrolTankLast=1000.0
							SetVehicleEngineOn(vehicle, true, false )
							if cfg.chargeForRepairs then
								TriggerServerEvent('rvFailure:takemoney', repairCost)
								notification("~g~The Manager repaired your car for $" .. repairCost .. "!")
								return
							else
								notification("~g~The Manager repaired your car!")
								return
							end
						end
					elseif mechNumb == 3 then
						notification("~g~Jeff the mechanic is looking at your car")
						Citizen.Wait(11000)
						notification("~g~Jeff yells for Dave to come look at it")
						Citizen.Wait(11000)
						notification("~g~Just look at it")
						Citizen.Wait(11000)
						notification("~g~Dave is working on your car")
						Citizen.Wait(11000)	
						if GetIsVehicleEngineRunning(vehicle) then	
							notification("~g~Engine must remain off for repair")
							return
						else			
							SetVehicleUndriveable(vehicle,false)
							SetVehicleFixed(vehicle)
							healthBodyLast=1000.0
							healthEngineLast=1000.0
							healthPetrolTankLast=1000.0
							SetVehicleEngineOn(vehicle, true, false )
							if cfg.chargeForRepairs then
								TriggerServerEvent('rvFailure:takemoney', repairCost)
								notification("~g~Dave repaired your car for $" .. repairCost .. "!")
								return
							else
								notification("~g~Dave repaired your car!")
								return
							end
						end
					end
				end
			end
		end
		if GetVehicleEngineHealth(vehicle) < cfg.cascadingFailureThreshold + 5 then
			if GetVehicleOilLevel(vehicle) > 0 then
				SetVehicleUndriveable(vehicle,false)
				SetVehicleEngineHealth(vehicle, cfg.cascadingFailureThreshold + 5)
				SetVehiclePetrolTankHealth(vehicle, 750.0)
				healthEngineLast=cfg.cascadingFailureThreshold +5
				healthPetrolTankLast=750.0
					SetVehicleEngineOn(vehicle, true, false )
				SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
				notification("~g~" .. repairCfg.fixMessages[fixMessagePos] .. "")
				fixMessagePos = fixMessagePos + 1
				if fixMessagePos > repairCfg.fixMessageCount then fixMessagePos = 1 end
			else
				notification("~r~Your vehicle was too badly damaged. Unable to repair!")
			end
		else
			notification("~y~" .. repairCfg.noFixMessages[noFixMessagePos] )
			noFixMessagePos = noFixMessagePos + 1
			if noFixMessagePos > repairCfg.noFixMessageCount then noFixMessagePos = 1 end
		end
	else
		notification("~y~You must be in a vehicle to be able to repair it")
	end
end)

RegisterNetEvent('iens:notAllowed')
AddEventHandler('iens:notAllowed', function()
	notification("~r~You don't have permission to repair vehicles")
end)

if cfg.torqueMultiplierEnabled or cfg.preventVehicleFlip or cfg.limpMode then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if cfg.torqueMultiplierEnabled or cfg.sundayDriver or cfg.limpMode then
				if pedInSameVehicleLast then
					local factor = 1.0
					if cfg.torqueMultiplierEnabled and healthEngineNew < 900 then
						factor = (healthEngineNew+200.0) / 1100
					end
					if cfg.sundayDriver and GetVehicleClass(vehicle) ~= 14 then -- Not for boats
						local accelerator = GetControlValue(2,71)
						local brake = GetControlValue(2,72)
						local speed = GetEntitySpeedVector(vehicle, true)['y']
						-- Change Braking force
						local brk = fBrakeForce
						if speed >= 1.0 then
							-- Going forward
							if accelerator > 127 then
								-- Forward and accelerating
								local acc = fscale(accelerator, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
								factor = factor * acc
							end
							if brake > 127 then
								-- Forward and braking
								isBrakingForward = true
								brk = fscale(brake, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
							end
						elseif speed <= -1.0 then
							-- Going reverse
							if brake > 127 then
								-- Reversing and accelerating (using the brake)
								local rev = fscale(brake, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
								factor = factor * rev
							end
							if accelerator > 127 then
								-- Reversing and braking (Using the accelerator)
								isBrakingReverse = true
								brk = fscale(accelerator, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
							end
						else
							-- Stopped or almost stopped or sliding sideways
							local entitySpeed = GetEntitySpeed(vehicle)
							if entitySpeed < 1 then
								-- Not sliding sideways
								if isBrakingForward == true then
									--Stopped or going slightly forward while braking
									DisableControlAction(2,72,true) -- Disable Brake until user lets go of brake
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingReverse == true then
									--Stopped or going slightly in reverse while braking
									DisableControlAction(2,71,true) -- Disable reverse Brake until user lets go of reverse brake (Accelerator)
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingForward == true and GetDisabledControlNormal(2,72) == 0 then
									-- We let go of the brake
									isBrakingForward=false
								end
								if isBrakingReverse == true and GetDisabledControlNormal(2,71) == 0 then
									-- We let go of the reverse brake (Accelerator)
									isBrakingReverse=false
								end
							end
						end
						if brk > fBrakeForce - 0.02 then brk = fBrakeForce end -- Make sure we can brake max.
						SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', brk)  -- Set new Brake Force multiplier
					end
					if cfg.limpMode == true and healthEngineNew < cfg.engineSafeGuard + 5 then
						factor = cfg.limpModeMultiplier
					end
					SetVehicleEngineTorqueMultiplier(vehicle, factor)
				end
			end
			if cfg.preventVehicleFlip then
				local roll = GetEntityRoll(vehicle)
				if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
					DisableControlAction(2,59,true) -- Disable left/right
					DisableControlAction(2,60,true) -- Disable up/down
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		local ped = GetPlayerPed(-1)
		if isPedDrivingAVehicle() then
			vehicle = GetVehiclePedIsIn(ped, false)
			vehicleClass = GetVehicleClass(vehicle)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
			if healthEngineCurrent == 1000 then healthEngineLast = 1000.0 end
			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * cfg.damageFactorEngine * cfg.classDamageMultiplier[vehicleClass]

			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
			if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * cfg.damageFactorBody * cfg.classDamageMultiplier[vehicleClass]

			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
			if cfg.compatibilityMode and healthPetrolTankCurrent < 1 then
				--	SetVehiclePetrolTankHealth(vehicle, healthPetrolTankLast)
				--	healthPetrolTankCurrent = healthPetrolTankLast
				healthPetrolTankLast = healthPetrolTankCurrent
			end
			if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
			healthPetrolTankNew = healthPetrolTankCurrent
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * cfg.damageFactorPetrolTank * cfg.classDamageMultiplier[vehicleClass]

			if healthEngineCurrent > cfg.engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,false)
			end

			if healthEngineCurrent <= cfg.engineSafeGuard+1 and cfg.limpMode == false then
				SetVehicleUndriveable(vehicle,true)
			end

			-- If ped spawned a new vehicle while in a vehicle or teleported from one vehicle to another, handle as if we just entered the car
			if vehicle ~= lastVehicle then
				pedInSameVehicleLast = false
			end


			if pedInSameVehicleLast == true then
				-- Damage happened while in the car = can be multiplied

				-- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then

					-- Combine the delta values (Get the largest of the three)
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)

					-- If huge damage, scale back a bit
					if healthEngineCombinedDelta > (healthEngineCurrent - cfg.engineSafeGuard) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end

					-- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (cfg.cascadingFailureThreshold / 5)
					end


					------- Calculate new value

					healthEngineNew = healthEngineLast - healthEngineCombinedDelta


					------- Sanity Check on new values and further manipulations

					-- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop

					if healthEngineNew > (cfg.cascadingFailureThreshold + 5) and healthEngineNew < cfg.degradingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.038 * cfg.degradingHealthSpeedFactor)
					end

					-- If Damage is near catastrophic, cascade the failure
					if healthEngineNew < cfg.cascadingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.1 * cfg.cascadingFailureSpeedFactor)
					end

					-- Prevent Engine going to or below zero. Ensures you can reenter a damaged car.
					if healthEngineNew < cfg.engineSafeGuard then
						healthEngineNew = cfg.engineSafeGuard
					end

					-- Prevent Explosions
					if cfg.compatibilityMode == false and healthPetrolTankCurrent < 750 then
						healthPetrolTankNew = 750.0
					end

					-- Prevent negative body damage.
					if healthBodyNew < 0  then
						healthBodyNew = 0.0
					end
				end
			else
				-- Just got in the vehicle. Damage can not be multiplied this round
				-- Set vehicle handling data
				fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
				fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
				local newFDeformationDamageMult = fDeformationDamageMult ^ cfg.deformationExponent	-- Pull the handling file value closer to 1
				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * cfg.deformationMultiplier) end  -- Multiply by our factor
				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier/cfg.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody

				--Get the CollisionDamageMultiplier
				fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')
				--Modify it by pulling all number a towards 1.0
				local newFCollisionDamageMultiplier = fCollisionDamageMult ^ cfg.collisionDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)

				--Get the EngineDamageMultiplier
				fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
				--Modify it by pulling all number a towards 1.0
				local newFEngineDamageMult = fEngineDamageMult ^ cfg.engineDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)

				-- If body damage catastrophic, reset somewhat so we can get new damage to multiply
				if healthBodyCurrent < cfg.cascadingFailureThreshold then
					healthBodyNew = cfg.cascadingFailureThreshold
				end
				pedInSameVehicleLast = true
			end

			-- set the actual new values
			if healthEngineNew ~= healthEngineCurrent then
				SetVehicleEngineHealth(vehicle, healthEngineNew)
			end
			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end

			-- Store current values, so we can calculate delta next time around
			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle=vehicle
			if cfg.randomTireBurstInterval ~= 0 and GetEntitySpeed(vehicle) > 10 then tireBurstLottery() end
		else
			if pedInSameVehicleLast == true then
				-- We just got out of the vehicle
				lastVehicle = GetVehiclePedIsIn(ped, true)				
				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult) end -- Restore deformation multiplier
				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult) -- Restore the original CollisionDamageMultiplier
				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult) -- Restore the original EngineDamageMultiplier
			end
			pedInSameVehicleLast = false
		end
	end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------