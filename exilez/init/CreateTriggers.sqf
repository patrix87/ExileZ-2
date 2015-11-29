// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

//Variable declaration
private [
"_position",
"_trigger"
];


//Current spawner position
_position = _this select 0;

diag_log format["ExileZ 2.0: Creating Trigger at %1 for radius of %2 m.",_position,TriggerRadius];

//Validate current spawner position
if (isnil "_position") exitwith { hint "EXILE-Z: empty position";};
if (count _position < 1) exitwith { hint "EXILE-Z: required a position ARRAY";};
if (surfaceiswater _position) exitwith { hint "EXILE-Z: position is in the water";};

//Create trigger area
_trigger = createTrigger["EmptyDetector", _position];
_trigger setTriggerArea[TriggerRadius, TriggerRadius, 0, true]; 	//this is a sphere
_trigger setTriggerActivation["GUER", "PRESENT", TRUE]; 			//Only Exile player can trigger
_trigger setTriggerStatements["this && {isplayer vehicle _x}count thislist > 0", "nul = [thisTrigger] spawn ZombieSpawner;", ""];

if (ShowTriggerOnMap) then {
	_marker = createmarker [format["Zombies-pos-%1,%2",(_position select 0),(_position select 1)], _position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [TriggerRadius, TriggerRadius];
	_marker setMarkerAlpha ZMarkerAlpha;
	_marker setMarkerColor ZMarkerColor;
};