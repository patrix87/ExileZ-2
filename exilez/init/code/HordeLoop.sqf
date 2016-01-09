// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

private ["_nPlayer","_sTime","_group","_count","_groupSize","_frequency","_maxDistance","_minSpawnDistance","_maxSpawnDistance","_vestGroup","_lootGroup","_zombieGroup","_avoidTerritory","_playerObj","_playerName","_playerPosition"];


_groupSize =         _this select 0;
_minFrequency =      _this select 1;
_maxFrequency =      _this select 2;
_maxDistance =       _this select 3;
_minSpawnDistance =  _this select 4;
_maxSpawnDistance =  _this select 5;
_vestGroup =         _this select 6;
_lootGroup =         _this select 7;
_zombieGroup =       _this select 8;
_avoidTerritory =    _this select 9;

sleep 120; //Wait 2 minutes for the server to boot

//Horde Loop
while {true} do 
{
	//wait sleep time
	_sleepTime = (_minFrequency + (ceil random (_maxFrequency - _minFrequency)))*60
	if (Debug) then {
		diag_log format["ExileZ 2.0: Horde waiting %1 seconds.",_sleeptime];
	};
	sleep _sleeptime;
	
	//count players in game
	_nPlayer = count (allPlayers - entities "HeadlessClient_F");
	if (_nPlayer >= 1) then 
	{
	
		//create player list
		_playerObjs = allPlayers - entities "HeadlessClient_F";
		
		//try to pick a lucky winner with a possible valid location
		for "_i" from 1 to _nPlayer do 
		{
			_playerObj = _playerObjs BIS_fnc_selectRandom;
			//if player is valid try to find a valid location 5 times
			if (isPlayer _playerObj && alive _playerObj) then 
			{
				for "_i" from 1 to 5 do 
				{
					_position = [_playerPosition,_minSpawnDistance,_maxSpawnDistance] call GetRandomLocation;
					//Validate location
					_validLocation = [_position,_avoidTerritory] call VerifyLocation;
					if (_validLocation) exitWith {_validLocation};
					sleep 0.05;
				};
			if (_validLocation) exitWith {_playerObj};
			};
			_playerObj = nil;
			sleep 0.05;
		};
		
		//if _playerObj is not null spawn the horde
		if !(isnull _playerObj) then 
		{ 
			_playerName = name _playerObj;
			_playerPosition = getPos _playerObj;
			
			//get group from player
			_group = _playerObj getvariable ["group", objNull];
			
			//if nul create group
			if (isNull _group) then 
			{
				_group = [_playerObj] call InitGroup;
				sleep 1;
			};

			//Spawn the horde

			if (Debug) then 
			{
				diag_log format["ExileZ 2.0: Spawning Horde near %1.",_playerObjName];
			};
			for "_i" from 1 to _groupSize do 
			{
				_zombie = [_group,_position,_minSpawnDistance,_maxSpawnDistance,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,nil] spawn SpawnZombie;
				nul = [_zombie,_maxDistance] spawn HordeZombieDeleter;
				sleep 1;
			};
		}
		else
		{
			if (Debug) then {
				diag_log "ExileZ 2.0: No valid player found for the Horde";
			};
		};
	};
};







