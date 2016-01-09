// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//exit if script is already running

private ["_triggerObj","_group","_positions","_groupSize","_triggerPosition","_nearestLocation","_newAct","_SpawnRadius","_VestGroup","_LootGroup","_ZombieGroup","_avoidTerritory","_del","_SpawnDelay","_RespawnDelay","_cnt","_DeleteDelay"];

if (_this select 0 getvariable ["active", False]) exitwith {};

//Set the script as active
_this select 0 setvariable ["active", true, False];

_triggerObj = _this select 0;

//get the variable from the trigger
_group = _triggerObj getvariable ["group", objNull];
_positions = _triggerObj getvariable ["positions", []];

_groupSize = _triggerObj getvariable ["groupSize", 0];
_avoidTerritory = _triggerObj getvariable ["avoidTerritory", false];
_spawnRadius = _triggerObj getvariable ["spawnRadius", 150];

_vestGroup = _triggerObj getvariable ["vestGroup", nil];
_lootGroup = _triggerObj getvariable ["lootGroup", nil];
_zombieGroup = _triggerObj getvariable ["zombieGroup", nil];

_spawnDelay = _triggerObj getvariable ["spawnDelay", 15];
_respawnDelay = _triggerObj getvariable ["respawnDelay",45];
_deleteDelay = _triggerObj getvariable ["deleteDelay",60];

_newAct = _triggerObj getvariable ["newAct", true];
_triggerPosition = (getpos (_triggerObj));
_nearestLocation = text nearestLocation [_triggerPosition, ""];


if (Debug) then {
	diag_log format["ExileZ 2.0: Activating Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	Near : %4 ",_triggerPosition,_SpawnRadius,_groupSize,_nearestLocation];
};

//Active loop
while {triggeractivated (_this select 0)} do 
{
	if (isNull _group) then 
	{ 															//the zombie group is empty or all dead
		_group = [_triggerObj] call InitGroup;									//Create Group
		if (_newAct) then 
		{ 														//if newAct is true The zombies were deleted not killed
			for "_x" from 1 to _groupSize do 
			{													//populate the group "rapidly"
				if (triggeractivated (_this select 0)) then 
				{												//player check
					if (isNull _group) then 
					{ 											//the zombie group is empty or all dead
						_group = [_triggerObj] call InitGroup;
						sleep 1;
					};
					nul = [_group,_triggerPosition,0,_spawnRadius,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,_positions] spawn SpawnZombie;
				};
				sleep _SpawnDelay;								//spawn delay
			};
			_newAct = false;
			_triggerObj setvariable ["newAct", false, False];
		} 
		else 													//player probably killed all the zombies without leaving the zone
		{
			nul = [_group,_triggerPosition,0,_spawnRadius,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,_positions] spawn SpawnZombie;
			sleep _RespawnDelay; 								//Wait respawn time
		};
	}
	else //group is not empty
	{
		_cnt = {alive _x} count units _group; 					//count number of zombie alive in the group
		if (_cnt < _groupSize) then 
		{
			nul = [_group,_triggerPosition,0,_spawnRadius,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,_positions] spawn SpawnZombie;
		};
		sleep _RespawnDelay; 									//Wait respawn time
	};
};


//Trigger is no longer active, kill the zombies
sleep _DeleteDelay;												//Wait Delete delay
if !(triggeractivated (_this select 0)) then {
	_del = count (units _Group);
	{
		_x setdamage 1;
		deleteVehicle _x;
	} foreach (units _Group);									//Kill all the units in the group and delete the zombies
	_triggerObj setvariable ["newAct", true, False];			//Set the activation state to new to enable fast spawn.
	if (Debug) then {
		diag_log format["ExileZ 2.0: Deactivating Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	%4	Zombie Deleted	|	Near : %5 ",_triggerPosition,_SpawnRadius,_groupSize,_del,_nearestLocation];
	};
};
_this select 0 setvariable ["active", false, False];