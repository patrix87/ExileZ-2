// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //
#include "code\pre_init.sqf";
#include "ZClassesList.sqf";                     //All available classes per group
#include "ZLoot.sqf";                            //Loot groups
#include "ZVest.sqf";                            //Vest groups
#include "ZClasses.sqf";                         //Zombie classes groups
#include "TriggerPositions.sqf";                 //Trigger positions
// EDIT BELOW

//Global Settings
ZombieSide                   = EAST;             // zombie team side east, west and Civilian can be used
ZombieSideString             = "EAST";           // Same thing but in a string.
CorpseDeleteDelay            = 300;              // delay before a zombie corpse is deleted.
Debug                        = true;             // debug messages.
MinSpawnDistance             = 20;               // Closest distance from any player to spawn a zombie.
MaxSpawnDistance             = 160;              // Max distance a zombie should spawn from a player.
MaxDistance			         = 300;              // Max distance to players before delete.
MaxTime                      = 30;               // Max time away from a player before delete.
RemoveZfromTerritory         = true;             // Will kill zombies when they get too close to a flag. *(the check is done every MaxTime) will only work with zombies that are configured to avoid territories
TriggerGroupScaling          = 0.25;             // 1 player = Groupsize, 2 player in trigger = Groupsize + (GroupSize * TriggerGroupScalling * number of player in the trigger) set at 0 to disable scaling
LightsOff                    = true;             // Kill all the light on map except the player lights.
HarassingZombieAtNightOnly   = true;             // Spawn harassing zombies at night only.
NightStartTime               = 18;               // Time at which it is night in hours
NightEndTime                 = 6;                // Time at which it is no longer night in hours

//Explosive zombies          
ExplosiveZombies             = true;             // randomly boobie trapped zombies exploding a few seconds after dying.
ExplosiveZombiesRatio        = 2;                // percentage of explosive zombies
ExplosiveZombieWarning       = "IT'S A TRAP !!!";// Message that will display a few seconds before the explosion of a zombie.
ExplosionDelay               = 3;                // self-explanatory
ExplosiveType                = "Grenade" ;       // "mini_Grenade" for small almost non-lethal explision or "Grenade" Big and dangerous explosion.
ExplosiveRespect             = 100;              // Bonus respect for Exploding zombies

//Killing zombies settings
EnableMoneyOnKill            = true;             // Self Explanatory
EnableRespectOnKill          = true;             // Self Explanatory
ZombieMoney                  = 5;                // Money per zombie kill
ZombieRespect                = 10;               // Respect per zombie kill
RoadKillBonus                = 10;               // Bonus Respect if roadkill
MinDistance                  = 50;               // Minimal distance for range bonus
CqbDistance                  = 10;               // Minimal ditance for close quarter bonus
CqbBonus                     = 40;               // Respect for close quarter bonus at 1 meter
DistanceBonusDivider         = 10;               // Distance divided by that number = respect E.G. 300m / [20] = 15 Respect

//Zombie settings : SET TO -1 TO DISABLE AND USE DEFAULT FROM RYANZOMBIES
_Ryanzombieshealth			           = 0.8; 	 // Health, *(initial damage level 0 is no damage 1 is dead)
_Ryanzombieshealthdemon                = 0.5;	 // Health, *(initial damage level 0 is no damage 1 is dead)
_Ryanzombiesattackspeed 	           = 1.5;	 // Attack speed, *(Time is seconds between attacks)
_Ryanzombiesattackdistance 	           = 2;	     // Attack distance, *(in meters)
_Ryanzombiesattackstrenth 	           = 0;	     // Attack strength *(Knockback strength) *(TYPO IS NORMAL)
_Ryanzombiesdamage 			           = 0.09;   // Attack damage *(% of players life per hit, 1 is 100%)
_Ryanzombiesdamagecar 		           = 0.05;	 // Attack damage to car *(% of car health per hit, 1 is 100%)
_Ryanzombiesdamageair 		           = 0.01;	 // Attack damage to air *(% of car health per hit, 1 is 100%)
_Ryanzombiesdamagetank                 = 0.005;	 // Attack damage to tank *(% of car health per hit, 1 is 100%)
_Ryanzombiesdamagecarstrenth           = 1.5;	 // Car attack strength *(Knockback strength in M/S)
_Ryanzombiesdamageairstrenth           = 1;	     // Air attack strength *(Knockback strength M/S)
_Ryanzombiesdamagetankstrenth          = 0.4;	 // Tank attack strength *(Knockback strength M/S)
                                                    
