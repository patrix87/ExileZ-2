// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

diag_log "ExileZ 2.0: Creating Triggers";

//if Not player, not server, not headless then exit
if(!hasInterface && !isServer && name player != HCName) exitwith {}; 

//Variable declaration
private [
"_position",
"_trigger"
];


//Current spawner position
_position = _this select 0;


//Validate current spawner position
if (isnil "_position") exitwith { hint "EXILE-Z: empty position";};
if (count _position < 1) exitwith { hint "EXILE-Z: required a position ARRAY";};
if (surfaceiswater _position) exitwith { hint "EXILE-Z: position is in the water";};

//Create trigger area
_trigger = createTrigger["EmptyDetector", _position];
_trigger setTriggerArea[TriggerRadius, TriggerRadius, 0, true]; 	//this is a sphere
_trigger setTriggerActivation["GUER", "PRESENT", TRUE]; 			//Only Exile player can trigger
_trigger setTriggerStatements["this", "nul = [thisTrigger] spawn ZombieSpawner;", ""];

