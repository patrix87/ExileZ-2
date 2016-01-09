// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //
private ["_return","_result","_count","_forEachIndex","_currentTrigger"];

//Global Settings
ZombieSide                   = EAST;             // zombie team side east, west and Civilian can be used
ZombieSideString             = "EAST";           // Same thing but in a string.
CorpseDeleteDelay            = 300;              // delay before a zombie corpse is deleted.
Debug                        = true;             // debug messages.
MinSpawnDistance             = 10;               // Minimum distance from any player to spawn a zombie.
                             
//Explosive zombies          
ExplosiveZombies             = true;             // randomly boobie trapped zombies exploding a few seconds after dying.
ExplosiveZombiesRatio        = 2;                // percentage of explosive zombies
ExplosiveZombieWarning       = "IT'S A TRAP !!!";// Message that will display a few seconds before the explosion of a zombie.
ExplosionDelay               = 3;                // self-explanatory
ExplosiveType                = "Grenade" ;       // "mini_Grenade" for small almost non-lethal explision or "Grenade" Big and dangerous explosion.
ExplosiveRespect             = 100;              // Bonus respect for Exploding zombies

//Killing zombies settings
ZombieMoney                  = 5;                // Money per zombie kill
ZombieRespect                = 10;               // Respect per zombie kill
RoadKillBonus                = 10;               // Bonus Respect if roadkill
MinDistance                  = 50;               // Minimal distance for range bonus
CqbDistance                  = 10;               // Minimal ditance for close quarter bonus
CqbBonus                     = 40;               // Respect for close quarter bonus at 1 meter
DistanceBonusDivider         = 10;               // Distance divided by that number = respect E.G. 300m / [20] = 15 Respect

//Zombie settings
Ryanzombieshealth			 = 0.75; 	         //Health, *(initial damage level 0 is no damage 1 is dead)
Ryanzombieshealthdemon 		 = 0.7;		         //Health, *(initial damage level 0 is no damage 1 is dead)
Ryanzombiesattackspeed 		 = 1.5;		         //Attack speed, *(Time is seconds between attacks)
Ryanzombiesattackdistance 	 = 2.0;		         //Attack distance, *(in meters)
Ryanzombiesattackstrenth 	 = 2;		         //Attack strength *(not sure what this does but more is more)
Ryanzombiesdamage 			 = 0.07;             //Attack damage *(% of players life per hit, 1 is 100%)
Ryanzombiesdamagecar 		 = 0.1;		         //Attack damage to car *(% of car health per hit, 1 is 100%)
Ryanzombiesdamageair 		 = 0.025;	         //Attack damage to air *(% of car health per hit, 1 is 100%)
Ryanzombiesdamagetank        = 0.01;	         //Attack damage to tank *(% of car health per hit, 1 is 100%)
Ryanzombiesdamagecarstrenth  = 2;		         //Car attack strength *(Not sure what this does I think it related to the power of the throw when throw is enabled)
Ryanzombiesdamageairstrenth  = 1.5;		         //Air attack strength *(Not sure what this does I think it related to the power of the throw when throw is enabled)
Ryanzombiesdamagetankstrenth = 0.5;		         //Tank attack strength *(Not sure what this does I think it related to the power of the throw when throw is enabled)
                                                 
//Comment these out to disable them              
//Ryanzombiescanthrow 		 = 1;		         //Enable or disable Throwing for zombies
//Ryanzombiescanthrowtank    = 1;		         //Enable or disable Throwing tank for zombies                                              
Ryanzombiescanthrowdistance	 = 50;		         //Max throw distance

Ryanzombiescanthrowdemon     = 1;		         //Enable or disable Throwing for demons
//Ryanzombiescanthrowtankdemon = 1;		         //Enable or disable Throwing tank for demons
Ryanzombiescanthrowdistancedemon = 100;		     //Max throw distance demon

//Custom map settings
A2Buildings                  = false;            // set to true if using A2 Maps or maps with A2 Buildings it looks for "House" instead of "House_F"

// If nothing is spawning in A2 Maps try A2Buildings at false, some maps have been updated to Arma 3
// If still nothing is spawning set DynamicGroupSize to false
// If still nothing is spawning set UseBuildings to false
// If still nothing is spawning verify that your trigger are being created.
// If still nothing is spawning ... well write on the forum :P

//Change that to point to your trigger location file
#include "TownPositions_Altis.sqf";

//Default Altis SafeZones
SafeZonePositions =
[//  [[Coordinates],Radius]  // You can Get the safezone information directly from your mission.sqm under class Markers
  [[14599,16797],175],
  [[23334,24188],175],
  [[2998,18175],175]
];