_Ryanzombiescanthrow 		           = -1;	 // Enable or disable Throwing for zombies
_Ryanzombiescanthrowtank               = -1;	 // Enable or disable Throwing tank for zombies                                              
_Ryanzombiescanthrowdistance           = 10;	 // Max throw distance
_Ryanzombiescanthrowtankdistance       = 0;      // Max throw distance for tanks                         
                                                    
_Ryanzombiescanthrowdemon              = 1;	     // Enable or disable Throwing for demons
_Ryanzombiescanthrowtankdemon          = 1;	     // Enable or disable Throwing tank for demons
_Ryanzombiescanthrowdistancedemon      = 50;	 // Max throw distance demon
_Ryanzombiescanthrowtankdistancedemon  = 10;     // Max throw distance for tanks      

_ryanzombiesdisablebleeding            = 1;      // 1 to DISABLE player bleeding on hit, -1 to ENABLE player bleeding on hit.
_ryanzombiesstartinganim               = 1;      // Enable Spawning animation
_ryanzombieslimit                      = 100;    // Player detection distance in meters
		
_ryanzombiesdisablemoaning             = -1;     // No idle sound
_ryanzombiesdisableaggressive          = -1;     // No aggressive sounds
_ryanzombiescivilianattacks            = -1;     // Attack civilians
_Ryanzombieslogicroam                  = -1;     // Roam ***roaming can be heavy on cpu
_Ryanzombieslogicroamdemon             = -1;     // Demon Roam
                                                 
_Ryanzombiesjump                       = -1;     //Jumping Zombies
_Ryanzombiesjumpdemon                  = 1;      //Jumping Demons
                                                 
_Ryanzombiesfeed                       = -1;     //Feeding Zombies
_Ryanzombiesfeeddemon                  = 1;      //Feeding Demons
                                                 
_Ryanzombiesinfection                  = -1;     //Enable infections *(-1 to disable)
_ryanzombiesinfectedchance             = 10;     //Precent chances to be infected on hit
_ryanzombiesinfectedrate               = 0.05;   //Damage per minute when infected (+/- 30 minutes to live)
_ryanzombiesinfectedsymptoms           = 0.9;    //Symptomes showed when infected 0.9 = Normal 0.7 = Less 0.5 = None
_ryanzombiesinfecteddeath              = 0.9;    //0.9 = Scream on death 0.7 = Silent death
_ryanzombiesantivirusduration          = 300;    //Antivirus duration *(5 minutes)

//http://steamcommunity.com/sharedfiles/filedetails/?id=614815221 must be installed on the client for the cure to work
//You also need to overide an Exile script, Details here : http://www.exilemod.com/topic/10999-rz-infection-for-exile/

_ryanzombiesmovementspeedwalker        = 1;      //Animation speed for walker zombies
_ryanzombiesmovementspeedslow          = 1;      //Animation speed for slow zombies
_ryanzombiesmovementspeedmedium        = 1;      //Animation speed for medium zombies
_ryanzombiesmovementspeedfast          = 1;      //Animation speed for fast zombies
_ryanzombiesmovementspeeddemon         = 1;      //Animation speed for demons
_ryanzombiesmovementspeedspider        = 1;      //Animation speed for spider
_ryanzombiesmovementspeedcrawler       = 1;      //Animation speed for crawler


