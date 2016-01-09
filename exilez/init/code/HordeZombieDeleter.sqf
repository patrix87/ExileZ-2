// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //


private ["_zombie","_maxDistance","_zombiePos","_zombieClass"];

_zombie = _this select 0;
_maxDistance = _this select 1;
_zombiePos = getPos _zombie;
_zombieClass = typeOf _zombie;

sleep 60;
if ((count (nearestObjects [_zombiePos, ["Exile_Unit_Player"],_maxDistance]) == 0)) then {
	_zombie setdamage 1;
	deleteVehicle _zombie;
	if (Debug) then {
		diag_log format["ExileZ 2.0: Deleting 1 Zombie	|	Position : %1	|	Class : %2",_zombiePos,_zombieClass];
	};
};
