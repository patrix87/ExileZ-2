// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

private ["_nPlayer","_group","_groupSize","_vestGroup","_lootGroup","_zombieGroup","_avoidTerritory","_playerObj","_playerName","_playerPosition","_position","_validLocation","_playerObjs","_sleepTime","_minFrequency","_maxFrequency","_hordeDensity"];


_groupSize =         (_this select 0) select 0;
_minFrequency =      (_this select 0) select 1;
_maxFrequency =      (_this select 0) select 2;
_vestGroup =         (_this select 0) select 3;
_lootGroup =         (_this select 0) select 4;
_zombieGroup =       (_this select 0) select 5;
_avoidTerritory =    (_this select 0) select 6;
_hordeDensity =      (_this select 0) select 7;

sleep 10; //Wait 2 minutes for the server to boot

//Horde Loop
while {true} do 
{
	//wait sleep time
	_sleepTime = (_minFrequency + (ceil random (_maxFrequency - _minFrequency)))*60;
	if (Debug) then {
		diag_log format["ExileZ 2.0: Next Horde in %1 minutes.",_sleeptime/60];
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
			_playerObj = _playerObjs call BIS_fnc_selectRandom;
			//Check if player is in a valid location
			_playerPosition = getPos _playerObj;
			_validLocation = [_playerPosition,_avoidTerritory] call VerifyLocation;
			//if player is valid try to find a valid location 5 times
			if (isPlayer _playerObj && alive _playerObj && _validLocation) then 
			{
				for "_i" from 1 to 5 do 
				{
                    _playerPosition = getPos _playerObj;
					_position = [_playerPosition,(MinSpawnDistance+_hordeDensity),(MaxSpawnDistance+_hordeDensity)] call GetRandomLocation;
					//Validate location
					_validLocation = [_position,_avoidTerritory] call VerifyLocation;
					if (_validLocation) exitWith {_validLocation};
					sleep 0.05;
				};
			};
			if (_validLocation) exitWith {_playerObj};
			_playerObj = ObjNull;
			sleep 0.05;
		};
		
		//if _playerObj is not null spawn the horde
		if !(isnull _playerObj) then 
		{ 
			_playerName = name _playerObj;
			
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
				diag_log format["ExileZ 2.0: Spawning Horde near %1.",_playerName];
			};
			for "_i" from 1 to _groupSize do 
			{
				nul = [_group,_position,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,_hordeDensity] spawn SpawnZombie;
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