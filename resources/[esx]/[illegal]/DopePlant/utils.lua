Keys = {
  ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
  ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
  ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
  ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
  ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
  ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
  ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
  ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

Weapons = {
  Melee = { 
    'WEAPON_KNIFE', 'WEAPON_KNUCKLE', 'WEAPON_NIGHTSTICK', 'WEAPON_HAMMER', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_CROWBAR', 'WEAPON_BOTTLE', 'WEAPON_DAGGER',
    'WEAPON_HATCHET', 'WEAPON_MACHETE', 'WEAPON_SWITCHBLADE', 'WEAPON_POOLCUE',
  },
  Pistol = {
    'WEAPON_REVOLVER', 'WEAPON_PISTOL', 'WEAPON_PISTOL_MK2', 'WEAPON_COMBATPISTOL', 'WEAPON_APPISTOL', 'WEAPON_PISTOL50', 'WEAPON_SNSPISTOL', 
    'WEAPON_HEAVYPISTOL','WEAPON_VINTAGEPISTOL', 'WEAPON_DOUBLEACTION', 'WEAPON_REVOLVER_MK2', 'WEAPON_SNSPISTOL_MK2',
  },
  SMG = {
    'WEAPON_MICROSMG','WEAPON_MINISMG','WEAPON_SMG','WEAPON_SMG_MK2','WEAPON_ASSAULTSMG', 'WEAPON_MACHINEPISTOL',
  },
  MG = {
    'WEAPON_MG','WEAPON_COMBATMG','WEAPON_COMBATMG_MK2',
  },
  Assault = {
    'WEAPON_ASSAULTRIFLE', 'WEAPON_ASSAULTRIFLE_MK2', 'WEAPON_CARBINERIFLE', 'WEAPON_CARBINERIFLE_MK2', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_SPECIALCARBINE', 
    'WEAPON_BULLPUPRIFLE', 'WEAPON_COMPACTRIFLE', 'WEAPON_SPECIALCARBINE_MK2', 'WEAPON_BULLPUPRIFLE_MK2',
  },
  Shotgun = {
     'WEAPON_PUMPSHOTGUN','WEAPON_SAWNOFFSHOTGUN','WEAPON_BULLPUPSHOTGUN','WEAPON_ASSAULTSHOTGUN','WEAPON_HEAVYSHOTGUN','WEAPON_DBSHOTGUN',
     'WEAPON_PUMPSHOTGUN_MK2',
  },
}

Utils = {}

function Utils:DrawTextTemplate(text,x,y,font,scale1,scale2,colour1,colour2,colour3,colour4,wrap1,wrap2,centre,outline,dropshadow1,dropshadow2,dropshadow3,dropshadow4,dropshadow5,edge1,edge2,edge3,edge4,edge5)
    return {
      text         =                    "",
      x            =                    -1,
      y            =                    -1,
      font         =  font         or    6,
      scale1       =  scale1       or  0.5,
      scale2       =  scale2       or  0.5,
      colour1      =  colour1      or  255,
      colour2      =  colour2      or  255,
      colour3      =  colour3      or  255,
      colour4      =  colour4      or  255,
      wrap1        =  wrap1        or  0.0,
      wrap2        =  wrap2        or  1.0,
      centre       =  ( type(centre) ~= "boolean" and true or centre ),
      outline      =  outline      or    1,
      dropshadow1  =  dropshadow1  or    2,
      dropshadow2  =  dropshadow2  or    0,
      dropshadow3  =  dropshadow3  or    0,
      dropshadow4  =  dropshadow4  or    0,
      dropshadow5  =  dropshadow5  or    0,
      edge1        =  edge1        or  255,
      edge2        =  edge2        or  255,
      edge3        =  edge3        or  255,
      edge4        =  edge4        or  255,
      edge5        =  edge5        or  255,
    }
end

function Utils:DrawText( t )
  if   not t or not t.text  or  t.text == ""  or  t.x == -1   or  t.y == -1
  then return false
  end

  -- Setup Text
  SetTextFont (t.font)
  SetTextScale (t.scale1, t.scale2)
  SetTextColour (t.colour1,t.colour2,t.colour3,t.colour4)
  SetTextWrap (t.wrap1,t.wrap2)
  SetTextCentre (t.centre)
  SetTextOutline (t.outline)
  SetTextDropshadow (t.dropshadow1,t.dropshadow2,t.dropshadow3,t.dropshadow4,t.dropshadow5)
  SetTextEdge (t.edge1,t.edge2,t.edge3,t.edge4,t.edge5)
  SetTextEntry ("STRING")

  -- Draw Text
  AddTextComponentSubstringPlayerName (t.text)
  DrawText (t.x,t.y)

  return true
end

function Utils.PointOnSphere(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  if      vector3
  then
      return
      vector3(
           orgX + radius * math.sin( azu ) * math.cos( alt ),
           orgY + radius * math.cos( azu ) * math.cos( alt ),
           orgZ + radius * math.sin( alt )
      )
  end
end

function Utils.ClampCircle(x,y,radius)
  x      = ( tonumber(x or 0)      or 0 )
  y      = ( tonumber(y or 0)      or 0 )
  radius = ( tonumber(radius or 0) or 0 )
  local d = math.sqrt(x*x+y*y)
  d = radius / d
  if d < 1 then x = x * (d/radius)*radius; y = y * (d/radius)*radius; end
  return x,y
end

function Utils.GetHashKey(strToHash)
  if type(strToHash) == "number" then return strToHash; end;
  return GetHashKeyPrev(tostring(strToHash or "") or "")%0x100000000;
end
GetHashKeyPrev = GetHashKeyPrev or GetHashKey
GetHashKey     = Utils.GetHashKey

function Utils:FindNearestZone(position, table)
  if type(table) ~= 'table' or type(position) ~= 'vector3' then return 999999; end  
  local closestZone,closestAction,closestDist,closestCoords
  for _,zone in pairs(table) do
    if zone.Positions then 
      for act,pos in pairs(zone.Positions) do
        if type(pos) == 'vector3' then
          local curDist = Utils:GetVecDist(position, pos)
          if not closestDist or curDist < closestDist then
            closestZone,closestAction,closestDist,closestCoords = zone,act,curDist,pos
          end
        end
      end
    end
  end
  return closestZone,closestAction,closestDist,closestCoords
end

function string.tohex(s,chunkSize)
  s = ( type(s) == "string" and s or type(s) == "nil" and "" or tostring(s) )
  chunkSize = chunkSize or 2048
  local rt = {}
  string.tohex_sformat   = ( string.tohex_sformat   and string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_sformat ) or string.rep("%02X",math.min(#s,chunkSize))
  string.tohex_chunkSize = ( string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_chunkSize or chunkSize )
  for i = 1,#s,chunkSize do
    rt[#rt+1] = string.format(string.tohex_sformat:sub(1,(math.min(#s-i+1,chunkSize)*4)),s:byte(i,i+chunkSize-1))
  end
  if      #rt == 1 then return rt[1]
  else    return table.concat(rt,"")
  end
end

function Utils.GetXYDist(x1,y1,z1,x2,y2,z2)
  return math.sqrt(  ( (x1 or 0) - (x2 or 0) )*(  (x1 or 0) - (x2 or 0) )+( (y1 or 0) - (y2 or 0) )*( (y1 or 0) - (y2 or 0) )+( (z1 or 0) - (z2 or 0) )*( (z1 or 0) - (z2 or 0) )  )
end

function Utils:GetV2Dist(v1, v2)
  if not v1 or not v2 or not v1.x or not v2.x or not v1.y or not v2.y then return 0; end
  return math.sqrt( ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) ) )
end

function Utils:GetVecDist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

function Utils.GetCoordsInFrontOfCam(...)
    local function Distance(v1,v2) if not v1 or not v1.x then return 0; end; v2 = v2 or vector3(0,0,0); return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  );end;
    local coords      = GetGameplayCamCoord()
    local rot         = GetGameplayCamRot(2)
    local direction   = vector3(( math.sin(rot.z*(3.141593/180))*-1)*math.abs(math.cos(rot.x)), math.cos(rot.z*(3.141593/180))*math.abs(math.cos(rot.x)), math.sin(rot.x*(3.141593/180)))
    local distanceMod = Distance((coords-GetEntityCoords(PlayerPedId(),false) or vector3(0,0,0)))
    local retTable    = {}
    if   ( select("#",...) == 0 ) then return vector3( coords.x + ( 1*direction.x ), coords.y + ( 1*direction.y ), coords.z + ( 1*direction.z ) ) ; end
    for k = 1,select("#",...) do
        local distance = ( select(k,...) ) + distanceMod
        if ( type(distance) == "number" )
        then
            if    ( distance == 0 )
            then  retTable[k] = coords
            else  retTable[k] = vector3(coords.x+(distance*direction.x),coords.y+(distance*direction.y),coords.z+(distance*direction.z))
            end
        end
    end
    return unpack(retTable)
end

function Utils.RotationToDirection(rot)
  return vector3(( math.sin(rot.z*(3.141593/180))*-1)*math.abs(math.cos(rot.x)), math.cos(rot.z*(3.141593/180))*math.abs(math.cos(rot.x)), math.sin(rot.x*(3.141593/180)))
end

function Utils.LoadModel(model, wait)
  local hk = Utils.GetHashKey(model)
  if wait then
    while not HasModelLoaded(hk) do 
      Citizen.Wait(0)
      RequestModel(hk)
    end
  else
    RequestModel(hk)
  end
  return true
end

function Utils.ReleaseModel(model)
  local hk = Utils.GetHashKey(model)
  if HasModelLoaded(hk) then 
    SetModelAsNoLongerNeeded(hk)
  end
  return true
end

function Utils:LoadModelTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = Utils.GetHashKey(v)
      while not HasModelLoaded(hk) do
        RequestModel(hk)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function Utils:ReleaseModelTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = Utils.GetHashKey(v)
      if HasModelLoaded(hk) then
        SetModelAsNoLongerNeeded(hk)
      end
    end
  end
  return true
end

function Utils.LoadWeaponTable(table)  
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = Utils.GetHashKey(v)
      while not HasWeaponAssetLoaded(hk) do
        RequestWeaponAsset(hk)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function Utils.ReleaseWeaponTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = Utils.GetHashKey(v)
      if HasWeaponAssetLoaded(hk) then
        RemoveWeaponAsset(hk)
      end
    end
  end
  return true
end

function Utils.LoadAnimTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      while not HasAnimDictLoaded(v) do
        RequestAnimDict(v)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function Utils.ReleaseAnimTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      if HasAnimDictLoaded(v) then
        RemoveAnimDict(v)
      end
    end
  end
  return true
end

function Utils:LoadAnimDict(dict)
  if type(dict) ~= 'string' then return false; end
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Citizen.Wait(0)
  end
  return true
end

function Utils:ReleaseAnimDict(dict)
  if type(dict) ~= 'string' then return false; end
  if HasAnimDictLoaded(dict) then
    RemoveAnimDict(dict)
  end
  return true
end

function Utils.NetworkControlEntity(ent)
  if type(ent) ~= 'number' then return false; end
  while not NetworkHasControlOfEntity(ent) do
    NetworkRequestControlOfEntity(ent)
    Citizen.Wait(0)
  end
  return true
end

function Utils.NetworkControlDoor(obj)
  if type(obj) ~= 'number' then return false; end
  while not NetworkHasControlOfDoor(obj) do
    NetworkRequestControlOfDoor(obj)
    Citizen.Wait(0)
  end
  return true
end

function Utils.InRange(val, target, range)
  if target + range > val and target - range < val then return true;
  else return false; end
end

math.pow = math.pow or function(n,p) return (n or 1)^(p or 1) ; end
function Utils:Round(val, scale)
    val,scale = val or 0, scale or 0
    return (
      val < 0 and  math.floor((math.abs(val*math.pow(10,scale))+0.5))*math.pow(10,((scale)*-1))*(-1)
               or  math.floor((math.abs(val*math.pow(10,scale))+0.5))*math.pow(10,((scale)*-1))
    )
end

function Utils:GetKeyPressed(key)
  if not key then return false; end
  if (IsDisabledControlJustPressed(0, Keys[key]) or IsControlJustPressed(0, Keys[key])) then return true
  else return false; end
end

function Utils:GetKeyHeld(key)
  if not key then return false; end
  if (IsDisabledControlPressed(0, Keys[key]) or IsControlPressed(0, Keys[key])) then return true
  else return false; end
end

function Utils:DrawText3D(x,y,z, text)
  local onScreen,_x,_y = World3dToScreen2d(x,y,z)
  local px,py,pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

  if onScreen then
    -- Formalize the text
    SetTextColour(220, 220, 220, 255)
    SetTextScale(0.0*scale, 0.40*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(true)

    -- Calculate width and height
    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local height = GetTextScaleHeight(0.45*scale, 4)
    local width = EndTextCommandGetWidth(4)

    -- Diplay the text
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)

    --DrawRect(_x, _y+scale/73, width, height, 35, 35, 35 , 200)
  end
end