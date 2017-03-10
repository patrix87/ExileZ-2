ExileZ 2 (v2.8)

by Patrix87

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

Zombies & Demons 4.6 by ryandombrowsky,
ExileServer 1.0.2

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


How to export Triggers positions:

0. Open arma with NO MODS other than the map you are using
1. Open Eden Editor and DO NOT load a mission file.
2. Place an Elliptic Marker *(not a trigger) on every region you want a spawner and set its radius.
3. Copy Paste the code from GetMarkerCmd.txt inside the debug console
4. Execute the code
5. Open Notepad, CTRL+V  *(Paste)
6. ???
7. Profit !

PS: This is an @ExileServer Add-on for dedicated server only, NOT a mission script. No other script are required on the mission side for it to work.

Configuration

The script is configured to run with Altis with all the features enabled by default. *it's a pretty hardcore config, you might want to adjust it. ;)

All the detailed information related to the configuration is in fn_init.sqf

Please read it.

BEfilters


 

Special Thanks

MusTanG for the infection plugin and a bunch a nice code.

JASONonSTEAM for providing feedback and the Chernarus town locations.

Hakimos and BetterDeadThanZed for the BEfilters.

Dizzturbed for making me think about harassing zombies.

And to all of you for your feedback, it is greatly appreciated.


 

Donations

via paypal at

patrix87@gmail.com

 

Thanks



IMPORTANT NOTE !

Do not create to many triggers, one per town is enough. 
Many trigger per town is pointless as zombies only spawn near players anyway.

Use the performance build to get better performances

--> https://forums.bistudio.com/topic/160288-arma-3-stable-server-154-performance-binary-feedback/ <--

 

Licensed under
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)