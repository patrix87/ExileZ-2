// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

private [
    "_group",
	"_cnt",
	"_localityChanged",
	"_xOffset",
	"_yOffset",
	"_zombieSpawnPosition",
	"_playerPosition",
	"_result",
	"_maxRange",
	"_flags",
	"_distance",
	"_radius"
];

_group = (_this select 0) getvariable ["group", objNull];

_playerPosition = getpos (_this select 0);


//check if coordinate is in safezone try 5 then abort.
_badLocation = false;
_maxRange = getNumber (missionConfigFile >> "CfgTerritories" >> "maximumRadius");

for "_i" from 1 to 5 do {
	//randomize spawn location
	_xOffset = floor ((random (HZMaxSpawnDistance-HZMinSpawnDistance))+HZMinSpawnDistance);
	_yOffset = floor ((random (HZMaxSpawnDistance-HZMinSpawnDistance))+HZMinSpawnDistance);
	_xOffset = [_xOffset,(-_xOffset)] call BIS_fnc_selectRandom;
	_yOffset = [_yOffset,(-_yOffset)] call BIS_fnc_selectRandom;
	_zombieSpawnPosition = [round((_playerPosition select 0) + _xOffset),round((_playerPosition select 1) + _yOffset)];
	//fetch flags around the spawn position
	_flags = _zombieSpawnPosition nearObjects ["Exile_Construction_Flag_Static", _maxRange];
	{
		_distance = (getPosATL _x) distance _zombieSpawnPosition;
		_radius = _x getVariable ["ExileTerritorySize", 0];
		if (_distance <= _radius) exitWith {_badLocation = true}; //if the tested spawn is inside a territory, exit the foreach loop.
		sleep 0.05;
	}forEach _flags;
	if !(_badLocation) exitWith {};	//if the previous spawn position was outside the limit of a territory, exit the loop and use the position.
	sleep 0.05;
};



HZInitGroup = {
	//Create a group for the zombies
	_group = creategroup ZombieSide;
	_group setcombatmode "RED";
	_group allowfleeing 0;
	_group setspeedmode "limited";
	(_this select 0) setvariable ["group", _group, False];
	if (UseHC) then {
		//_localityChanged = _group setGroupOwner (owner HC); //transfer group to HC
	};
};

//Populate the group
HZPopulate = {
	if (_badlocation) then
	{
		diag_log format["ExileZ 2.0: No suitable spawn location found for a Harassing Zombie near %1", _playerPosition];
	}
	else
	{	
		diag_log format["ExileZ 2.0: Spawning 1 Harassing Zombie at %1.",_zombieSpawnPosition];
		(HZombieClasses call BIS_fnc_selectRandom) createUnit 
		[
			_zombieSpawnPosition,
			_group,
			"
			this addVest (zVest call BIS_fnc_selectRandom);
			this addItemToVest (zLoot call BIS_fnc_selectRandom);
			this disableConversation true;
			this setbehaviour 'CARELESS';
			this allowFleeing 0;
			this setunitpos 'UP';
			this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
			doStop this;
			"
		];
	};
};

//Spawning
if (isNull _group) then 
{ 	//the zombie group is empty or all dead
	nul = call HZInitGroup; 					//Create Group
	sleep 3;
	nul = call HZPopulate; 						//Spawn 1 zombie
} 
else 
{	//group is not empty or all dead
	_cnt = {alive _x} count units _group; 		//count number of zombie alive in the group
	if (_cnt < HZGroupsSize) then 
	{
		nul = call HZPopulate; 					//Spawn 1 zombie
	};
};

//cleanup, delete zombie if it is too far from the player that spawned it.
{
	if ((_x distance (_this select 0)) > HZMaxDistance) then {
		_x setdamage 1;
		deleteVehicle _x;
	};
} foreach (units _Group);
