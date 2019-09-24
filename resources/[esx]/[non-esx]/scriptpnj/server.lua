local BlockedExplosions = {1, 2, 4, 5, 25, 32, 33, 35, 36, 37, 38}

AddEventHandler(
  "explosionEvent",
  function(sender, ev)
    for _, v in ipairs(BlockedExplosions) do
      if ev.explosionType == v then
        CancelEvent()
        -- ban the creator or so but be careful. always check owner id in some other ways to confirm he's cheating
        return
      end
    end
  end
)