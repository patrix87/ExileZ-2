// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//exit if script is already running

private ["_triggerObj","_group","_groupSize","_triggerPosition","_nearestLocation","_newAct","_VestGroup","_LootGroup","_ZombieGroup","_avoidTerritory","_SpawnDelay","_RespawnDelay","_cnt","_triggerList"];

if (_this select 0 getvariable ["active", False]) exitwith {};

//Set the script as active
_this select 0 setvariable ["active", true, False];

_triggerObj  = _this select 0;


//get the variable from the trigger
_group = _triggerObj getvariable ["group", objNull];

_groupSize = _triggerObj getvariable ["groupSize", 0];
_avoidTerritory = _triggerObj getvariable ["avoidTerritory", false];

_vestGroup = _triggerObj getvariable ["vestGroup", nil];
_lootGroup = _triggerObj getvariable ["lootGroup", nil];
_zombieGroup = _triggerObj getvariable ["zombieGroup", nil];

_spawnDelay = _triggerObj getvariable ["spawnDelay", 15];
_respawnDelay = _triggerObj getvariable ["respawnDelay",45];

//local variables
_newAct = true;
_triggerPosition = (getpos (_triggerObj));
_nearestLocation = text nearestLocation [_triggerPosition, ""];


if (Debug) then {
	diag_log format["ExileZ 2.0: Activating Trigger	|	Position : %1	|	GroupSize : %2	|	Near : %3 ",_triggerPosition,_groupSize,_nearestLocation];
};

//Select a random player and spawn a zombie near him
SpawnOne = {
	_triggerList = list _triggerObj;
	if !(count _triggerList == 0) then 
	{
		_playerObj = _triggerList call BIS_fnc_selectRandom;
		_playerPos = getPos _playerObj;
		nul = [_group,_playerPos,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory] spawn SpawnZombie;
	};
};


//Active loop
while {triggeractivated (_this select 0)} do 
{
	if (isNull _group) then 
	{ 															//the zombie group is empty or all dead
		_group = [_triggerObj] call InitGroup;					//Create Group
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
					call SpawnOne;
				};
				sleep _SpawnDelay;								//spawn delay
			};
			_newAct = false;
		} 
		else 													//player probably killed all the zombies without leaving the zone
		{
			call SpawnOne;
			sleep _RespawnDelay; 								//Wait respawn time
		};
	}
	else //group is not empty
	{
		_cnt = {alive _x} count units _group; 					//count number of zombie alive in the group
		_triggerList = list _triggerObj;
		_playersInZone = count _triggerList;
		_scaledGroupSize = _groupSize + (_groupSize * TriggerGroupScaling * _playersInZone);
		if (_cnt < _scaledGroupSize) then 
		{
			call SpawnOne;
		};
		sleep _RespawnDelay; 									//Wait respawn time
	};
};
//Reboot the trigger
diag_log format["ExileZ 2.0: Deactivating Trigger	|	Position : %1	|	GroupSize : %2	|	Near : %3 ",_triggerPosition,_groupSize,_nearestLocation];
_this select 0 setvariable ["active", false, False];