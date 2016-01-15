ExileZ 2.0 (v2.1)

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
Safezones protection.
Zombie Missions !
Possibility to display infested zones on map.
Adjustable zombies health and damage.
Zombies won't disappear if close to a player.
Zombies won't spawn right next to a player.
Alternative, light and Ultra-light configs for larger servers.

Known Issues :

Zombie animations are not quite working,

Requirement

Zombies & Demons 3.3 by ryandombrowsky,

https://forums.bistudio.com/topic/182412-zombies-demons-33/

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

Special Thanks

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