//Default Altis SafeZones
SafeZonePositions =
[//  [[Coordinates],Radius]  // You can Get the safezone information directly from your mission.sqm under class Markers
  [[14599,16797],175],
  [[23334,24188],175],
  [[2998,18175],175]
];

UseHarassingZombies          = true;             //

HSet = [
/* 0 Groups Size  */         2,                  // maximum number of zombies around a player
/* 1 Frequency */            180,                // time in seconds between each new zombie.
/* 2 Vest group */           Nothing,            // Vest function defined in ZVest.sqf
/* 3 Loot group */           Nothing,            // Loot function defined in ZLoot.sqf
/* 4 Zombie group */         Easy,               // Group function defined in ZClasses.sqf
/* 5 Avoid Territory */      true                // Zombie will not spawn in territories and will die in them if RemoveZfromTerritory is true
];

UseHorde                     = true;             // Use the horde spawner             

HordeSet = [
/* 0 Groups Size  */         15,                 // maximum number of zombies around a player
/* 1 Min Frequency */        20,                 // min time in minutes between each new zombie horde.
/* 2 Max Frequency */        60,                 // max time in minutes between each new zombie horde.
/* 3 Vest group */           Basic,              // Vest function defined in ZVest.sqf
/* 4 Loot group */           DocAndAmmo,         // Loot function defined in ZLoot.sqf
/* 5 Zombie group */         MediumMix,          // Group function defined in ZClasses.sqf
/* 6 Avoid Territory */      true,               // Zombie will not spawn in territories and will die in them if RemoveZfromTerritory is true
/* 7 Horde density */        25                  // Radius in which the zombies will spawn should be lower than Min Spawn Distance.
];

UseTriggers                  = true;             //use the trigger system.

//place loot boxes and mission script here
triggerMission = compile preprocessFile "exilez\init\zmission.sqf";
triggerLootbox = compile preprocessFile "exilez\init\zmissionloot.sqf";


Trigger_1 = [				 //Cities
/* 0  Use this trigger */    True,               // Self - explanatory
/* 1  Trigger Positions */   Cities,             // The name of the array used to list all trigger position in the TriggerPositions.sqf file
/* 2  Max Zombies */         10,                 // The maximum number of zombies for that trigger.
/* 3  Activation Delay */    15,                 // The delay before the activation of the trigger.
/* 4  Spawn Delay */         15,                 // The delay between each zombie spawn right after the activation until the Max group size is reached.
/* 5  Respawn Delay */       60,                 // The respawn delay after the max group size was reached
/* 6  Show Trigger On Map */ true,               // Put a marker at the location and radius of the trigger on the map
/* 7  Marker Color */        "ColorRed",         // Color of the trigger
/* 8  MarkerBrush */         "Solid",            // "Solid","SolidFull","Horizontal","Vertical","Grid","FDiagonal","BDiagonal","DiagGrid","Cross","Border","SolidBorder"
/* 9  Marker Alpha */        0.2,                // Alpha of the trigger *(0 is invisible 1 is opaque)
/* 10 Marker Text */         "",                 // The text on the trigger
/* 11 Vest group */          Basic,              // The name of the Array used to list all the possible vest for that trigger. ZVest.sqf
/* 12 Loot group */          Useful,             // The name of the Array used to list all the possible loot for that trigger. ZLoot.sqf
/* 13 Zombie group */        MediumCiv,          // The name of the Group used to list the zombies possible for that trigger.  ZClasses.sqf
/* 14 Avoid Territory */     false,              // Zombie will not spawn in territories and will die in them if RemoveZfromTerritory is true
/* 15 Mission Radius */      0,                  // Up to how far from the center of the trigger the mission LOOT can spawn.
/* 16 Mission SQF */         nil,                // The location of the Mission file related to that trigger *(use M3Editor to create the file.) THIS IS STATIC AND WILL NOT MOVE WITH THE TRIGGER
/* 17 Loot Box */            nil                 // The location of the Missionloot file related to that trigger *(See example file zmissionloot.sqf)
];

