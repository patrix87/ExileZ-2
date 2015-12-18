// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//Global Settings
ProtectSafezones         = true;      // if set to true a trigger will kill all "CIV" units within the SafeZonePositions defined below
ZombieSide               = EAST;      // zombie team side east, west and Civilian can be used
ZombieSideString         = "EAST";    // Same thing but in a string.
PregeneratePos           = true;      // slow the server start time but prevent lag spikes.
CorpseDeleteDelay        = 300;       // delay before a zombie corpse is deleted.
Debug                    = true;      // debug messages.

//Explosive zombies
ExplosiveZombies         = true;                // randomly boobie trapped zombies exploding a few seconds after dying.
ExplosiveZombiesRatio    = 2;                   // percentage of explosive zombies
ExplosiveZombieWarning   = "IT'S A TRAP !!!";   // Message that will display a few seconds before the explosion of a zombie.
ExplosionDelay           = 3;                   // self-explanatory
ExplosiveType            = "Grenade" ;          // "mini_Grenade" for small almost non-lethal explision or "Grenade" Big and dangerous explosion.
ExplosiveRespect         = 100;                 // Bonus respect for Exploding zombies

//Main Spawner Settings
UseSpawners              = true;
TriggerRadius            = 300;         // Trigger radius is used to detect player
SpawnRadius              = 250;         // Spawning radius around the trigger
GroupSize                = 12;          // Maximum number of zombies per trigger
MinGroupSize             = 5;           // Used only with DynamicGroupSize.
DynamicGroupSize         = true;        // Set to 1 to dynamically set the max number of zombies for a town *(this will not exceed the GroupSize)
DynamicRatio             = 3;           // Percent of the available spawn position will be filled with a zombie. *(regular town as about 300 positions)
ActivationDelay          = 15;          // Time before the trigger start when activated
SpawnDelay               = 15;          // Spawn time between each zombie spawn if the town was empty
RespawnDelay             = 60;          // Respawn time between each zombies if they are killed
DeleteDelay              = 60;          // Delay before deleting the zombies of a town if empty
ShowTriggerOnMap         = true;        // Show infested zones on the map
ZMarkerColor             = "ColorRed";  // Color of the zone
ZMarkerAlpha             = 0.2;         // Alpha *(Transparency)of the zone
UseBuildings             = true;        // Use the buildings to spawn the zombies instead of random locations

//Secondary Spawner Setting
UseSecSpawners           = true;
SecTriggerRadius         = 250;               // Trigger radius is used to detect player
SecSpawnRadius           = 150;               // Spawning radius around the trigger
SecGroupSize             = 5;                 // Maximum number of zombies per trigger
SecMinGroupSize          = 3;                 // Used only with DynamicGroupSize.
SecDynamicGroupSize      = false;             // Set to 1 to dynamically set the max number of zombies for a town *(this will not exceed the GroupSize)
SecDynamicRatio          = 3;                 // Percent of the available spawn position will be filled with a zombie. *(regular town as about 300 positions)
SecActivationDelay       = 15;                // Time before the trigger start when activated
SecSpawnDelay            = 10;                // Spawn time between each zombie spawn if the town was empty
SecRespawnDelay          = 35;                // Respawn time between each zombies if they are killed
SecDeleteDelay           = 45;                // Delay before deleting the zombies of a town if empty
SecShowTriggerOnMap      = true;              // Show infested zones on the map
SecZMarkerColor          = "ColorBlack";      // Color of the zone
SecZMarkerAlpha          = 0.4;               // Alpha *(Transparency)of the zone
SecUseBuildings          = false;             // Use the buildings to spawn the zombies instead of random locations

