MF_DopePlant = {}
local MFD = MF_DopePlant
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFD.FoodDrainSpeed      = 0.0200
MFD.WaterDrainSpeed     = 0.0200
MFD.QualityDrainSpeed   = 0.0050

MFD.GrowthGainSpeed     = 0.0010
MFD.QualityGainSpeed    = 0.0100

MFD.SyncDist = 50.0
MFD.InteractDist = 2.5
MFD.PoliceJobLabel = "LSPD"
MFD.WeedPerBag = 5
MFD.JointsPerBag = 10
MFD.BagsPerPapers = 1

MFD.PlantTemplate = {
   ["Gender"] = "Female",
  ["Quality"] = 0.0,
   ["Growth"] = 0.0,
    ["Water"] = 20.0,
     ["Food"] = 20.0,
    ["Stage"] = 1,
}

MFD.ItemTemplate = {
     ["Type"] = "Water",
  ["Quality"] = 0.0,
}

MFD.Objects = {
  [1] = "bkr_prop_weed_01_small_01c",
  [2] = "bkr_prop_weed_01_small_01b",
  [3] = "bkr_prop_weed_01_small_01a",
  [4] = "bkr_prop_weed_med_01a",
  [5] = "bkr_prop_weed_med_01b",
  [6] = "bkr_prop_weed_lrg_01a",
  [7] = "bkr_prop_weed_lrg_01b",
}