// HeadlessClient settings *** Currently not supported ***
UseHC                        = false;            // set to true if running Headless Client
// Headless client must be properly setup in the mission.sqm, Name must be HC

//Harassing zombies - with this you're never safe, zombies will spawn near you ALL THE TIME. *(they do not spawn in safezone and Territory)
UseHarassingZombies          = true;

HSet = [
/* 0 Groups Size  */           2,                  // maximum number of zombies around a player
/* 1 Frequency */              180,                // time in seconds between each new zombie.
/* 2 Max Distance */           150,                // maximum distance from the player before the zombie is deleted.
/* 3 Min Spawn Distance */     20,                 // minimum spawn distance from the player. (don't set 0)
/* 4 Max Spawn Distance */     75,                 // maximum spawn distance from the player.
/* 5 Vest group */             Vest_3,             // Vest function defined in ZVest.sqf
/* 6 Loot group */             Loot_4,             // Loot function defined in ZLoot.sqf
/* 7 Zombie group */           Group_3,            // Group function defined in ZClasses.sqf
/* 8 Avoid Territory */        true                // Zombies won't spawn in Territories if true
];

UseHorde          = true;

HordeSet = [
/* 0 Groups Size  */           25,                 // maximum number of zombies around a player
/* 1 Min Frequency */          30,                 // min time in minutes between each new zombie horde.
/* 2 Max Frequency */          90,                 // max time in minutes between each new zombie horde.
/* 3 Max Distance */           150,                // maximum distance from the player before the zombies are deleted.
/* 4 Min Spawn Distance */     20,                 // minimum spawn distance from the player. (don't set 0)
/* 5 Max Spawn Distance */     75,                 // maximum spawn distance from the player.
/* 6 Vest group */             Vest_1,             // Vest function defined in ZVest.sqf
/* 7 Loot group */             Loot_3,             // Loot function defined in ZLoot.sqf
/* 8 Zombie group */           Group_1,            // Group function defined in ZClasses.sqf
/* 9 Avoid Territory */        true,               // Zombies won't spawn in Territories if true
/* 10 Horde density */         25                  // Radius in which the zombies will spawn
];



UseTriggers                  = true;

//place loot boxes and mission script here
trigger3mission = compile preprocessFile "exilez\init\zmission.sqf";
trigger3lootbox = compile preprocessFile "exilez\init\zmissionloot.sqf";


// List all the trigger group to use here.
Triggers = [Trigger_1,Trigger_2,Trigger_3];

Trigger_1 = [				 //Mission Trigger
/* 0  Use this trigger */    True,
/* 1  Trigger Positions */   TriggerPositions_1,
/* 2  Trigger Radius */      300,
/* 3  Spawn Radius */        250,
/* 4  Max Group Size */      15,
/* 5  Min Group Size */      3,
/* 6  Dynamic Group Size */  true,
/* 7  Dynamic Ratio */       3,
/* 8  Activation Delay */    15,
/* 9  Spawn Delay */         15,
/* 10 Respawn Delay */       60,
/* 11 Delete Delay */        60,
/* 12 Show Trigger On Map */ true,
/* 13 Marker Color */        "ColorRed",
/* 14 Marker Alpha */        0.2,
/* 15 Marker Text */         "Zombies",
/* 16 Use Buildings */       true,
/* 17 Vest group */          Vest_1,
/* 18 Loot group */          Loot_1,
/* 19 Zombie group */        Group_1,
/* 20 Avoid Territory */     false,
/* 21 Mission SQF */         nil,
/* 22 Loot Box */            nil
];

Trigger_2 = [				 //Mission Trigger
/* 0  Use this trigger */    True,
/* 1  Trigger Positions */   TriggerPositions_2,
/* 2  Trigger Radius */      300,
/* 3  Spawn Radius */        250,
/* 4  Max Group Size */      10,
/* 5  Min Group Size */      3,
/* 6  Dynamic Group Size */  false,
/* 7  Dynamic Ratio */       3,
/* 8  Activation Delay */    15,
/* 9  Spawn Delay */         15,
/* 10 Respawn Delay */       20,
/* 11 Delete Delay */        60,
/* 12 Show Trigger On Map */ true,
/* 13 Marker Color */        "ColorBlack",
/* 14 Marker Alpha */        0.5,
/* 15 Marker Text */         "No camping",
/* 16 Use Buildings */       false,
/* 17 Vest group */          Vest_2,
/* 18 Loot group */          Loot_2,
/* 19 Zombie group */        Group_2,
/* 20 Avoid Territory */     false,
/* 21 Mission SQF */         nil,
/* 22 Loot Box */            nil
];

