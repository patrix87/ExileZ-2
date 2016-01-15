
sleep 1;

diag_log "\\\ --- Starting ExileZ 2.0 --- ///";

//Set Ryanzombies public variables
publicVariable "Ryanzombieshealth";
publicVariable "Ryanzombieshealthdemon";
publicVariable "Ryanzombiesattackspeed";
publicVariable "Ryanzombiesattackdistance";
publicVariable "Ryanzombiesattackstrenth";
publicVariable "Ryanzombiesdamage";
publicVariable "Ryanzombiesdamagecar";
publicVariable "Ryanzombiesdamageair";
publicVariable "Ryanzombiesdamagetank";
publicVariable "Ryanzombiesdamagecarstrenth";
publicVariable "Ryanzombiesdamageairstrenth";
publicVariable "Ryanzombiesdamagetankstrenth";
publicVariable "Ryanzombiescanthrow";
publicVariable "Ryanzombiescanthrowdemon";
publicVariable "Ryanzombiescanthrowtank";
publicVariable "Ryanzombiescanthrowtankdemon";
publicVariable "Ryanzombiescanthrowdistance";
publicVariable "Ryanzombiescanthrowdistancedemon";

//compile code
CreateTriggers = compile preprocessFile "exilez\init\code\CreateTriggers.sqf";
TriggerLoop = compile preprocessFile "exilez\init\code\TriggerLoop.sqf";
HarassingZombiesLoop = compile preprocessFile "exilez\init\code\HarassingZombiesLoop.sqf";
InitGroup = compile preprocessFile "exilez\init\code\InitGroup.sqf";
SpawnZombie = compile preprocessFile "exilez\init\code\SpawnZombie.sqf";
ZMPKilled = compile preprocessFile "exilez\init\code\MPKilled.sqf";
Safezone = compile preprocessFile "exilez\init\code\Safezone.sqf";
GetRandomLocation = compile preprocessFile "exilez\init\code\GetRandomLocation.sqf";
SpawnZombie = compile preprocessFile "exilez\init\code\SpawnZombie.sqf";
VerifyLocation = compile preprocessFile "exilez\init\code\VerifyLocation.sqf";
HordeLoop = compile preprocessFile "exilez\init\code\HordeLoop.sqf";
ZombieDeleter = compile preprocessFile "exilez\init\code\ZombieDeleter.sqf";

//Exile vars
MaxTerritoryRange = getNumber (missionConfigFile >> "CfgTerritories" >> "maximumRadius");

//Create Triggers
if (UseTriggers) then
{
	{
		_useThisTrigger = _x select 0;
		_triggerPositions = _x select 1;
		if (_useThisTrigger) then {
		
			//Weight Zombie Group
			_currentTrigger = _x;
			_zgroup = _currentTrigger select 13;
			_count = 0;
			{
				_count = _count + (_x select 1);
				(_zgroup select _forEachIndex) set [1,_count];
			}foreach (_zgroup);
			
			//Create triggers
			{nul = [_x,_CurrentTrigger] spawn CreateTriggers;
				sleep 0.01;
			}foreach (_triggerPositions);
		};
	}foreach Triggers;
};

//Create Triggers for safezones
{nul = [_x] spawn Safezone;
	sleep 0.01;
}foreach SafeZonePositions;


//Enable the HarassingZombies
if (UseHarassingZombies) then {
	nul = [HSet] spawn HarassingZombiesLoop;
};


//Enable the Horde
if (UseHorde) then {
	nul = [HordeSet] spawn HordeLoop;
};



sleep 1;

diag_log "/// --- ExileZ 2.0 Started --- \\\";
