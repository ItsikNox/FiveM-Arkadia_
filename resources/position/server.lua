POSITIONS = {}

POSITIONS.list = {}

RegisterServerEvent("position:s:insert")
AddEventHandler("position:s:insert", function (text)
    print(text)
    
    local source = source

    local f,err = io.open('positions.txt','w')
    if not f then return print(err) end

    table.insert(POSITIONS.list, text)

    for i,line in pairs(POSITIONS.list) do
      f:write(line..' \n')
    end

	f:close()
end)