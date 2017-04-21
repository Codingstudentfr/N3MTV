# PoliceGarage
A simple script for FiveM that is gonna add a garage function for the police station

# Instructuion

Put the PoliceGarage in your ressource folder and then go in your citmp-server.yml and add to AutoStartResources
```
		- PoliceGarage
    
```

In order to change the car model you will need to go in cl_pogarage.lua and change the line 
```

		local vehicle = GetHashKey('police3')
    
```
To 
```

		local vehicle = GetHashKey('Car Model Here')
    
```

# Image

![alt tag](http://image.prntscr.com/image/9641f90306424c9a9ef27fdbce4727a7.png)
