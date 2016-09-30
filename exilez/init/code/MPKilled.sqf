// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //
// Original script by eraser1 and IT07 //
 
private [
"_unit",
"_killer",
"_playerObj",
"_veh",
"_killMsg",
"_killMsgRoad",
"_roadKilled",
"_respect",
"_respectChange",
"_roadKillBonus",
"_money",
"_zombieMoney",
"_zombieRespect",
"_distanceBonusDivider",
"_minDistance",
"_cqbDistance",
"_cqbBonus",
"_distance",
"_killerRespectPoints",
"_safetoblow",
"_explode"
];

_unit           		= _this select 0;
_killer         		= _this select 1;
_playerObj      		= objNull;
_roadKilled    			= false;
_respectChange  		= 0;
_killerRespectPoints 	= [];
_safetoblow				= true;
_explode				= false;

//Parameters
_zombieMoney			= ZombieMoney;				//default = 5;	// Money per zombie kill
_zombieRespect			= ZombieRespect;			//default = 10;	// Respect per zombie kill
_roadKillBonus			= RoadKillBonus;			//default = -5;	// Bonus Respect if roadkill
_minDistance			= MinDistance;				//default = 50;	// Minimal distance for range bonus
_cqbDistance			= CqbDistance;				//default = 10;	// Minimal ditance for close quarter bonus
_cqbBonus				= CqbBonus;					//default = 40;	// Respect for close quarter bonus at 1 meter
_distanceBonusDivider 	= DistanceBonusDivider;		//default = 10;	// Distance divided by that number = respect E.G. 300m / [20] = 15 Respect
//
_maxMoneyOnZed			= ZombieMaxMoney;		//default = 15; // Max Money per zombie kill will be random

_killMsg = ["ZOMBIE WACKED","ZOMBIE CLIPPED","ZOMBIE DISABLED","ZOMBIE DISQUALIFIED","ZOMBIE WIPED","ZOMBIE WIPED","ZOMBIE ERASED","ZOMBIE LYNCHED","ZOMBIE WRECKED","ZOMBIE NEUTRALIZED","ZOMBIE SNUFFED","ZOMBIE WASTED","ZOMBIE ZAPPED"] call BIS_fnc_selectRandom;
_killMsgRoad = ["ZOMBIE ROADKILL","ZOMBIE SMASHED","ERMAHGERD ROADKILL"] call BIS_fnc_selectRandom;

if(ExplosiveZombies) then 
{
	if (ExplosiveZombiesRatio > random 100) then
	{	
		_killerRespectPoints pushBack [(format ["%1",ExplosiveZombieWarning]), ExplosiveRespect];
		_explode = true;
	};
};


//Roadkill or not
if (isPlayer _killer) then
{
	_veh = vehicle _killer;
	_playerObj = _killer;
	if (!(_killer isKindOf "Exile_Unit_Player") && {!isNull (gunner _killer)}) then
	{
			_playerObj = gunner _killer;
	};

	if (!(_veh isEqualTo _killer) && {(driver _veh) isEqualTo _killer}) then
	{
			_playerObj = driver _veh;
			_roadKilled = true;
	};
};

_respect = _playerObj getVariable ["ExileScore", 0];
_money = _playerObj getVariable ["ExileMoney", 0];

//Scoring
if ((!isNull _playerObj) && {((getPlayerUID _playerObj) != "") && {_playerObj isKindOf "Exile_Unit_Player"}}) then
{
	//Default
	_killerRespectPoints pushBack [(format ["%1",_killMsg]), _zombieRespect];
	//RoadkillBonus
	if (_roadKilled) then
	{
		_killerRespectPoints pushBack [(format ["%1",_killMsgRoad]), _roadKillBonus];
	}
	else
	//DistanceBonus
	{
		_distance = _unit distance _playerObj;
		if (_distance > _minDistance) then
		{
			_distanceBonus = (floor (_distance / _distanceBonusDivider));
			_killerRespectPoints pushBack [(format ["%1m RANGE BONUS", (round _distance)]), _distanceBonus];			
		};
		if (_distance <= _cqbDistance) then
		{
			_distanceBonus = round((floor ((_cqbDistance + 1) - _distance)) * ( _cqbBonus /_cqbDistance));
			_killerRespectPoints pushBack [(format ["%1m CQB BONUS", (round _distance)]), _distanceBonus];
		};
	};
	
	// Calculate killer's respect and money
	{
		_respectChange = (_respectChange + (_x select 1));
	}
	forEach _killerRespectPoints;
	_respect = (_respect + _respectChange);
	_money = (_money + _zombieMoney);
	
	if (EnableMoneyOnPlayer) then 
	{
		[_playerObj, "moneyReceivedRequest", [str _money, "Killing Zombies"]] call ExileServer_system_network_send_to;
		_playerObj setVariable ["ExileMoney", _money];
	};
	
	if (EnableMoneyOnCorpse) then 
	{
		_unit setVariable ["ExileMoney",random(_maxMoneyOnZed),true];
	};
	
	if (EnableRespectOnKill) then
	{
		[_playerObj, "showFragRequest", [_killerRespectPoints]] call ExileServer_system_network_send_to;
		_playerObj setVariable ["ExileScore", _respect];
		ExileClientPlayerScore = _respect;
		format["setAccountScore:%1:%2", _respect, (getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;
		(owner _playerObj) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	};
	
	if (EnableZombieStatKill) then
	{
		_newKillerFrags = _killer getVariable ["ExileZedKills", 0];
		_newKillerFrags = _newKillerFrags + 1;
		_killer setVariable ["ExileZedKills", _newKillerFrags];
		format["addAccountZombieKill:%1", getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerZedKills = _newKillerFrags;
		(owner _playerObj) publicVariableClient "ExileClientPlayerZedKills";
		ExileClientPlayerZedKills = nil;
	};
	
	if (EnableStatKill) then
	{			
		_newKillerFrags = _killer getVariable ["ExileKills", 0];
		_newKillerFrags = _newKillerFrags + 1;
		_killer setVariable ["ExileKills", _newKillerFrags];
		format["addAccountKill:%1", getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerKills = _newKillerFrags;
		(owner _playerObj) publicVariableClient "ExileClientPlayerKills";
		ExileClientPlayerKills = nil;
	};

	if (EnableRankChange) then
	{
		_newKillerRank = _killer getVariable ["ExileRank", 0];
		_killer setVariable ["ExileRank", (_newKillerRank+_zombieRankChange)];
		format["modifyAccountRank:%1:%2",_zombieRankChange,getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerRank = (_newKillerRank+_zombieRankChange);
		(owner _playerObj) publicVariableClient "ExileClientPlayerRank";
		ExileClientPlayerRank = nil;
	};
	
	if (EnableHumanityChange) then
	{
		_newKillerRank = _killer getVariable ["ExileHumanity", 0];
		_killer setVariable ["ExileHumanity", (_newKillerRank+_zombieRankChange)];
		format["modifyAccountHumanity:%1:%2",_zombieRankChange,getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		ExileClientPlayerHumanity = (_newKillerRank+_zombieRankChange);
		(owner _playerObj) publicVariableClient "ExileClientPlayerHumanity";
		ExileClientPlayerHumanity = nil;
	};
};

if(_explode) then 
{
	{
		if (((_x select 0) distance (position _unit)) < (_x select 1)) exitwith {_safetoblow = false};
	}Foreach SafeZonePositions;
	if (_safetoblow) then 
	{
		sleep ExplosionDelay;
		ExplosiveType createvehicle position _unit;
	};
};
