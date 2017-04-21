-- Configure the barbers Locations
local barberblips = {
    {id=71, x=-827.333, y=-190.916, z=37.599},
    {id=71, x=130.512, y=-1715.535, z=29.226},
    {id=71, x=-1291.472, y=-1117.230, z=6.641},

    {id=71, x=1936.451, y=3720.533, z=32.638},
    {id=71, x=1200.214, y=-468.822, z=66.268},
    {id=71, x=-30.109, y=-141.693, z=57.041},

    {id=71, x=-285.238, y=6236.365, z=31.455},
  }

  -- Configure the coordinates for the barbers.
  local peds = {
    -- Barber shop 1
    {type=4, hash=0x163b875b, x=822.461, y=-183.713, z=37.569},
    -- Barber shop 2
    {type=4, hash=0x163b875b, x=134.728, y=-1708.026, z=29.292, a=144.246},
    -- Barber shop 3
    {type=4, hash=0x163b875b, x=-1284.218, y=-1115.584, z=6.990, a=95.442},
    -- Barber shop 4
    {type=4, hash=0x163b875b, x=-1930.818, y=3728.178, z=32.844, a=220.428},
    -- Barber shop 5
    {type=4, hash=0x163b875b, x=-1211.422, y=-470.861, z=66.208, a=75.232},
    -- Barber shop 6
    {type=4, hash=0x163b875b, x=-30.804, y=-151.648, z=57.077, a=349.238},
    -- Barber shop 7
    {type=4, hash=0x163b875b, x=-278.138, y=6230.321, z=31.696, a=49.021},
  }

  Citizen.CreateThread(function()
    -- Load the ped modal (s_f_m_fembarber)
    RequestModel(0x163b875b)
    while not HasModelLoaded(0x163b875b) do
      Wait(1)
    end

    -- Create blips on the map for all the barbers
    for _, item in pairs(barberblips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
    end

    -- Spawn the peds in the barbers
    for _, item in pairs(peds) do
      ped = CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      SetPedCombatAttributes(ped, 17, true)
      SetPedFleeAttributes(ped, 0, 0)
    end
  end)
