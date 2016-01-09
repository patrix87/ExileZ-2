// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

private ["_nPlayer","_sTime","_group","_count","_groupSize","_frequency","_maxDistance","_minSpawnDistance","_maxSpawnDistance","_vestGroup","_lootGroup","_zombieGroup","_avoidTerritory","_playerObj","_playerName","_playerPosition"];


_groupSize =         _this select 0;
_frequency =         _this select 1;
_maxDistance =       _this select 2;
_minSpawnDistance =  _this select 3;
_maxSpawnDistance =  _this select 4;
_vestGroup =         _this select 5;
_lootGroup =         _this select 6;
_zombieGroup =       _this select 7;
_avoidTerritory =    _this select 8;

sleep 120; //Wait 2 minutes for the server to boot

//Infinite Harassing Loop
while {true} do 
{
	{
		if (isPlayer _x) then 
		{ 
			if (alive _x) then 
			{	
				_playerObj = _x;
				_playerName = name _x;
				_playerPosition = getPos _x;
				
				//get group from player
				_group = _playerObj getvariable ["group", objNull];
				
				//if nul create group
				if (isNull _group) then 
				{
					_group = [_playerObj] call InitGroup;
					sleep 1;
				};
				
				//delete zombies that are too far away from any players
				{
					if ((count (nearestObjects [getpos _x, ["Exile_Unit_Player"],_maxDistance]) == 0)) then {
						_x setdamage 1;
						deleteVehicle _x;
						if (Debug) then {
							diag_log format["ExileZ 2.0: Deleting 1 Zombie	|	Position : %1	|	Class : %2	|	From Player : %3 ",getpos _x,typeOf _x,_playerName];
						};
					};
				} foreach (units _Group);
				
				//count number of zombie alive in the group
				_count = {alive _x} count units _group; 	
				
				//Spawn 1 zombie if count is low enough
				if (_count < _groupSize) then 
				{
					nul = [_group,_playerPosition,_minSpawnDistance,_maxSpawnDistance,_vestGroup,_lootGroup,_zombieGroup,_avoidTerritory,nil] spawn SpawnZombie;
					if (Debug) then {
						diag_log format["ExileZ 2.0: Spawning 1 Zombie for %1.",_playerName];
					};
				};
			};
		};
		
		//number of real player
		_nPlayer = count (allPlayers - entities "HeadlessClient_F");
		if (Debug) then {
			diag_log format["ExileZ 2.0: %1 Player in game.",_nPlayer];
		};
		
		//pause between spawn
		if (_nPlayer < 1) then // to avoid division by 0
		{
			if (Debug) then {
				diag_log format["ExileZ 2.0: Waiting %1 seconds.",_frequency];
			};
			sleep _frequency;
		}
		else
		{
			_sTime = round (_frequency / _nPlayer);
			if (Debug) then {
				diag_log format["ExileZ 2.0: Waiting %1 seconds.",_sTime];
			};
			sleep _sTime;
		};
		
	} forEach (allPlayers - entities "HeadlessClient_F");
	
	sleep 0.1;
};