//Harassing zombies - with this you're never safe, zombies will spawn near you ALL THE TIME. *Can be ressource heavy.
UseHarassingZombies      = true;
HZGroupsSize             = 2;              // maximum number of zombies around a player
HZFrequency              = 180;            // time in seconds between each new zombie.
HZMaxDistance            = 150;            // maximum distance from the player before the zombie is deleted.
HZMaxSpawnDistance       = 75;             // maximum spawn distance from the player.
HZMinSpawnDistance       = 20;             // minimum spawn distance from the player. (don't set 0)

//Killing zombies settings
ZombieMoney              = 5;       // Money per zombie kill
ZombieRespect            = 10;      // Respect per zombie kill
RoadKillBonus            = 10;      // Bonus Respect if roadkill
MinDistance              = 50;      // Minimal distance for range bonus
CqbDistance              = 10;      // Minimal ditance for close quarter bonus
CqbBonus                 = 40;      // Respect for close quarter bonus at 1 meter
DistanceBonusDivider     = 10;      // Distance divided by that number = respect E.G. 300m / [20] = 15 Respect

//Custom map settings
A2Buildings              = false;      // set to true if using A2 Maps or maps with A2 Buildings it looks for "House" instead of "House_F"

// If nothing is spawning in A2 Maps try A2Buildings at false, some maps have been updated to Arma 3
// If still nothing is spawning set DynamicGroupSize to false
// If still nothing is spawning set UseBuildings to false
// If still nothing is spawning verify that your trigger are being created.
// If still nothing is spawning ... well write on the forum :P

//Change that to point to your Primary zombie spawner location file
#include "TownPositions_Altis.sqf";

//Change that to point to your Secondary zombie spawner location file
#include "Secondary_TownPositions.sqf";

//Default Altis SafeZones
SafeZonePositions =
[//  [[Coordinates],Radius]  // You can Get the safezone information directly from your mission.sqm under class Markers
  [[14599,16797],175],
  [[23334,24188],175],
  [[2998,18175],175]
];

// HeadlessClient settings *** Currently not supported ***
UseHC           = false;       // set to true if running Headless Client
// Headless client must be properly setup in the mission.sqm, Name must be HC


/* DON'T EDIT BELOW ADVANCED USERS ONLY */
//////////////////////////////////////////
sleep 1;
diag_log "\\\ --- Starting ExileZ 2.0 --- ///";

private["_return","_result","_count"];

#include "ZClassesList.sqf";
#include "ZLoot.sqf";
#include "ZVest.sqf";
#include "ZClasses.sqf";

//compile code
CreateTriggers = compile preprocessFile "exilez\init\code\CreateTriggers.sqf";
ZombieSpawner = compile preprocessFile "exilez\init\code\ZombieSpawner.sqf";
SecCreateTriggers = compile preprocessFile "exilez\init\code\SecCreateTriggers.sqf";
SecZombieSpawner = compile preprocessFile "exilez\init\code\SecZombieSpawner.sqf";
HarassingZombies = compile preprocessFile "exilez\init\code\HarassingZombies.sqf";
HarassingZombiesSpawn = compile preprocessFile "exilez\init\code\HarassingZombiesSpawn.sqf";
ZMPKilled = compile preprocessFile "exilez\init\code\MPKilled.sqf";
Safezone = compile preprocessFile "exilez\init\code\Safezone.sqf";

//Create Main Triggers
if (UseSpawners) then
{
  {  nul = [_x] spawn CreateTriggers;
    sleep 0.01;
  }foreach TownPositions;
};

//enable secondary spawners
if (UseSecSpawners) then
{
  {  nul = [_x] spawn SecCreateTriggers;
    sleep 0.01;
  }foreach Secondary_TownPositions;
};

//Create Triggers for safezones
if (ProtectSafezones) then
{
  {  nul = [_x] spawn Safezone;
    sleep 0.01;
  }foreach SafeZonePositions;
};

//Enable the HarassingZombies
if (UseHarassingZombies) then {
  nul = [] spawn HarassingZombies;
};
sleep 1;

diag_log "/// --- ExileZ 2.0 Started --- \\\";
