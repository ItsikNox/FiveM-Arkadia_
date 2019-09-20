MF_DnaTracker = {}
local MDF = MF_DnaTracker
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MDF.BloodObject = "p_bloodsplat_s"
MDF.ResidueObject = "w_pi_flaregun_shell"

-- JOB Database Table: LABEL
MDF.PoliceJob = "LSPD"
MDF.AmbulanceJob = "LSPD"

MDF.DNAAnalyzePos = vector3(454.69, -979.95, 30.68)
MDF.AmmoAnalyzePos = vector3(461.17, -979.74, 30.68)
MDF.DrawTextDist = 3.0
MDF.MaxObjCount = 10