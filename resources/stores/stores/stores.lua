-- Configure Store Locations
local blips = {
    {id=52, x=28.463, y=-1353.033, z=29.340},
    {id=52, x=-54.937, y=-1759.108, z=29.005},
    {id=52, x=375.858, y=320.097, z=103.433},
    {id=52, x=1143.813, y=-980.601, z=46.205},
    {id=52, x=1695.284, y=4932.052, z=42.078},
    {id=52, x=2686.051, y=3281.089, z=55.241},
    {id=52, x=1967.648, y=3735.871, z=32.221},
    {id=52, x=-2977.137, y=390.652, z=15.024},
    {id=52, x=1160.269, y=-333.137, z=68.783},
    {id=52, x=-1492.784, y=-386.306, z=39.798},
    {id=52, x=-1229.355, y=-899.230, z=12.263},
    {id=52, x=-712.091, y=-923.820, z=19.014},
  }

local peds = {
  {type=4, hash=0x18ce57d0, x=-46.313, y=-1757.504, z=29.421, a=46.395},
  {type=4, hash=0x18ce57d0, x=24.376, y=-1345.558, z=29.421, a=267.940},
  {type=4, hash=0x18ce57d0, x=1134.182, y=-982.477, z=46.416, a=275.432},
  {type=4, hash=0x18ce57d0, x=373.015, y=328.332, z=103.566, a=257.309},
  {type=4, hash=0x18ce57d0, x=2676.389, y=3280.362, z=55.241, a=332.305},
  {type=4, hash=0x18ce57d0, x=1958.960, y=3741.979, z=32.344, a=303.196},
  {type=4, hash=0x18ce57d0, x=-2966.391, y=391.324, z=15.043, a=88.867},
  {type=4, hash=0x18ce57d0, x=-1698.542, y=4922.583, z=42.064, a=324.021},
  {type=4, hash=0x18ce57d0, x=1164.565, y=-322.121, z=69.205, a=100.492},
  {type=4, hash=0x18ce57d0, x=-1486.530, y=-377.768, z=40.163, a=147.669},
  {type=4, hash=0x18ce57d0, x=-1221.568, y=-908.121, z=12.326, a=31.739},
  {type=4, hash=0x18ce57d0, x=-706.153, y=-913.464, z=19.216, a=82.056},
}

function DrawSpecialText(m_text, showtime)
 ClearPrints()
 SetTextEntry_2("STRING")
 AddTextComponentString(m_text)
 DrawSubtitleTimed(showtime, 1)
end

function ShowInfo(text, state)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

Citizen.CreateThread(function()
  -- Load the ped modal (mp_m_shopkeep_01)
  RequestModel(0x18ce57d0)
  while not HasModelLoaded(0x18ce57d0) do
    Wait(1)
  end

  -- Create blips on the map for all the stores
  for _, item in pairs(blips) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipAsShortRange(item.blip, true)
  end

  -- Spawn the peds in the shops
  for _, item in pairs(peds) do
    ped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    Citizen.CreateThread(function()
      while true do
      Citizen.Wait(0)
      local playerPed = GetPlayerPed(-1)
      local playerCoords = GetEntityCoords(playerPed, true)
      local doordist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, item.x, item.y, item.z, true)

      if doordist < 2 then
         ShowInfo("Appuyez sur ~INPUT_CONTEXT~ pour acheter.", 0)
      end
    end
   end)

  end
end)
