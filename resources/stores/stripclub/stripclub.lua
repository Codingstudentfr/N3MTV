-- Configure the coordinates where the strippers should be placed.
local strippers = {
  {type=5, hash=0x2970a494, x=112.159, y=-1287.326, z=28.459, a=265.902},
  {type=5, hash=0x2970a494, x=108.440, y=-1289.298, z=28.859, a=338.700},
  {type=5, hash=0x2970a494, x=108.181, y=-1304.807, z=28.769, a=186.893},
  {type=5, hash=0x2970a494, x=118.125, y=-1283.357, z=28.277, a=124.466},
  }

-- Configure the coordinates for the bartenders.
  local bartenders = {
    {type=5, hash=0x780c01bd, x=128.900, y=-1283.211, z=29.273, a=123.98},
  }

-- Configure the coordinates for the bartenders.
local bouncers = {
  {type=4, hash=0x9fd4292d, x=130.328, y=-1298.409, z=29.233, a=211.486},
  {type=4, hash=0x9fd4292d, x=127.404, y=-1300.126, z=29.23, a=211.587},
  {type=4, hash=0x9fd4292d, x=111.088, y=-1304.371, z=29.020, a=296.699},
}


function LocalPed()
  return GetPlayerPed(-1)
end

Citizen.CreateThread(function()
  -- Configure the coordinates for the stripclub icon on the map.
  local stripclub = AddBlipForCoord(133.759, -1307.559, 29.037)
  SetBlipSprite(stripclub, 121)
  SetBlipDisplay(stripclub, 3)
  SetBlipAsShortRange(stripclub, true)

  -- Load the ped modal (s_f_y_bartender_01)
  RequestModel(0x780c01bd)
  while not HasModelLoaded(0x780c01bd) do
    Wait(1)
  end

  -- Load the ped modal (mp_f_stripperlite)
  RequestModel(0x2970a494)
  while not HasModelLoaded(0x2970a494) do
    Wait(1)
  end

  -- Load the ped modal (s_m_m_bouncer_01)
  RequestModel(0x9fd4292d)
  while not HasModelLoaded(0x9fd4292d) do
    Wait(1)
  end

  -- Load the animation (testing)
  RequestAnimDict("mini@strip_club@idles@stripper")
  while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
    Wait(1)
  end

  -- Load the bouncer animation (testing)
  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end

    -- Spawn the bartender to the coordinates
    bartender =  CreatePed(5, 0x780c01bd, 128.900, -1283.21, 29.273, 123.98, true, true)
    SetBlockingOfNonTemporaryEvents(bartender, true)
    SetPedCombatAttributes(bartender, 46, true)
    SetPedFleeAttributes(bartender, 0, 0)
    SetPedRelationshipGroupHash(bartender, GetHashKey("CIVFEMALE"))


  -- Spawn the bouncers to the coordinates
  for _, item in pairs(bouncers) do
    ped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
    GiveWeaponToPed(ped, 0x1B06D571, 2800, false, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedArmour(ped, 100)
    SetPedMaxHealth(ped, 100)
    SetPedRelationshipGroupHash(ped, GetHashKey("army"))
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND_PATROL", 0, true)
    SetPedCanRagdoll(ped, false)
    SetPedDiesWhenInjured(ped, false)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end

  -- Spawn the strippers to the coordinates
  for _, item in pairs(strippers) do
    stripper =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
    GiveWeaponToPed(stripper, 0x99B507EA, 2800, false, true)
    SetPedCombatAttributes(stripper, 46, true)
    SetPedFleeAttributes(stripper, 0, 0)
    SetPedArmour(stripper, 200)
    SetPedMaxHealth(stripper, 200)
    SetPedDiesWhenInjured(ped, false)
    SetPedRelationshipGroupHash(stripper, GetHashKey("army"))
    TaskPlayAnim(stripper,"mini@strip_club@idles@stripper","stripper_idle_03", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end

end)
