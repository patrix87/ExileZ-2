// Chances for each group to spawn relative to the other groups.

//Do not set value to 0, comment out the line and adjust the commas instead.

//Primary spawner classes
PrimaryGroup = [
[slowCivilians,		200],
[slowSoldiers,		100],
[mediumCivilians,	20],
[mediumSoldiers,	10],
[fastCivilians,		10],
[fastSoldiers,		5],
[crawlers,			40],
[spiders,			25],
[boss,				1]
];


//Secondary spawner classes
SecondaryGroup = [
//[slowCivilians,	200],
//[slowSoldiers,	100],
[mediumCivilians,	20],
[mediumSoldiers,	15],
[fastCivilians,		10],
[fastSoldiers,		5],
[crawlers,			10],
[spiders,			15],
[boss,				1]
];

//Harassing zombies classes
HarassingGroup = [
[slowCivilians,		2],
[slowSoldiers,		1]
//[mediumCivilians,	1],
//[mediumSoldiers,	1],
//[fastCivilians,	1],
//[fastSoldiers,	1],
//[crawlers,		1],
//[spiders,			1],
//[boss,			1]
];

/* DON'T EDIT BELOW ADVANCED USERS ONLY */
//////////////////////////////////////////

_count = 0;
{
	_count = _count + (_x select 1);
	(PrimaryGroup select _forEachIndex) set [1,_count];
}foreach PrimaryGroup;

_count = 0;
{
	_count = _count + (_x select 1);
	(SecondaryGroup select _forEachIndex) set [1,_count];
}foreach SecondaryGroup;

_count = 0;
{
	_count = _count + (_x select 1);
	(HarassingGroup select _forEachIndex) set [1,_count];
}foreach HarassingGroup;

GetZombie = {
	_return = 0;
	_result = ceil random ((_this select ((count _this) - 1)) select 1);
	{
		if((_x select 1) >= _result) exitwith
		{
			_return = ((_x select 0) call BIS_fnc_selectRandom) select 0;
		};
	}foreach _this;
	_return;
};
