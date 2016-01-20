// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //


//Create a group for the zombies
private[
    "_group",
	"_obj"
	];
	_obj = _this select 0;

_group = creategroup ZombieSide;
_group setCombatMode "BLUE";
_group allowFleeing 0;
_group enableAttack false;
_obj setvariable ["group", _group, False];

_group;
