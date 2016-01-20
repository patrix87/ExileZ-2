
sleep 1;

diag_log "\\\ --- Starting ExileZ 2.0 --- ///";

//Set Ryanzombies public variables

if (_Ryanzombieshealth > 0) then 
{
	Ryanzombieshealth = _Ryanzombieshealth;
	publicVariable "Ryanzombieshealth";
};

if (_Ryanzombieshealthdemon > 0) then 
{
	Ryanzombieshealthdemon = _Ryanzombieshealthdemon;
	publicVariable "Ryanzombieshealthdemon";
};

if (_Ryanzombiesattackspeed > 0) then 
{
	Ryanzombiesattackspeed = _Ryanzombiesattackspeed;
	publicVariable "Ryanzombiesattackspeed";
};

if (_Ryanzombiesattackdistance > 0) then 
{
	Ryanzombiesattackdistance = _Ryanzombiesattackdistance;
	publicVariable "Ryanzombiesattackdistance";
};

if (_Ryanzombiesattackstrenth > 0) then 
{
	Ryanzombiesattackstrenth = _Ryanzombiesattackstrenth;
	publicVariable "Ryanzombiesattackstrenth";
};

if (_Ryanzombiesdamage > 0) then 
{
	Ryanzombiesdamage = _Ryanzombiesdamage;
	publicVariable "Ryanzombiesdamage";
};

if (_Ryanzombiesdamagecar > 0) then 
{
	Ryanzombiesdamagecar = _Ryanzombiesdamagecar;
	publicVariable "Ryanzombiesdamagecar";
};

if (_Ryanzombiesdamageair > 0) then 
{
	Ryanzombiesdamageair = _Ryanzombiesdamageair;
	publicVariable "Ryanzombiesdamageair";
};

if (_Ryanzombiesdamagetank > 0) then 
{
	Ryanzombiesdamagetank = _Ryanzombiesdamagetank;
	publicVariable "Ryanzombiesdamagetank";
};

if (_Ryanzombiesdamagecarstrenth > 0) then 
{
	Ryanzombiesdamagecarstrenth = _Ryanzombiesdamagecarstrenth;
	publicVariable "Ryanzombiesdamagecarstrenth";
};

if (_Ryanzombiesdamageairstrenth > 0) then 
{
	Ryanzombiesdamageairstrenth = _Ryanzombiesdamageairstrenth;
	publicVariable "Ryanzombiesdamageairstrenth";
};

if (_Ryanzombiesdamagetankstrenth > 0) then 
{
	Ryanzombiesdamagetankstrenth = _Ryanzombiesdamagetankstrenth;
	publicVariable "Ryanzombiesdamagetankstrenth";
};

if (_Ryanzombiescanthrow > 0) then 
{
	Ryanzombiescanthrow = _Ryanzombiescanthrow;
	publicVariable "Ryanzombiescanthrow";
};

if (_Ryanzombiescanthrowtank > 0) then 
{
	Ryanzombiescanthrowtank = _Ryanzombiescanthrowtank;
	publicVariable "Ryanzombiescanthrowtank";
};

if (_Ryanzombiescanthrowdistance > 0) then 
{
	Ryanzombiescanthrowdistance = _Ryanzombiescanthrowdistance;
	publicVariable "Ryanzombiescanthrowdistance";
};

if (_Ryanzombiescanthrowdemon > 0) then 
{
	Ryanzombiescanthrowdemon = _Ryanzombiescanthrowdemon;
	publicVariable "Ryanzombiescanthrowdemon";
};


if (_Ryanzombiescanthrowtankdemon > 0) then 
{
	Ryanzombiescanthrowtankdemon = _Ryanzombiescanthrowtankdemon;
	publicVariable "Ryanzombiescanthrowtankdemon";
};

if (_Ryanzombiescanthrowdistancedemon > 0) then 
{
	Ryanzombiescanthrowdistancedemon = _Ryanzombiescanthrowdistancedemon;
	publicVariable "Ryanzombiescanthrowdistancedemon";
};

if (_ryanzombiesdisablemoaning > 0) then 
{
	ryanzombiesdisablemoaning = _ryanzombiesdisablemoaning;
	publicVariable "ryanzombiesdisablemoaning";
};

if (_ryanzombiesdisableaggressive > 0) then 
{
	ryanzombiesdisableaggressive = _ryanzombiesdisableaggressive;
	publicVariable "ryanzombiesdisableaggressive";
};

if (_ryanzombiescivilianattacks > 0) then 
{
	ryanzombiescivilianattacks = _ryanzombiescivilianattacks;
	publicVariable "ryanzombiescivilianattacks";
};

if (_Ryanzombieslogicroam > 0) then 
{
	Ryanzombieslogicroam = _Ryanzombieslogicroam;
	publicVariable "Ryanzombieslogicroam";
};

if (_Ryanzombieslogicroamdemon > 0) then 
{
	Ryanzombieslogicroamdemon = _Ryanzombieslogicroamdemon;
	publicVariable "Ryanzombieslogicroamdemon";
};


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
