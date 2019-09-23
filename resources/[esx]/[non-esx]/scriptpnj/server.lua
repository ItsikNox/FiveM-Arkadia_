local BlockedExplosions = {1, 2, 4, 5, 25, 32, 33, 35, 36, 37, 38}

AddEventHandler("explosionEvent", function(sender, ev)
    for _, v in ipairs(BlockedExplosions) do
      if ev.explosionType == v then
        print(GetPlayerName(sender), json.encode(ev))
        CancelEvent()
        --DropPlayer(source, 'Lua Execution/ModMenu')
        return
      end
    end
  end)