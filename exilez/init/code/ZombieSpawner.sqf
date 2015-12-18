// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //


if (hasInterface) exitwith {}; //exit if is a player

//exit if script is already running
if (_this select 0 getvariable ["active", False]) exitwith {};

//Set the script as active
_this select 0 setvariable ["active", true, False];

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
	"_triggerPosition",
	"_xOffset",
	"_yOffset",
	"_localityChanged",
	"_zClass",
	"_del"
];

//get the variable from the trigger
_set = _this select 0 getvariable ["set", False];
_group = _this select 0 getvariable ["group", objNull];
_positions = _this select 0 getvariable ["positions", []];
_groupSize = _this select 0 getvariable ["groupSize", 0];
_newAct = _this select 0 getvariable ["newAct", True];
_triggerPosition = (getpos (_this select 0));
_nearestLocation = text nearestLocation [_triggerPosition, ""];

// FUNCTIONS ----------------------------------------------------
//Create and Empty group
InitGroup = {
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
Populate = {
	if !(UseBuildings) then 
	{
		//randomize spawn location
		_xOffset = floor random (SpawnRadius);
		_yOffset = floor random (SpawnRadius);
		_xOffset = [_xOffset,(-_xOffset)] call BIS_fnc_selectRandom;
		_yOffset = [_yOffset,(-_yOffset)] call BIS_fnc_selectRandom;
		_position = [((_triggerPosition select 0) + _xOffset),((_triggerPosition select 1) + _yOffset)];
	}
	else
	{
		_position = _positions call BIS_fnc_selectRandom;
	};
	_zClass = PrimaryGroup call GetZombie;
	if (Debug) then {
		diag_log format["ExileZ 2.0: Spawning 1 Primary Zombie	|	Position : %1	|	Class : %2 ",_position,_zClass];
	};
	_zClass createUnit 
	[
		_position,
		_group,
		"
		if !(call PrimaryVest=='') then {this addVest call PrimaryVest};
		if !(call PrimaryLoot=='' && call PrimaryVest=='') then {this addItemToVest call PrimaryLoot};
		this disableConversation true;
		this setbehaviour 'CARELESS';
		this allowFleeing 0;
		this setunitpos 'UP';
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		doStop this;
		"
	];
};


// END of FUNCTIONS ----------------------------------------------------

//if _set is false then set the spawn positions and dynamic group size
if !(_set) then
{
	if (UseBuildings) then {
	
		//Creates a array of all Houses within SpawnRadius of the _triggerPosition
		if (A2Buildings) then 
		{
			_buildings = nearestObjects[_triggerPosition,["House"], SpawnRadius];
		}
		else
		{
			_buildings = nearestObjects[_triggerPosition,["House_F"], SpawnRadius]; 
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
		_this select 0 setvariable ["positions", _positions, False];
		_this select 0 setvariable ["set", True, False];
		_this select 0 setvariable ["groupSize", _groupSize, False];
		if (Debug) then {
			diag_log format["ExileZ 2.0: Setting Primary Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	Buildings : %4	|	Spawn Positions : %5	|	Near : %6 ",_triggerPosition,SpawnRadius,_groupSize,Count _buildings,_posCount,_nearestLocation];
		};
	}
	else
	{	
		_groupSize = GroupSize;
		_this select 0 setvariable ["set", True, False];
		_this select 0 setvariable ["groupSize",_groupSize, False];
		if (Debug) then {
			diag_log format["ExileZ 2.0: Setting Primary Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	Near : %4 ",_triggerPosition,SpawnRadius,_groupSize,_nearestLocation];
		};
	};
};
	
if (Debug) then {
	diag_log format["ExileZ 2.0: Activating Primary Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	Near : %4 ",_triggerPosition,SpawnRadius,_groupSize,_nearestLocation];
};

//Active loop
while {triggeractivated (_this select 0)} do 
{
	if (isNull _group) then 
	{ 															//the zombie group is empty or all dead
		nul = call InitGroup; 									//Create Group
		if (_newAct) then 
		{ 														//if newAct is true The zombies were deleted not killed
			for "_x" from 1 to _groupSize do 
			{													//populate the group "rapidly"
				if (triggeractivated (_this select 0)) then 
				{												//player check
					if (isNull _group) then 
					{ 											//the zombie group is empty or all dead
						nul = call InitGroup;
						sleep 1;
					};
					nul = call Populate;						//Create 1 zombie
				};
				sleep SpawnDelay;								//spawn delay
			};
			_newAct = false;
		} 
		else 													//player probably killed all the zombies without leaving the zone
		{
			nul = call Populate; 								//spawn 1 zombie
			sleep RespawnDelay; 								//Wait respawn time
		};
	}
	else //group is not empty
	{
		_cnt = {alive _x} count units _group; 					//count number of zombie alive in the group
		if (_cnt < _groupSize) then 
		{
			nul = call Populate; 								//Spawn 1 zombie
		};
		sleep RespawnDelay; 									//Wait respawn time
	};
};


//Trigger is no longer active, kill the zombies
sleep DeleteDelay;												//Wait Delete delay
if !(triggeractivated (_this select 0)) then {
	_del = count (units _Group);
	{
		_x setdamage 1;
		deleteVehicle _x;
	} foreach (units _Group);									//Kill all the units in the group and delete the zombies
	_this select 0 setvariable ["newAct", true, False];			//Set the activation state to new to enable fast spawn.
	if (Debug) then {
		diag_log format["ExileZ 2.0: Deactivating Primary Trigger	|	Position : %1	|	Spawn Radius : %2m	|	GroupSize : %3	|	%4	Zombie Deleted	|	Near : %5 ",_triggerPosition,SpawnRadius,_groupSize,_del,_nearestLocation];
	};
};
_this select 0 setvariable ["active", false, False];