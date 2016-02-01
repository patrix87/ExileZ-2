// Populate a group with 1 zombie at a random location near the given position.

// _validLocation = [_group,_position,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory] call SpawnZombie;
// _return true or false

private ["_face","_group","_position","_vestGroup","_lootGroup","_zombieGroup","_validLocation","_zClass","_avoidTerritory","_maxSpawnDistance","_return","_result"];

_group =             _this select 0;
_position =          _this select 1;
_vestGroup =         _this select 2;
_lootGroup =         _this select 3;
_zombieGroup =       _this select 4;
_avoidTerritory =    _this select 5;

if (count _this == 7) then {
	_MaxSpawnDistance =    _this select 6;	
}
else
{
	_MaxSpawnDistance = MaxSpawnDistance;
};


// Try 5 times to get a valid position near the given position
for "_i" from 1 to 5 do {
	//Get random position
	if !(count _position == 0) then 
	{
		_position = [_position,MinSpawnDistance,_MaxSpawnDistance] call GetRandomLocation;
	};
	//Validate location
	_validLocation = [_position,_avoidTerritory] call VerifyLocation;
	if (_validLocation) exitWith {_validLocation};
	sleep 0.05;
};

GetZombieClass = {
	_return = 0;
	_result = ceil random ((_this select ((count _this) - 1)) select 1);
	{
		if((_x select 1) >= _result) exitwith
		{
			_return = ((_x select 0) call BIS_fnc_selectRandom) select 0;
		};
	}foreach _this;
	_return;
};

if !(_validLocation) then
{
	if (Debug) then {
		diag_log format["ExileZ 2.0: No suitable spawn location found for a Zombie near %1 ",_position];
	};
}
else
{	
	//Get a Zombie Class
	_zClass = _zombieGroup call GetZombieClass;

	if (Debug) then {
		diag_log format["ExileZ 2.0: Spawning 1 Zombie	|	Position : %1	|	Class : %2 ",_position,_zClass];
	};

	_zClass createUnit 
	[
		_position,
		_group,
		"
		if !(call _vestGroup=='') then {this addVest call _vestGroup};
		if !(call _lootGroup=='' && call _vestGroup=='') then {this addItemToVest call _lootGroup};
		doStop this;
		this disableAI 'FSM';
		this enableAI 'ANIM';
		this disableConversation true;
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		nul = [this,_avoidTerritory] spawn ZombieDeleter;
		"
		
	];
};

//return
_validLocation;