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

Utils = {}

function Utils:DrawTextTemplate(text,x,y,font,scale1,scale2,colour1,colour2,colour3,colour4,wrap1,wrap2,centre,outline,dropshadow1,dropshadow2,dropshadow3,dropshadow4,dropshadow5,edge1,edge2,edge3,edge4,edge5)
    return {
      text         =                    "",
      x            =                   0.5,
      y            =                   0.5,
      font         =  font         or    4,
      scale1       =  scale1       or  1.0,
      scale2       =  scale2       or  1.0,
      colour1      =  colour1      or  100,
      colour2      =  colour2      or  100,
      colour3      =  colour3      or  100,
      colour4      =  colour4      or  250,
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

function Utils:GetVecDist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

function Utils:GetKeyPressed(key)
  if not key then return false; end
  if (IsDisabledControlJustPressed(0, Keys[key]) or IsControlJustPressed(0, Keys[key])) then return true
  else return false; end
end

function Utils:InRange(val, target, range)
  if target + range > val and target - range < val then return true;
  else return false; end
end
