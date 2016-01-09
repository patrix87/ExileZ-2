// Populate the group with 1 zombie

private[
	"_group",
	"_triggerPosition",
	"_spawnRadius",
	"_vestGroup",
	"_lootGroup",
	"_zombieGroup",
	"_minSpawnDistance",
	"_positions",
	"_position",
	"_validLocation",
	"_zClass",
	"_avoidTerritory",
	"_return",
	"_result"
	
];

_group =             _this select 0;
_triggerPosition =   _this select 1;
_minSpawnDistance =  _this select 2;
_spawnRadius =       _this select 3;
_vestGroup =         _this select 4;
_lootGroup =         _this select 5;
_zombieGroup =       _this select 6;
_avoidTerritory =    _this select 7;
_positions =         _this select 8;

// Try 5 times to get a valid position
for "_i" from 1 to 5 do {
	if !(isNull _positions) then
	{
		_position = _positions call BIS_fnc_selectRandom;
	}
	else
	{
		_position = [_triggerPosition,_minSpawnDistance,_spawnRadius] call GetRandomLocation;
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
		diag_log format["ExileZ 2.0: No suitable spawn location found for a Zombie near %1 ",_triggerPosition];
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
		this disableConversation true;
		this setbehaviour 'CARELESS';
		this allowFleeing 0;
		this setunitpos 'UP';
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		doStop this;
		"
	];
};
_zClass;