Trigger_2 = [				 //Military
/* 0  Use this trigger */    True,               
/* 1  Trigger Positions */   Military,        
/* 2  Max Zombies */         10,                 
/* 3  Activation Delay */    15,                 
/* 4  Spawn Delay */         15,                 
/* 5  Respawn Delay */       45,                 
/* 6  Show Trigger On Map */ true,               
/* 7  Marker Color */        "ColorRed",         
/* 8  MarkerBrush */         "Solid",            
/* 9  Marker Alpha */        0.2,                
/* 10 Marker Text */         "",                 
/* 11 Vest group */          Basic,              
/* 12 Loot group */          Useful,             
/* 13 Zombie group */        MediumMil,          
/* 14 Avoid Territory */     false,              
/* 15 Mission Radius */      0,                  
/* 16 Mission SQF */         nil,                
/* 17 Loot Box */            nil                 
];

Trigger_3 = [				 //No Buildings
/* 0  Use this trigger */    True,               
/* 1  Trigger Positions */   NoBuildings,        
/* 2  Max Zombies */         10,                 
/* 3  Activation Delay */    15,                 
/* 4  Spawn Delay */         15,                 
/* 5  Respawn Delay */       60,                 
/* 6  Show Trigger On Map */ true,               
/* 7  Marker Color */        "ColorRed",         
/* 8  MarkerBrush */         "Solid",            
/* 9  Marker Alpha */        0.2,                
/* 10 Marker Text */         "",                 
/* 11 Vest group */          Basic,              
/* 12 Loot group */          Useful,             
/* 13 Zombie group */        MediumMix,          
/* 14 Avoid Territory */     false,              
/* 15 Mission Radius */      0,                  
/* 16 Mission SQF */         nil,                
/* 17 Loot Box */            nil                 
];

Trigger_4 = [				 //No Man Land
/* 0  Use this trigger */    True,               
/* 1  Trigger Positions */   NoMansLand,       
/* 2  Max Zombies */         10,                 
/* 3  Activation Delay */    15,                 
/* 4  Spawn Delay */         15,                 
/* 5  Respawn Delay */       30,                 
/* 6  Show Trigger On Map */ true,               
/* 7  Marker Color */        "ColorRed",         
/* 8  MarkerBrush */         "DiagGrid",            
/* 9  Marker Alpha */        0.2,                
/* 10 Marker Text */         "",                 
/* 11 Vest group */          Basic,              
/* 12 Loot group */          DocAndAmmo,         
/* 13 Zombie group */        Hard,               
/* 14 Avoid Territory */     false,              
/* 15 Mission Radius */      0,                  
/* 16 Mission SQF */         nil,                
/* 17 Loot Box */            nil                 
];

Trigger_5 = [				 //Mission Trigger
/* 0  Use this trigger */    True,               
/* 1  Trigger Positions */   Mission,            
/* 2  Max Zombies */         15,                 
/* 3  Activation Delay */    5,                  
/* 4  Spawn Delay */         5,                  
/* 5  Respawn Delay */       5,                  
/* 6  Show Trigger On Map */ true,               
/* 7  Marker Color */        "ColorYellow",      
/* 8  MarkerBrush */         "Solid",            
/* 9  Marker Alpha */        0.5,                
/* 10 Marker Text */         "LOOT & DEATH",     
/* 11 Vest group */          Basic,              
/* 12 Loot group */          DocAndAmmo,         
/* 13 Zombie group */        Hardcore,           
/* 14 Avoid Territory */     false,              
/* 15 Mission Radius */      1500,               
/* 16 Mission SQF */         triggerMission,    
/* 17 Loot Box */            triggerLootbox     
];

// List all the trigger group to use here.
Triggers = [Trigger_1,Trigger_2,Trigger_3,Trigger_4,Trigger_5];

// DON'T EDIT BELOW

#include "code\post_init.sqf";