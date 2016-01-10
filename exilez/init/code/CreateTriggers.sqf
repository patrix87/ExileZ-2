// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//Variable declaration
private [
"_triggerPosition",
"_trigger",
"_buildings",
"_positions",
"_posCount",
"_index",
"_nearestLocation",
"_groupSize",
"_triggerRadius",
"_spawnRadius",
"_maxGroupSize",
"_minGroupSize",
"_dynamicGroupSize",
"_dynamicRatio",
"_activationDelay",
"_spawnDelay",
"_respawnDelay",
"_showTriggerOnMap",
"_zMarkerColor",
"_zMarkerAlpha",
"_useBuildings",
"_vestGroup",
"_lootGroup",
"_zombiegroup",
"_lootBox",
"_avoidTerritory",
"_zMarkerText",
"_mission",
"_marker"
];


//Current spawner position

_triggerPosition 		= _this select 0;
_triggerRadius 			= (_this select 1) Select 2;
_spawnRadius 			= (_this select 1) Select 3;
_maxGroupSize 			= (_this select 1) Select 4;
_minGroupSize 			= (_this select 1) Select 5;
_dynamicGroupSize 		= (_this select 1) Select 6;
_dynamicRatio 			= (_this select 1) Select 7;
_activationDelay 		= (_this select 1) Select 8;
_spawnDelay 			= (_this select 1) Select 9;
_respawnDelay 			= (_this select 1) Select 10;
_showTriggerOnMap 		= (_this select 1) Select 11;
_zMarkerColor 			= (_this select 1) Select 12;
_zMarkerAlpha 			= (_this select 1) Select 13;
_zMarkerText 			= (_this select 1) Select 14;
_useBuildings 			= (_this select 1) Select 15;
_vestGroup 				= (_this select 1) Select 16;
_lootGroup 				= (_this select 1) Select 17;
_zombieGroup 			= (_this select 1) Select 18;
_avoidTerritory			= (_this select 1) Select 19;
_mission                = (_this select 1) Select 20;
_lootBox                = (_this select 1) Select 21;
_nearestLocation 		= text nearestLocation [_triggerPosition, ""];

//Create trigger area
_trigger = createTrigger["EmptyDetector", _triggerPosition];
_trigger setTriggerArea[_triggerRadius, _triggerRadius, 0, true]; 	//this is a sphere
_trigger setTriggerTimeout [_activationDelay, _activationDelay, _activationDelay, false];
_trigger setTriggerActivation["GUER", "PRESENT", TRUE]; 			//Only Exile player can trigger
_trigger setTriggerStatements["this && {isplayer vehicle _x}count thislist > 0", "nul = [thisTrigger] spawn TriggerLoop;", ""];

if (_showTriggerOnMap) then {
	//circle
	_marker = createmarker [format["Zombies-pos-%1,%2",(_triggerPosition select 0),(_triggerPosition select 1)], _triggerPosition];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_triggerRadius, _triggerRadius];
	_marker setMarkerAlpha _zMarkerAlpha;
	_marker setMarkerColor _zMarkerColor;
	//dot and text
	if !(_zMarkerText == "") then 
	{
		_marker2 = createmarker [format["Zombies-pos-%1,%2-2",(_triggerPosition select 0),(_triggerPosition select 1)], _triggerPosition];
		_marker2 setMarkerShape "ICON";
		_marker2 setMarkerType "mil_dot";
		_marker2 setMarkerText _zMarkerText;
	};
};



if (_UseBuildings) then
{
	_positions = [];
	
	//Creates a array of all Houses within TriggerDistance of the trigger position

	if (A2Buildings) then 
	{
		_buildings = nearestObjects[_triggerPosition,["House"], _spawnRadius];
	}
	else
	{
		_buildings = nearestObjects[_triggerPosition,["House_F"], _spawnRadius]; 
	};


	//Create a array with every position available in every houses.
	{
		_index = 0;
		while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
			_positions = _positions + [_x buildingPos _index];
			_index = _index + 1;
		};
	}foreach _buildings;

	//Count number of available position around the trigger zone
	
	_posCount = count _positions;
	
	//set GroupSize
	if (_DynamicGroupSize) then{
		_groupSize = round(_posCount / 100 * _DynamicRatio);
		
		if (_groupSize > _maxGroupSize) then {
			_groupSize = _maxGroupSize;
		};
		if (_groupSize < _minGroupSize) then {
			_groupSize = _minGroupSize;
		};	
	}
	else
	{
		_groupSize = _maxGroupSize;
	};
	
	if (Debug) then {
		diag_log format["ExileZ 2.0: Creating Trigger	|	Position : %1 	|	Radius : %2m	|	GroupSize : %3	|	Buildings : %4	|	Spawn Positions : %5	|	Near : %6 ",
		_triggerPosition,_triggerRadius,_groupSize,Count _buildings,_posCount,_nearestLocation];
	};
}
else
{	
	if (Debug) then {
		_groupSize = _maxGroupSize;
		diag_log format["ExileZ 2.0: Creating Trigger	|	Position : %1 	|	Radius : %2m	|	Near : %3 ",
		_triggerPosition,_triggerRadius,_nearestLocation];
	};
};

// Store Variables in the trigger.

_trigger setvariable ["groupSize", _groupSize, False];
_trigger setvariable ["avoidTerritory",_avoidTerritory, False];
_trigger setvariable ["spawnRadius",_spawnRadius, False];

_trigger setvariable ["vestGroup",_vestGroup, False];
_trigger setvariable ["lootGroup",_lootGroup, False];
_trigger setvariable ["zombieGroup",_zombieGroup, False];

_trigger setvariable ["spawnDelay",_spawnDelay, False];
_trigger setvariable ["respawnDelay",_respawnDelay, False];



// Spawn Mission sqf
if !(isnil "_mission") then {
	nul = [] spawn _mission;
};

// Spawn loot box
if !(isnil "_lootBox") then {
	nul = [_triggerPosition] spawn _lootBox;
};








