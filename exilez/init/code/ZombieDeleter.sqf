// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

private ["_zombie","_zombiePos","_zombieClass","_distanceDeath"];

_zombie = _this select 0;
_zombieClass = typeOf _zombie;
_distanceDeath = false;

while {alive _zombie} do {
	sleep MaxTime;
	_zombiePos = getPos _zombie;
	if ((count (nearestObjects [_zombiePos, ["Exile_Unit_Player"],MaxDistance]) == 0) && alive _zombie) then {
		_zombie setdamage 1;
		sleep 5;
		deleteVehicle _zombie;
		_distanceDeath = true;
	};

};

if !(_distanceDeath) then 
{
	sleep CorpseDeleteDelay;
	deleteVehicle _zombie;
};

if (Debug) then {
	diag_log format["ExileZ 2.0: Removing 1 Zombie	|	Position : %1	|	Class : %2",_zombiePos,_zombieClass];
};
