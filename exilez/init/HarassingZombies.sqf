// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

if (hasInterface) exitwith {}; //exit if is a player


sleep 120; //Wait 2 minutes for the server to boot
//Inifite Harassing Loop
while {true} do {
	{
		if (isPlayer _x) then 
		{ 
			if (alive _x) then 
			{ 
				nul = [_x] spawn HarassingZombiesSpawn;
			};
		};
		sleep 1;	//pause between player to avoid load on server
	} forEach (allPlayers - entities "HeadlessClient_F");
	sleep HZFrequency;	//pause between spawn
};







