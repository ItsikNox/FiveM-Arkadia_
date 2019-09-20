---GetResolution
---@return table
function GetResolution()
    local W, H = GetActiveScreenResolution()
    if (W / H) > 3.5 then
        W, H = GetScreenResolution()
    end
    if W < 1920 then W = 1920 end
    if H < 1080 then H = 1080 end
    return W, H
end

---FormatXWYH
---@param Value number
---@param Value2 number
---@return table
--function FormatXWYH(Value, Value2)
--    return Value / 1920, Value2 / 1080
--end
function FormatXWYH(Value, Value2)
    local W, H = GetScreenResolution()
    local AW, AH = GetResolution()
    local XW = Value/W - ((Value / W) - (Value / AW))
    local YH = Value2/H - ((Value2 / H) - (Value2 / AH))
    return XW, YH
end

-- Converts normalized position to pixel position
function ConvertToPixel(x, y)
    local AW, AH = GetResolution()
    return math.round(x * AW), math.round(y * AH)
end

---round
---@param num number
---@param numDecimalPlaces number
---@return number
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---tobool
---@param input boolean
---@return boolean
function tobool(input)
    if input == "true" or tonumber(input) == 1 or input == true then
        return true
    else
        return false
    end
end

---split
---@param inputstr string
---@param sep string
---@return string
function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

---starts
---@param String string
---@param Start string
---@return string
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
function IsMouseInBounds(X, Y, Width, Height, DrawOffset)
    local W, H = GetResolution()
    local MX, MY = math.round(GetControlNormal(0, 239) * W), math.round(GetControlNormal(0, 240) * H)
    MX, MY = FormatXWYH(MX, MY)
    X, Y = FormatXWYH(X, Y)
    if DrawOffset then
        X = X + DrawOffset.X
        Y = Y + DrawOffset.Y
    end
    Width, Height = FormatXWYH(Width, Height)
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---TableDump
---@param o table
---@return string
function TableDump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. TableDump(v) .. ','
        end
        return s .. '} '
    else
        return print(tostring(o))
    end
end

---Controller
---@return nil
function Controller()
    return not IsInputDisabled(2)
end

---RenderText
---@param Text string
---@param X number
---@param Y number
---@param Font number
---@param Scale number
---@param R number
---@param G number
---@param B number
---@param A number
---@param Alignment number
---@param DropShadow number
---@param Outline number
---@param WordWrap number
---@return nil
function RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
    Text = tostring(Text)
    X, Y = FormatXWYH(X, Y)
    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(R or 255, G or 255, B or 255, A or 255)

    if DropShadow then
        SetTextDropShadow()
    end
    if Outline then
        SetTextOutline()
    end

    if Alignment ~= nil then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextRightJustify(true)
            SetTextWrap(0, X)
        end
    end

    if tonumber(WordWrap) then
        if tonumber(WordWrap) ~= 0 then
            WordWrap, _ = FormatXWYH(WordWrap, 0)
            SetTextWrap(WordWrap, X - WordWrap)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddLongString(Text)
    EndTextCommandDisplayText(X, Y)
end

---DrawRectangle
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
function DrawRectangle(X, Y, Width, Height, R, G, B, A)
    X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0
    X, Y = FormatXWYH(X, Y)
    Width, Height = FormatXWYH(Width, Height)
    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

---DrawTexture
---@param TxtDictionary string
---@param TxtName string
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
function DrawTexture(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
    if not HasStreamedTextureDictLoaded(tostring(TxtDictionary) or "") then
        RequestStreamedTextureDict(tostring(TxtDictionary) or "", true)
    end
    X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0
    X, Y = FormatXWYH(X, Y)
    Width, Height = FormatXWYH(Width, Height)
    DrawSprite(tostring(TxtDictionary) or "", tostring(TxtName) or "", X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(Heading) or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function print_table(node)
    -- to make output beautiful
    local function tab(amt)
        local str = ""
        for i = 1, amt do
            str = str .. "\t"
        end
        return str
    end

    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. tab(depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. tab(depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. tab(depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. tab(depth - 1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)

    print(output_str)
end