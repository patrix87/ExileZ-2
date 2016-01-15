// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

// Verify validity of spawning location

//_validLocation = [_triggerPosition,_avoidTerritory,false] call VerifyLocation;

// Return True if valid
private ["_flags","_avoidTerritory","_validLocation","_distance","_radius","_position","_ignorePlayer"];

_ignorePlayer = false;

_position = _this select 0;
_avoidTerritory = _this select 1;
if (count _this == 3) then {
	_ignorePlayer = _this select 2;
};

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

// Check for players too close
if (_validLocation && !_ignorePlayer) then 
{
	if ({isplayer _x} count (_position nearEntities MinSpawnDistance) == 1) then {_validLocation = false};
};

// Check for absence of players near
if (_validLocation && !_ignorePlayer) then 
{
	if ({isplayer _x} count (_position nearEntities MaxSpawnDistance) == 0) then {_validLocation = false};
};


// return
_validLocation;