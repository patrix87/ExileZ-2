// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

// Verify validity of spawning location
// Return True if valid
private[
	"_flags",
	"_avoidTerritory",
	"_validLocation",
	"_maxRange",
	"_distance",
	"_radius",
	"_position"
];

_position = _this select 0;
_avoidTerritory = _this select 1;
_validLocation = true;

// Check if empty
if ((count _position) == 0) then {_validLocation = false};

// Check for safezones
if (_validLocation) then 
{
	{
		if (_position distance (_x select 0) <= _x select 1) exitWith {_validLocation = false};
	}forEach SafeZonePositions;
};

// Check for water
if (_validLocation) then 
{
	if (surfaceIsWater _position) then {_validLocation = false;};
};

// Check for flags
if (_validLocation) then 
{
	if (_avoidTerritory) then {
		_flags = _position nearObjects ["Exile_Construction_Flag_Static", MaxTerritoryRange];
		{
			_distance = (getPosATL _x) distance _position;
			_radius = _x getVariable ["ExileTerritorySize", 0];
			if (_distance <= _radius) exitWith {_validLocation = false};
		}forEach _flags;
	};
};

// Check for players
if (_validLocation) then 
{
	if (count (nearestObjects [_position, ["Exile_Unit_Player"],MinSpawnDistance]) >= 1) then {_validLocation = false};
};

// return
_validLocation;