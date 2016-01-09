// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //


//Create a group for the zombies
private[
    "_group",
	"_obj"
	];
	_obj = _this select 0;

_group = creategroup ZombieSide;
_group setcombatmode "RED";
_group allowfleeing 0;
_group setspeedmode "limited";
_obj setvariable ["group", _group, False];
if (UseHC) then {
	//_localityChanged = _group setGroupOwner (owner HC); //transfer group to HC
};

_group;
