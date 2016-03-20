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
	
	if (EnableMoneyOnKill) then 
	{
		[_playerObj, "moneyReceivedRequest", [str _money, "Killing Zombies"]] call ExileServer_system_network_send_to;
		_playerObj setVariable ["ExileMoney", _money];
	};
	
	if (EnableRespectOnKill) then
	{
		[_playerObj, "showFragRequest", [_killerRespectPoints]] call ExileServer_system_network_send_to;
		_playerObj setVariable ["ExileScore", _respect];
		ExileClientPlayerScore = _respect;
		(owner _playerObj) publicVariableClient "ExileClientPlayerScore";
		ExileClientPlayerScore = nil;
	};
	
	if (EnableMoneyOnKill or EnableRespectOnKill) then 
	{
		// Update client database entry
		format["setAccountMoneyAndRespect:%1:%2:%3", _money, _respect, (getPlayerUID _playerObj)] call ExileServer_system_database_query_fireAndForget;
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
