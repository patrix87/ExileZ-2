// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

private [
    "_group",
	"_cnt",
	"_localityChanged",
	"_xOffset",
	"_yOffset",
	"_zombieSpawnPosition",
	"_playerPosition"
];

_group = (_this select 0) getvariable ["group", objNull];

_playerPosition = getpos (_this select 0);

//randomize spawn location
_xOffset = floor ((random (HZMaxSpawnDistance-HZMinSpawnDistance))+HZMinSpawnDistance);
_yOffset = floor ((random (HZMaxSpawnDistance-HZMinSpawnDistance))+HZMinSpawnDistance);
_xOffset = [_xOffset,(-_xOffset)] call BIS_fnc_selectRandom;
_yOffset = [_yOffset,(-_yOffset)] call BIS_fnc_selectRandom;
_zombieSpawnPosition = [round((_playerPosition select 0) + _xOffset),round((_playerPosition select 1) + _yOffset)];

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
	(HZombieClasses call BIS_fnc_selectRandom) createUnit 
	[
		_zombieSpawnPosition,
		_group,
		"
		this addVest (zVest call BIS_fnc_selectRandom);
		this addItemToVest (zLoot call BIS_fnc_selectRandom);
		this disableAI 'FSM';
		this disableAI 'AUTOTARGET';
		this disableAI 'TARGET';
		this disableConversation true;
		this setCaptive true;	
		this setbehaviour 'CARELESS';
		this allowFleeing 0;
		this setunitpos 'UP';
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		"
	];
};

//Spawning
if (isNull _group) then 
{ 	//the zombie group is empty or all dead
	nul = call HZInitGroup; 						//Create Group
	sleep 3;
	nul = call HZPopulate; 						//Spawn 1 zombie
} 
else 
{	//group is not empty or all dead
	_cnt = {alive _x} count units _group; 		//count number of zombie alive in the group
	if (_cnt < HZGroupsSize) then 
	{
		nul = call HPopulate; 					//Spawn 1 zombie
	};
};

//cleanup, delete zombie if it is too far from the player that spawned it.
{
	if ((_x distance (_this select 0)) > HZMaxDistance) then {
		_x setdamage 1;
		deleteVehicle _x;
	};
} foreach (units _Group);
