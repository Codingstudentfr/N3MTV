-- Configure Store Locations
local blips = {
    {id=73, x=88.291, y=-1391.929, z=29.200},
    {id=73, x=-718.985, y=-158.059, z=36.996},
    {id=73, x=-151.204, y=-306.837, z=38.724},
    {id=73, x=414.646, y=-807.452, z=29.338},
    {id=73, x=-815.193, y=-1083.333, z=11.022},
    {id=73, x=-1208.098, y=-782.020, z=17.163},
    {id=73, x=-1457.954, y=-229.426, z=49.185},
    {id=73, x=-2.777, y=6518.491, z=31.533},
    {id=73, x=1681.586, y=4820.133, z=42.046},
    {id=73, x=130.216, y=-202.940, z=54.505},
    {id=73, x=618.701, y=2740.564, z=41.905},
    {id=73, x=1199.169, y=2694.895, z=37.866},
    {id=73, x=-3164.172, y=1063.927, z=20.674},
    {id=73, x=-1091.373, y=2702.356, z=19.422},
  }

-- Configure the locations where the pedestrians should be placed
local peds = {
  {type=5, hash=0x3eecba5d, x=73.883, y=-1392.551, z=29.376, a=258.693},
  {type=5, hash=0x3eecba5d, x=-708.705, y=-152.150, z=37.415, a=118.490},
  {type=5, hash=0x3eecba5d, x=-164.849, y=-302.719, z=39.733, a=249.119},
  {type=5, hash=0xa96e2604, x=126.824 , y=-224.512 , z=54.558 , a=71.926},
  {type=5, hash=0xa96e2604, x=427.069 , y=-806.280 , z=29.491 , a=84.203},
  {type=5, hash=0xa96e2604, x=-822.872 , y=-1072.162 , z=11.328 , a=203.007},
  {type=5, hash=0xa96e2604, x=-1193.691 , y=-766.863 , z=17.316 , a=216.273},
  {type=5, hash=0x3eecba5d, x=-1448.901 , y=-238.138 , z=49.814 , a=48.307},
  {type=5, hash=0x3eecba5d, x=5.809 , y=6511.428, z=31.878 , a=40.329},
  {type=5, hash=0xa96e2604, x=1695.387, y=4823.019, z=42.063, a=96.539},
  {type=5, hash=0xa96e2604, x=613.015, y=2762.577, z=42.088, a=277.766},
  {type=5, hash=0xa96e2604, x=1196.435, y=2711.634, z=38.223, a=179.040},
  {type=5, hash=0xa96e2604, x=-3169.260, y=1043.606, z=20.863, a=57.917},
  {type=5, hash=0xa96e2604, x=-1102.184, y=2711.799, z=19.108, a=223.387},
  {type=5, hash=0xa96e2604, x=-0.381, y=6510.237, z=31.878, a=310.662},
  }

  Citizen.CreateThread(function()
    -- Load the ped modal (s_f_y_shop_mid)
    RequestModel(0x3eecba5d)
    while not HasModelLoaded(0x3eecba5d) do
      Wait(1)
    end

    -- Load the ped modal (s_f_y_shop_low)
    RequestModel(0xa96e2604)
    while not HasModelLoaded(0xa96e2604) do
      Wait(1)
    end
    
    -- Create blips on the map for all the stores
    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
    end

    -- Spawn the peds in the clothing shops
    for _, item in pairs(peds) do
      ped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, true, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      SetPedCombatAttributes(ped, 46, true)
      SetPedFleeAttributes(ped, 0, 0)
    end
  end)
