// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //
#include "code\pre_init.sqf";
#include "ZClassesList.sqf";
#include "ZLoot.sqf";
#include "ZVest.sqf";
#include "ZClasses.sqf";
// EDIT BELOW

//Global Settings
ZombieSide                   = EAST;             // zombie team side east, west and Civilian can be used
ZombieSideString             = "EAST";           // Same thing but in a string.
CorpseDeleteDelay            = 300;              // delay before a zombie corpse is deleted.
Debug                        = true;             // debug messages.
MinSpawnDistance             = 10;               // Closest distance from any player to spawn a zombie.
MaxDistance			         = 200;              // Max distance to player before delete.
MaxTime                      = 60;               // Max time away from a player before delete.
RemoveZfromTerritory         = true;             // Will kill zombies when they get too close to a flag. *(the check is done every MaxTime) will only work with zombies that are configured to avoid territories
                         
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
#include "TriggerPositions.sqf";

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
/* 2 Min Spawn Distance */     20,                 // minimum spawn distance from the player. (don't set 0)
/* 3 Max Spawn Distance */     75,                 // maximum spawn distance from the player.
/* 4 Vest group */             Vest_3,             // Vest function defined in ZVest.sqf
/* 5 Loot group */             Loot_4,             // Loot function defined in ZLoot.sqf
/* 6 Zombie group */           Group_3,            // Group function defined in ZClasses.sqf
/* 7 Avoid Territory */        true                // Zombies won't spawn in Territories if true
];

UseHorde          = true;

HordeSet = [
/* 0 Groups Size  */           20,                 // maximum number of zombies around a player
/* 1 Min Frequency */          20,                  // min time in minutes between each new zombie horde.
/* 2 Max Frequency */          80,                  // max time in minutes between each new zombie horde.
/* 3 Min Spawn Distance */     30,                 // minimum spawn distance from the player. (don't set 0)
/* 4 Max Spawn Distance */     75,                 // maximum spawn distance from the player.
/* 5 Vest group */             Vest_1,             // Vest function defined in ZVest.sqf
/* 6 Loot group */             Loot_3,             // Loot function defined in ZLoot.sqf
/* 7 Zombie group */           Group_1,            // Group function defined in ZClasses.sqf
/* 8 Avoid Territory */        true,               // Zombies won't spawn in Territories if true
/* 9 Horde density */          25                  // Radius in which the zombies will spawn should be lower than Min Spawn Distance.
];

UseTriggers                  = true;

//place loot boxes and mission script here
trigger3mission = compile preprocessFile "exilez\init\zmission.sqf";
trigger3lootbox = compile preprocessFile "exilez\init\zmissionloot.sqf";

Trigger_1 = [				 //Towns
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
/* 11 Show Trigger On Map */ true,
/* 12 Marker Color */        "ColorRed",
/* 13 Marker Alpha */        0.2,
/* 14 Marker Text */         "",
/* 15 Use Buildings */       true,
/* 16 Vest group */          Vest_1,
/* 17 Loot group */          Loot_1,
/* 18 Zombie group */        Group_1,
/* 19 Avoid Territory */     false,
/* 20 Mission SQF */         nil,
/* 21 Loot Box */            nil
];

Trigger_2 = [				 //Anti-Camping
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
/* 11 Show Trigger On Map */ true,
/* 12 Marker Color */        "ColorBlack",
/* 13 Marker Alpha */        0.5,
/* 14 Marker Text */         "No camping",
/* 15 Use Buildings */       false,
/* 16 Vest group */          Vest_2,
/* 17 Loot group */          Loot_2,
/* 18 Zombie group */        Group_2,
/* 19 Avoid Territory */     false,
/* 20 Mission SQF */         nil,
/* 21 Loot Box */            nil
];

Trigger_3 = [				 //Mission Trigger
/* 0  Use this trigger */    True,
/* 1  Trigger Positions */   TriggerPositions_3,
/* 2  Trigger Radius */      500,
/* 3  Spawn Radius */        120,
/* 4  Max Group Size */      15,
/* 5  Min Group Size */      3,
/* 6  Dynamic Group Size */  false,
/* 7  Dynamic Ratio */       3,
/* 8  Activation Delay */    5,
/* 9  Spawn Delay */         5,
/* 10 Respawn Delay */       5,
/* 11 Show Trigger On Map */ true,
/* 12 Marker Color */        "ColorYellow",
/* 13 Marker Alpha */        0.5,
/* 14 Marker Text */         "LOOT AND DEATH",
/* 15 Use Buildings */       false,
/* 16 Vest group */          Vest_1,
/* 17 Loot group */          Loot_3,
/* 18 Zombie group */        Group_4,
/* 19 Avoid Territory */     false,
/* 20 Mission SQF */         trigger3mission,
/* 21 Loot Box */            trigger3lootbox
];

// List all the trigger group to use here.
Triggers = [Trigger_1,Trigger_2,Trigger_3];

// DON'T EDIT BELOW

#include "code\post_init.sqf";