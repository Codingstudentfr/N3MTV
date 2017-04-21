---------------------------------- VAR ----------------------------------

local changeYourJob = {
  {name="Pole Emploi", colour=15, id=351, x=-266.94, y=-960.744, z=31.2231},
}

local jobs = {
  {name="Mineur", id=4},
  {name="Chauffeur de taxi", id=5},
}

---------------------------------- FUNCTIONS ----------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

function IsNearJobs()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(changeYourJob) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 10) then
      return true
    end
  end
end

function menuJobs()
  MenuTitle = "Jobs"
  ClearMenu()
  for _, item in pairs(jobs) do
    local nameJob = item.name
    local idJob = item.id
    Menu.addButton(nameJob,"changeJob",idJob)
  end
end

function changeJob(id)
  TriggerServerEvent("jobssystem:jobs", id)
end

---------------------------------- CITIZEN ----------------------------------

Citizen.CreateThread(function()
    for _, item in pairs(changeYourJob) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (IsNearJobs() == true) then
      drawTxt('Appuyer sur ~g~H~s~ pour accéder au menu des métiers',0,1,0.5,0.8,0.6,255,255,255,255)
    if (IsControlJustPressed(1,Keys["H"]) and IsNearJobs() == true) then
      menuJobs()
      Menu.hidden = not Menu.hidden 
    end
  end
    Menu.renderGUI()
  end
end)
