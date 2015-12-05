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
_trigger setTriggerArea[TriggerRadius, TriggerRadius, 0, true]; 	//this is a sphere
_trigger setTriggerTimeout [ActivationDelay, ActivationDelay, ActivationDelay, false];
_trigger setTriggerActivation["GUER", "PRESENT", TRUE]; 			//Only Exile player can trigger
_trigger setTriggerStatements["this && {isplayer vehicle _x}count thislist > 0", "nul = [thisTrigger] spawn ZombieSpawner;", ""];

if (ShowTriggerOnMap) then {
	_marker = createmarker [format["Zombies-pos-%1,%2",(_position select 0),(_position select 1)], _position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [TriggerRadius, TriggerRadius];
	_marker setMarkerAlpha ZMarkerAlpha;
	_marker setMarkerColor ZMarkerColor;
};

if (PregeneratePos && UseBuildings) then
{
	_positions = [];
	
	//Creates a array of all Houses within TriggerDistance of the trigger position

	if (A2Buildings) then 
	{
		_buildings = nearestObjects[_position,["House"], SpawnRadius];
	}
	else
	{
		_buildings = nearestObjects[_position,["House_F"], SpawnRadius]; 
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
	if (DynamicGroupSize) then{
		_groupSize = round(_posCount / 100 * DynamicRatio);
		
		if (_groupSize > GroupSize) then {
			_groupSize = GroupSize;
		};
		if (_groupSize < MinGroupSize) then {
			_groupSize = MinGroupSize;
		};	
	}
	else
	{
		_groupSize = GroupSize;
	};
	

	//store the variables in the trigger
	_trigger setvariable ["positions", _positions, False];
	_trigger setvariable ["set", True, False];
	_trigger setvariable ["groupSize", _groupSize, False];
	if (Debug) then {
		diag_log format["ExileZ 2.0: Creating Primary Trigger		|	Position : %1 	|	Radius : %2m	|	GroupSize : %3	|	Buildings : %4	|	Spawn Positions : %5	|	Near : %6 ",_position,TriggerRadius,_groupSize,Count _buildings,_posCount,_nearestLocation];
	};
}
else
{	
	if (Debug) then {
		diag_log format["ExileZ 2.0: Creating Primary Trigger		|	Position : %1 	|	Radius : %2m	|	Near : %3 ",_position,TriggerRadius,_nearestLocation];
	};
};