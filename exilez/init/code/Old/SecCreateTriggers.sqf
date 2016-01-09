// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

//Variable declaration
private [
	"_position",
	"_trigger",
    "_buildings",
    "_positions",
    "_posCount",
    "_index",
	"_nearestLocation",
	"_groupSize"
];

//Current spawner position
_position = _this select 0;
_nearestLocation = text nearestLocation [_position, ""];

//Validate current spawner position
if (isnil "_position") exitwith { Diag_log "ExileZ 2.0:: Empty position";};
if (count _position < 1) exitwith { Diag_log "ExileZ 2.0: Require a position ARRAY";};
if (surfaceiswater _position) exitwith { Diag_log "ExileZ 2.0: Position is in the water";};

//Create trigger area
_trigger = createTrigger["EmptyDetector", _position];
_trigger setTriggerArea[SecTriggerRadius, SecTriggerRadius, 0, true]; 	//this is a sphere
_trigger setTriggerTimeout [SecActivationDelay, SecActivationDelay, SecActivationDelay, false];
_trigger setTriggerActivation["GUER", "PRESENT", TRUE]; 			//Only Exile player can trigger
_trigger setTriggerStatements["this && {isplayer vehicle _x}count thislist > 0", "nul = [thisTrigger] spawn SecZombieSpawner;", ""];

if (SecShowTriggerOnMap) then {
	_marker = createmarker [format["Zombies-pos-%1,%2",(_position select 0),(_position select 1)], _position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [SecTriggerRadius, SecTriggerRadius];
	_marker setMarkerAlpha SecZMarkerAlpha;
	_marker setMarkerColor SecZMarkerColor;
};

if (PregeneratePos && SecUseBuildings) then
{
	_positions = [];
	
	//Creates a array of all Houses within TriggerDistance of the trigger position

	if (A2Buildings) then 
	{
		_buildings = nearestObjects[_position,["House"], SecSpawnRadius];
	}
	else
	{
		_buildings = nearestObjects[_position,["House_F"], SecSpawnRadius]; 
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
	if (SecDynamicGroupSize) then{
		_groupSize = round(_posCount / 100 * SecDynamicRatio);
		
		if (_groupSize > SecGroupSize) then {
			_groupSize = SecGroupSize;
		};
		if (_groupSize < SecMinGroupSize) then {
			_groupSize = SecMinGroupSize;
		};	
	}
	else
	{
		_groupSize = SecGroupSize;
	};
	

	//store the variables in the trigger
	_trigger setvariable ["positions", _positions, False];
	_trigger setvariable ["set", True, False];
	_trigger setvariable ["groupSize", _groupSize, False];
	if (Debug) then {
		diag_log format["ExileZ 2.0: Creating Secondary Trigger	|	Position : %1	|	Radius : %2m	|	GroupSize : %3	|	Buildings : %4	|	Spawn Positions : %5	|	Near : %6 ",_position,SecTriggerRadius,_groupSize,Count _buildings,_posCount,_nearestLocation];
	};
}
else
{	
	if (Debug) then {
		diag_log format["ExileZ 2.0: Creating Secondary Trigger	|	Position : %1	|	Radius : %2m	|	Near : %3 ",_position,SecTriggerRadius,_nearestLocation];
	};
};