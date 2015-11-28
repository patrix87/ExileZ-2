// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

diag_log "ExileZ 2.0: Creating Safezones";

if (hasInterface) exitwith {}; //exit if is a player

//Variable declaration
private [
"_position",
"_trigger",
"_radius"
];


_position = (_this select 0) select 0;
_radius = (_this select 0) select 1;


//Validate current trigger position
if (isnil "_position") exitwith { hint "EXILE-Z: empty position";};
if (count _position < 1) exitwith { hint "EXILE-Z: required a position ARRAY";};
if (surfaceiswater _position) exitwith { hint "EXILE-Z: position is in the water";};

//Create trigger area
_trigger = createTrigger["EmptyDetector", _position];
_trigger setTriggerArea[_radius, _radius, 0, true];
_trigger setTriggerActivation["CIV", "PRESENT", TRUE]; //Apparently zombies are always CIV...
_trigger setTriggerStatements["this", "{_x setdamage 1}foreach thislist;", ""];

