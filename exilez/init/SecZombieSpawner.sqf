// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //


if (hasInterface) exitwith {}; //exit if is a player

//exit if script is already running
if (_this select 0 getvariable ["active", False]) exitwith {};

//Set the script as active
_this select 0 setvariable ["active", true, False];

diag_log "ExileZ 2.0: Secondary Zombie Spawner Activated";

private [
    "_set",
    "_buildings",
    "_positions",
    "_posCount",
    "_group",
    "_index",
	"_cnt",
	"_groupSize",
	"_newAct",
	"_position",
	"_xOffset",
	"_yOffset",
	"_localityChanged"
];

//get the variable from the trigger
_set = _this select 0 getvariable ["set", False];
_group = _this select 0 getvariable ["group", objNull];
_positions = _this select 0 getvariable ["positions", []];
_groupSize = _this select 0 getvariable ["groupSize", 0];
_newAct = _this select 0 getvariable ["newAct", True];



// FUNCTIONS ----------------------------------------------------
//Create and Empty group
SecInitGroup = {
	//Create a group for the zombies
	_group = creategroup ZombieSide;
	_group setcombatmode "RED";
	_group allowfleeing 0;
	_group setspeedmode "limited";
	_this select 0 setvariable ["group", _group, False];
	if (UseHC) then {
		//_localityChanged = _group setGroupOwner (owner HC); //transfer group to HC
	};
};

//Populate the group
SecPopulate = {
	if !(SecUseBuildings) then 
	{
		//randomize spawn location
		_position = (getpos (_this select 0));
		_xOffset = floor random (SecSpawnRadius);
		_yOffset = floor random (SecSpawnRadius);
		_xOffset = [_xOffset,(-_xOffset)] call BIS_fnc_selectRandom;
		_yOffset = [_yOffset,(-_yOffset)] call BIS_fnc_selectRandom;
		_position = [((_position select 0) + _xOffset),((_position select 1) + _yOffset)];
	}
	else
	{
		_position = _positions call BIS_fnc_selectRandom;
	};
	(SecZombieClasses call BIS_fnc_selectRandom) createUnit 
	[
		_position,
		_group,
		"
		this addVest (SeczVest call BIS_fnc_selectRandom);
		this addItemToVest (SeczLoot call BIS_fnc_selectRandom);
		this disableConversation true;
		this setbehaviour 'CARELESS';
		this allowFleeing 0;
		this setunitpos 'UP';
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		"
	];
};


// END of FUNCTIONS ----------------------------------------------------

//if _set is false then set the spawn positions and dynamic group size
if !(_set) then
{
	//Creates a array of all Houses within zTriggerDistance of the _triggerPosition
	if (A2Buildings) then 
	{
		_buildings = nearestObjects[(getpos (_this select 0)),["House"], SecSpawnRadius];
	}
	else
	{
		_buildings = nearestObjects[(getpos (_this select 0)),["House_F"], SecSpawnRadius]; 
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
	
	diag_log format["ExileZ 2.0: %1 buildings found.",Count _buildings];
	diag_log format["ExileZ 2.0: %1 spawn position found.",_posCount];
	
	//set GroupSize
	if (SecDynamicGroupSize) then{
		_groupSize = round(_posCount / 100 * SecDynamicRatio);
		
		if (_groupSize > SecGroupSize) then {
			_groupSize = SecGroupSize;
			diag_log format["ExileZ 2.0: Dynamic Group Size is higher than limit. %1",SecGroupSize];
		};
				
		if (_groupSize < SecMinGroupSize) then {
			_groupSize = SecMinGroupSize;
			diag_log format["ExileZ 2.0: Dynamic Group Size is lower than the limit of %1.",SecMinGroupSize];
		};
		
		diag_log format["ExileZ 2.0: Dynamic Group Size set to %1.",_groupSize];
		
	}
	else
	{
		_groupSize = SecGroupSize;
	};
	

	//store the variables in the trigger
	_this select 0 setvariable ["positions", _positions, False];
	_this select 0 setvariable ["set", True, False];
	_this select 0 setvariable ["groupSize", _groupSize, False];
};

//Active loop
while {triggeractivated (_this select 0)} do {
	if (isNull _group) then { 						//the zombie group is empty or all dead
		nul = call SecInitGroup; 						//Create Group
		if (_newAct) then { 						//if newAct is true The zombies were deleted not killed
			for "_x" from 1 to _groupSize do {					//populate the group "rapidly"
				if (triggeractivated (_this select 0)) then {	//player check
					nul = call SecPopulate;						//Create 1 zombie
				};
				sleep SecSpawnDelay;					//spawn delay
			};
			_newAct = false;
		} 
		else 										//player probably killed all the zombies without leaving the zone
		{
			nul = call SecPopulate; 					//spawn 1 zombie
			sleep SecRespawnDelay; 					//Wait respawn time
		};
	}
	else //group is not empty
	{
		_cnt = {alive _x} count units _group; 		//count number of zombie alive in the group
		if (_cnt < _groupSize) then {
			nul = call SecPopulate; 					//Spawn 1 zombie
		};
		sleep SecRespawnDelay; 						//Wait respawn time
	};
};


//Trigger is no longer active, kill the zombies
sleep SecDeleteDelay;									//Wait Delete delay
if !(triggeractivated (_this select 0)) then {
	{
		_x setdamage 1;
		deleteVehicle _x;
	} foreach (units _Group);								//Kill all the units in the group and delete the zombies
	_this select 0 setvariable ["newAct", true, False];		//Set the activation state to new to enable fast spawn.
	diag_log "ExileZ 2.0: Deleting Sec Zombies";
};
_this select 0 setvariable ["active", false, False];