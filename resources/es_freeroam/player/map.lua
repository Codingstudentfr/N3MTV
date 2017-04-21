local blips = {
   -- Airport and Airfield
   {name="Airport", id=90, x=-1032.690, y=-2728.141, z=13.757},
   {name="Airport", id=90, x=1743.6820, y=3286.2510, z=40.087},
   -- barbers
   {name="Barber", id=71, x=-827.333, y=-190.916, z=37.599},
   {name="Barber", id=71, x=130.512, y=-1715.535, z=29.226},
   {name="Barber", id=71, x=-1291.472, y=-1117.230, z=6.641},
   {name="Barber", id=71, x=1936.451, y=3720.533, z=32.638},
   {name="Barber", id=71, x=1200.214, y=-468.822, z=66.268},
   {name="Barber", id=71, x=-30.109, y=-141.693, z=57.041},
   {name="Barber", id=71, x=-285.238, y=6236.365, z=31.455},
    -- Basic
    {name="Comedy Club", id=102, x=377.088, y=-991.869, z=-97.604},
    {name="FIB", id=106, x=105.455, y=-745.483, z=44.754},
    {name="Lifeinvader", id=77, x=-1047.900, y=-233.000, z=39.000},
    {name="Cluckin Bell", id=357, x=-72.68752, y=6253.72656, z=31.08991},
    {name="Tequil-La La", id=93, x=-565.171, y=276.625, z=83.286},
    {name="O'Neil Ranch", id=438, x=2441.200, y=4968.500, z=51.700},
    {name="Play Boy Mansion", id=439, x=-1475.234, y=167.088, z=55.841},
    {name="Hippy Camp", id=140, x=2476.712, y=3789.645, z=41.226},
    {name="Chop shop", id=446, x=479.056, y=-1316.825, z=28.203},
    {name="Rebel Radio", id=136, x=736.153, y=2583.143, z=79.634},
    {name="Morgue", id=310, x=243.351, y=-1376.014, z=39.534},
    {name="Golf", id=109, x=-1336.715, y=59.051, z=55.246 },
    {name="Jewelry Store", id=52,  x=-630.400, y=-236.700, z=40.00},
    -- Propperty
    {name="Casino", id=207, x=925.329, y=46.152, z=80.908 },
    {name="Maze Bank Arena", id=135, x=-250.604, y=-2030.000, z=30.000},
    {name="Stripbar", id=121, x=134.476, y=-1307.887, z=28.983},
    {name="Smoke on the Water", id=140, x=-1171.42, y=-1572.72, z=3.6636},
    {name="Weed Farm", id=140, x=2208.777, y=5578.235, z=53.735},
    {name="Downtown Cab Co", id=375, x=900.461, y=-181.466, z=73.89},
    {name="Theater", id=135, x=293.089, y=180.466, z=104.301},
    -- Police Stations
    {name="Police Station", id=60, x=425.130, y=-979.558, z=30.711},
    {name="Police Station", id=60, x=1859.234, y= 3678.742, z=33.690},
    {name="Police Station", id=60, x=-438.862, y=6020.768, z=31.490},
    {name="Police Station", id=60, x=818.221, y=-1289.883, z=26.300},
    {name="Prison", id=285, x=1679.049, y=2513.711, z=45.565},
    -- Hospitals
    {name="Hospital", id=61, x= 1839.6, y= 3672.93, z= 34.28},
    {name="Hospital", id=61, x= -247.76, y= 6331.23, z=32.43},
    {name="Hospital", id=61, x= -449.67, y= -340.83, z= 34.50},
    {name="Hospital", id=61, x= 357.43, y= -593.36, z= 28.79},
    {name="Hospital", id=61, x= 295.83, y= -1446.94, z= 29.97},
    {name="Hospital", id=61, x= -676.98, y= 310.68, z= 83.08},
    {name="Hospital", id=61, x= 1151.21, y= -1529.62, z= 35.37},
    {name="Hospital", id=61, x= -874.64, y= -307.71, z= 39.58},
    -- Yacht
    {name="Yacht", id=410, x=-2045.800, y=-1031.200, z=11.900},
    {name="Cargoship", id=410, x=-90.000, y=-2365.800, z=14.300},
  }

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end

  --load unloaded ipl's
  LoadMpDlcMaps()
  EnableMpDlcMaps(true)
  RequestIpl("chop_props")
  RequestIpl("FIBlobby")
  RemoveIpl("FIBlobbyfake")
  RequestIpl("FBI_colPLUG")
  RequestIpl("FBI_repair")
  RequestIpl("v_tunnel_hole")
  RequestIpl("TrevorsMP")
  RequestIpl("TrevorsTrailer")
  RequestIpl("TrevorsTrailerTidy")
  RemoveIpl("farm_burnt")
  RemoveIpl("farm_burnt_lod")
  RemoveIpl("farm_burnt_props")
  RemoveIpl("farmint_cap")
  RemoveIpl("farmint_cap_lod")
  RequestIpl("farm")
  RequestIpl("farmint")
  RequestIpl("farm_lod")
  RequestIpl("farm_props")
  RequestIpl("facelobby")
  RemoveIpl("CS1_02_cf_offmission")
  RequestIpl("CS1_02_cf_onmission1")
  RequestIpl("CS1_02_cf_onmission2")
  RequestIpl("CS1_02_cf_onmission3")
  RequestIpl("CS1_02_cf_onmission4")
  RequestIpl("v_rockclub")
  RemoveIpl("hei_bi_hw1_13_door")
  RequestIpl("bkr_bi_hw1_13_int")
  RequestIpl("ufo")
  RemoveIpl("v_carshowroom")
  RemoveIpl("shutter_open")
  RemoveIpl("shutter_closed")
  RemoveIpl("shr_int")
  RemoveIpl("csr_inMission")
  RequestIpl("v_carshowroom")
  RequestIpl("shr_int")
  RequestIpl("shutter_closed")
  RequestIpl("smboat")
  RequestIpl("cargoship")
  RequestIpl("railing_start")
  RemoveIpl("sp1_10_fake_interior")
  RemoveIpl("sp1_10_fake_interior_lod")
  RequestIpl("sp1_10_real_interior")
  RequestIpl("sp1_10_real_interior_lod")
  RemoveIpl("id2_14_during_door")
  RemoveIpl("id2_14_during1")
  RemoveIpl("id2_14_during2")
  RemoveIpl("id2_14_on_fire")
  RemoveIpl("id2_14_post_no_int")
  RemoveIpl("id2_14_pre_no_int")
  RemoveIpl("id2_14_during_door")
  RequestIpl("id2_14_during1")
  RequestIpl("coronertrash")
  RequestIpl("Coroner_Int_on")
  RemoveIpl("Coroner_Int_off")
  RemoveIpl("bh1_16_refurb")
  RemoveIpl("jewel2fake")
  RemoveIpl("bh1_16_doors_shut")
  RequestIpl("refit_unload")
  RequestIpl("post_hiest_unload")
  RequestIpl("Carwash_with_spinners")
  RequestIpl("ferris_finale_Anim")
  RemoveIpl("ch1_02_closed")
  RequestIpl("ch1_02_open")
  RequestIpl("AP1_04_TriAf01")
  RequestIpl("CS2_06_TriAf02")
  RequestIpl("CS4_04_TriAf03")
  RemoveIpl("scafstartimap")
  RequestIpl("scafendimap")
  RemoveIpl("DT1_05_HC_REMOVE")
  RequestIpl("DT1_05_HC_REQ")
  RequestIpl("DT1_05_REQUEST")
  RequestIpl("FINBANK")
  RemoveIpl("DT1_03_Shutter")
  RemoveIpl("DT1_03_Gr_Closed")
  RequestIpl("ex_sm_13_office_01a")
  RequestIpl("ex_sm_13_office_01b")
  RequestIpl("ex_sm_13_office_02a")
  RequestIpl("ex_sm_13_office_02b")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local players = {}

    for i = 0, 31 do
      if NetworkIsPlayerActive(i) then
        table.insert(players, i)
      end
    end

    for k, v in pairs(players) do
      if not GetBlipFromEntity(GetPlayerPed(v)) then
        if GetPlayerPed(v) == GetPlayerPed(-1) then return end
        local blip = AddBlipForEntity(GetPlayerPed(v))
        SetBlipColour(blip, 1)
      end
    end
  end
end)
