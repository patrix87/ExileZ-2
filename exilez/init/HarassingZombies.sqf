// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player

private [
    "_nPlayer",
	"_sTime"
];


sleep 120; //Wait 2 minutes for the server to boot
//Infinite Harassing Loop
while {true} do {
	{
		if (isPlayer _x) then 
		{ 
			if (alive _x) then 
			{ 
				nul = [_x] spawn HarassingZombiesSpawn;
			};
		};
		//number of real player
		_nPlayer = count (allPlayers - entities "HeadlessClient_F");
		
		diag_log format["ExileZ 2.0: %1 Player in game.",_nPlayer];
		
		//pause between spawn
		if (_nPlayer < 1) then // to avoid division by 0
		{
			diag_log format["ExileZ 2.0: Waiting %1 seconds.",HZFrequency];
			sleep HZFrequency;
		}
		else
		{
			_sTime = round (HZFrequency / _nPlayer);
			diag_log format["ExileZ 2.0: Waiting %1 seconds.",_sTime];
			sleep _sTime;
		};
	} forEach (allPlayers - entities "HeadlessClient_F");
	sleep 0.1;
};







