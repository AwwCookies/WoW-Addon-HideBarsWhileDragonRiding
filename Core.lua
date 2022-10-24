local f = CreateFrame("Frame")

-- all action bars in game minus main bar
local bars = {
   MultiBarBottomLeft, -- action bar 2
   MultiBarBottomRight, -- action bar 3
   MultiBarLeft, -- action bar 4
   MultiBarRight, -- action bar 5
   MultiBar5, -- action bar 6
   MultiBar6, -- action bar 7
   MultiBar7 -- action bar 9
}

-- Dragon Riding Auras
local dragonRidingAuras = {
   "Cliffside Wylderdrake",
   "Renewed Proto-Drake",
   "Windborne Velocidrake",
   "Highland Drake",
   "Soar" -- Dracthyr Racial
}

-- stores bars player had shown
local hiddenBars = {}

local function isDragonRiding()
   -- if player isn't mounted then they can't be
   -- Dragon Riding so we can return early
   if (not IsMounted()) then
      return false
   end
   local _isDragonRiding = false
   -- loop through all player auras and check them against the known Dragon Riding Mounts
   AuraUtil.ForEachAura("player", "HELPFUL", nil, function(name, ...)
      if (tContains(dragonRidingAuras, name)) then
         _isDragonRiding = true
      end
   end)

   return _isDragonRiding
end

-- hide players action bars and store which ones
-- they have open
local function hideBars()
   for _, bar in pairs(bars) do
      if (bar:IsShown()) then
         bar:Hide()
         table.insert(hiddenBars, bar)
      end
   end
end

-- restore players bars
local function restoreBars()
   for _, bar in pairs(hiddenBars) do
      bar:Show()
   end
end

f:SetScript("OnEvent", function()
   -- check if DragonRiding or using Soar
      if (isDragonRiding()) then
         hideBars() -- if Dragon Riding then hide bars
      else
         restoreBars() -- if not show/restore bars
      end
end)

f:RegisterEvent("UNIT_AURA")
f:RegisterEvent("PLAYER_LOGIN")