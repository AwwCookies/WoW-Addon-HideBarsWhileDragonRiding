local f = CreateFrame("Frame")

-- all action bars in game minus main bar
local bars = {
   MultiBarBottomLeft,
   MultiBarBottomRight,
   MultiBarLeft,
   MultiBarRight,
   MultiBar5,
   MultiBar6,
   MultiBar7
}

-- Dragon Riding Auras
local dragonRidingAuras = {
   "Cliffside Wylderdrake",
   "Renewed Proto-Drake",
   "Windborne Velocidrake",
   "Highland Drake",
   "Soar"
}

-- stores bars player had shown
local hiddenBars = {}

local function isDragonRiding()
   local isDragonRiding = false
   -- meta function to reference auraName to dragonRidingAuras table
   local function isDragonRidingMount(auraName)
      for k, v in pairs(dragonRidingAuras) do
         if (auraName == v) then
            return true
         end
      end
      return false
   end

   -- loop through all player auras and check them against the known Dragon Riding Mounts
   AuraUtil.ForEachAura("player", "HELPFUL", nil, function(name, ...)
      if (isDragonRidingMount(name)) then
         isDragonRiding = true
      end
   end)

   return isDragonRiding
end

local function hideBars()
   for _,bar in pairs(bars) do
      if (bar:IsShown()) then
         bar:Hide()
         table.insert(hiddenBars, bar)
      end
   end
end

local function showBars()
   for _,bar in pairs(hiddenBars) do
      bar:Show()
   end
end

f:SetScript("OnUpdate", function()
   -- check if DragonRiding or using Soar
   if (IsMounted() or IsFlying()) then
      if (isDragonRiding()) then
         hideBars() -- if Dragon Riding then hide bars
      else
         showBars() -- if not show/restore bars
      end
   end
end)