Trigger_3 = [				 //Mission Trigger
/* 0  Use this trigger */    True,
/* 1  Trigger Positions */   TriggerPositions_3,
/* 2  Trigger Radius */      500,
/* 3  Spawn Radius */        200,
/* 4  Max Group Size */      25,
/* 5  Min Group Size */      3,
/* 6  Dynamic Group Size */  false,
/* 7  Dynamic Ratio */       3,
/* 8  Activation Delay */    10,
/* 9  Spawn Delay */         10,
/* 10 Respawn Delay */       15,
/* 11 Delete Delay */        60,
/* 12 Show Trigger On Map */ true,
/* 13 Marker Color */        "ColorYellow",
/* 14 Marker Alpha */        0.5,
/* 15 Marker Text */         "LOOT AND DEATH HERE",
/* 16 Use Buildings */       false,
/* 17 Vest group */          Vest_1,
/* 18 Loot group */          Loot_3,
/* 19 Zombie group */        Group_4,
/* 20 Avoid Territory */     false,
/* 21 Mission SQF */         trigger3mission,
/* 22 Loot Box */            trigger3lootbox
];


/* DON'T EDIT BELOW ADVANCED USERS ONLY */
//////////////////////////////////////////
sleep 1;

diag_log "\\\ --- Starting ExileZ 2.0 --- ///";

#include "ZClassesList.sqf";
#include "ZLoot.sqf";
#include "ZVest.sqf";
#include "ZClasses.sqf";

//Set Ryanzombies public variables
publicVariable "Ryanzombieshealth";
publicVariable "Ryanzombieshealthdemon";
publicVariable "Ryanzombiesattackspeed";
publicVariable "Ryanzombiesattackdistance";
publicVariable "Ryanzombiesattackstrenth";
publicVariable "Ryanzombiesdamage";
publicVariable "Ryanzombiesdamagecar";
publicVariable "Ryanzombiesdamageair";
publicVariable "Ryanzombiesdamagetank";
publicVariable "Ryanzombiesdamagecarstrenth";
publicVariable "Ryanzombiesdamageairstrenth";
publicVariable "Ryanzombiesdamagetankstrenth";
publicVariable "Ryanzombiescanthrow";
publicVariable "Ryanzombiescanthrowdemon";
publicVariable "Ryanzombiescanthrowtank";
publicVariable "Ryanzombiescanthrowtankdemon";
publicVariable "Ryanzombiescanthrowdistance";
publicVariable "Ryanzombiescanthrowdistancedemon";

//compile code
CreateTriggers = compile preprocessFile "exilez\init\code\CreateTriggers.sqf";
TriggerLoop = compile preprocessFile "exilez\init\code\TriggerLoop.sqf";
HarassingZombiesLoop = compile preprocessFile "exilez\init\code\HarassingZombiesLoop.sqf";
InitGroup = compile preprocessFile "exilez\init\code\InitGroup.sqf";
SpawnZombie = compile preprocessFile "exilez\init\code\SpawnZombie.sqf";
ZMPKilled = compile preprocessFile "exilez\init\code\MPKilled.sqf";
Safezone = compile preprocessFile "exilez\init\code\Safezone.sqf";
GetRandomLocation = compile preprocessFile "exilez\init\code\GetRandomLocation.sqf";
SpawnZombie = compile preprocessFile "exilez\init\code\SpawnZombie.sqf";
VerifyLocation = compile preprocessFile "exilez\init\code\VerifyLocation.sqf";
HordeLoop = compile preprocessFile "exilez\init\code\HordeLoop.sqf";
HordeZombieDeleter = compile preprocessFile "exilez\init\code\HordeZombieDeleter.sqf";

//Create Triggers
if (UseTriggers) then
{
	{
		if (_x select 0) then {
			//Weight Zombie Group
			_currentTrigger = _x;
			_count = 0;
			{
				_count = _count + (_x select 1);
				(_x select _forEachIndex) set [1,_count];
			}foreach (_currentTrigger select 19);
			
			//Create triggers
			{nul = [_x,_CurrentTrigger] spawn CreateTriggers;
				sleep 0.01;
			}foreach (_x select 0);
		};
	}foreach Triggers;
};

//Create Triggers for safezones
{nul = [_x] spawn Safezone;
	sleep 0.01;
}foreach SafeZonePositions;


//Enable the HarassingZombies
if (UseHarassingZombies) then {
	nul = [HSet] spawn HarassingZombiesLoop;
};


//Enable the Horde
if (UseHorde) then {
	nul = [HordeSet] spawn HordeLoop;
};



sleep 1;

diag_log "/// --- ExileZ 2.0 Started --- \\\";
