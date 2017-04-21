# garages v2.1

Hi everyone

Here we are, this is garares mod.

_What can you do ?_

* Store and recover your vehicle in/from the garage, at now just one vehicle per player.
* Get your vehicle from the garage, only if you owned one, if you do not have one, just buy it (obviously).
* Customized vehicles are not saved in garage, just the original vehicle.
* If your vehicle was bougth before this mod, i am sorry you have to buy a new one or edit the database.

_All text are in french cause omelette du fromage, vin rouge and baguette._

Teamspeak : gaymadz.fr (if i am here, poke me, if not.....poke you, and no i am not gay, i did not choose the name)


**Special thanks**
ExfreeZzi and theilegendz for testing on the beautiful day of 17/04/2017

Issues
_Two or more player can store vehicle at same time or immediatly_
You have to wailt 5+ second before store or get your vehicle and other player must stay out the whole parking, obviously stay on pavement.




**Installation**

**WARNING, this is only if you use vehshop in es_freeroam, if not if you use the standalone version i will not bring help if something shitty happen**

1. Download
2. Extract the folder and rename it to garages
3. Add sql.sql to your database.
<img src="http://plysken.com/gta5/001.PNG" width="690" height="163">
4. Place the folder in your resources/[folder]
5. Replace vehshop.lua and vehshop_s.lua with the new ones.
6. Add - garages to your AutoStartResources in citmp-server.yml
7. Do not forget the order : **essentialmode** then **es_freeroam** then **gagares** in citmp-server.yml
8. Open server.lua and change your database settings.
9. Clear your cache <-- **DO NOT FORGET IT** else your shop will be empty
10. Restart your server


_Update of 17/04/17_ sql.sql, server, client and vehsop_s lua file are to be replaced, oubviously, clear the server cache
* Added function when player spawn on server, it set vehicle available in the garage.
* Changed in vehsop.lua that when before the player selected an action, he was teleported into the marker, now not.


_Update of 17/04/17_ <- for this one, just replace the "client.lua" 
* Changed the location cause the old one got issues.
* Added a colour to the blip.
*Changed my vehsop_s cause new player car's did not set on database. <-- for this, just replace the vehshop_s.lua



_Update of 16/04/17_
* Changed veshop.lua and veshop_s.lua because the mod does not include the function of saving the license plate in the database.
* The purchased vehicle is no longer stored in the "personalvehicle" table but in a specific one.
* Added (obviously copyed/pasted and little changed) afunction to update or add vehicle if player had one or not (function from vehshop).
* Added new table in the database.
* Added function that check if the player'vehicule is out or in the garage and therefor do the stuff to spawn or not.
* Added function that checks if the vehicle the player wants to store is the owner, if not nothing happen.
* Added function that checks is the spawn-vehicle-area is clear or not.



I will not help anyone who does not have a minimum of knowledge in lua or who do not try to search a little in the mod code, like:
How do we change place markers?
Where is the garage?
... and other issues of this kind.
If you ask yourself these questions, start by learning the lua

http://gta.wikia.com/wiki/Vehicles_in_GTA_V


This mod was inspired by es_vehsjop witch is a part of 
https://github.com/FiveM-Scripts/es_freeroam
