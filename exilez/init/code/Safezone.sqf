// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

//Variable declaration
private [
	"_position",
	"_trigger",
	"_nearestLocation",
	"_radius"
];


_position = (_this select 0) select 0;
_radius = (_this select 0) select 1;
_nearestLocation = text nearestLocation [_position, ""];

//Validate current trigger position
if (isnil "_position") exitwith { Diag_log "ExileZ 2.0:: Empty position";};
if (count _position < 1) exitwith { Diag_log "ExileZ 2.0: Require a position ARRAY";};
if (surfaceiswater _position) exitwith { Diag_log "ExileZ 2.0: Position is in the water";};

//Create trigger area
_trigger = createTrigger["EmptyDetector", _position];
_trigger setTriggerArea[_radius, _radius, 0, true];
_trigger setTriggerActivation[ZombieSideString, "PRESENT", TRUE];
_trigger setTriggerStatements["this && {vehicle _x isKindOf 'Man'} count thislist > 0", "{if (_x isKindOf 'Man') then {_x setdamage 1; deleteVehicle _x;}; }foreach thislist;", ""];

if (Debug) then {
	diag_log format["ExileZ 2.0: Creating Safezone Trigger		|	Position : %1 	|	Radius : %2m	|	Near : %3 ",_position,_radius,_nearestLocation];
};