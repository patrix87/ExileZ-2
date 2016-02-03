ExileZ 2 (v2.5)

by Patrix87 of http://multi-jeux.quebec

Forked from Original project named EXILE-Z created by SAM, Otto and CaptionJack of RelentlessServers.com based on Civilian Life by code34

Most of the code is new code.

Features :

Dynamically spawns Ryan Zombies.
infinite Set of spawner configurations
Harassing zombies aka Random encounters that will spawn near players wherever they are.
Hordes !
The number of zombies in a town is proportional to the number of player in that town *(adjustable ratio)
Very Light.
Server Side only !
Optional Booby Trapped Explosive Zombies
Constant flow of zombies in towns.
Fully configurable
Respect and money for killing zombies.
Supports Any maps !
Safezone protection.
Zombie Missions !
Possibility to display infested zones on map.
Adjustable zombies health and damage.
Zombies won't disappear if close to a player.
Zombies won't spawn right next to a player.
Jumping Zombies
Throwing Zombies
Feeding Zombies
Infection support out of the box !
Cure support only available when the client install : http://steamcommunity.com/sharedfiles/filedetails/?id=614815221 
	A modification to the mission file is also required by the server admin.
		Thread here : http://www.exilemod.com/topic/10999-rz-infection-for-exile/

Requirement

Zombies & Demons 3.6 by ryandombrowsky,

https://forums.bistudio.com/topic/182412-zombies-demons-36/

Download 

https://github.com/patrix87/ExileZ-2

Installation

Unpack exilez.pbo
Edit settings in init\fn_init.sqf
Repack exilez.pbo
Place exilez.pbo in @ExileServer\addons
Add "ryanzombies" & "ryanzombiesfunctions" to the "addons" section of your mission.sqm.
 

class Mission
{
	addOns[]=
	{
		"exile_client",
		"Ryanzombies",
		"ryanzombiesfunctions",
		"a3_map_altis",
		"A3_Characters_F"
	};
 

 

PS: This is an @ExileServer Add-on for dedicated server only, NOT a mission script. No other script are required on the mission side for it to work.

Configuration

The script is configured to run with Altis with all the features enabled by default. *it's a pretty hardcore config, you might want to adjust it. ;)

All the detailed information related to the configuration is in fn_init.sqf

Please read it.

BEfilters



 

Special Thanks

MusTanG for the infection plugin

JASONonSTEAM for providing feedback and the Chernarus town locations.

Hakimos and BetterDeadThanZed for the BEfilters.

Dizzturbed for making me think about harassing zombies.

And to all of you for your feedback, it is greatly appreciated.


 

Donations

http://multi-jeux.quebec/dons/

or paypal at

patrix87@gmail.com

 

Thanks



IMPORTANT NOTE !

@Ryanzombies in combination with Arma 3 1.54 increases the occurrence of the Out of memory error.
This is not an issue I can solve neither can Ryan.
This is something the ARMA 3 Dev team have to fix.
Please upvote this : http://feedback.arma3.com/view.php?id=26863

Apparently, using the performance build resolve the crashing issue!

--> https://forums.bistudio.com/topic/160288-arma-3-stable-server-154-performance-binary-feedback/ <--

 

Licensed under
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)