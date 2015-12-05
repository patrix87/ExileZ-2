//Primary spawner loot
PrimaryLoot = 
{
	_return = [
	
	"Exile_Item_InstaDoc",
	"Exile_Item_Catfood",
	"Exile_Item_PlasticBottleFreshWater",
	"Exile_Item_Matches",
	"Exile_Item_DuctTape",
	"Exile_Item_CookingPot",
	"16Rnd_9x21_Mag"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
//Secondary spawner loot
SeccondaryLoot = 
{
	_return = [
	
	"Exile_Item_InstaDoc",
	"16Rnd_9x21_Mag"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
	
//Harassing zombie loot
HarassingLoot = 
{
	_return = [
	
	"Exile_Item_PlasticBottleEmpty"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
// No loot config, replace the whole function with those lines. Loot won't spawn if vest is empty.
/*
PrimaryLoot =
{
	_return = "";
	_return;
};

SeccondaryLoot =
{
	_return = "";
	_return;
};

HarassingLoot = 
{
	_return = "";
	_return;
};
/*