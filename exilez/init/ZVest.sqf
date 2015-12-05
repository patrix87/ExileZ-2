
//Primary spawner Vests
PrimaryVest = 
{
	_return = [
	
	"V_HarnessOGL_brn",
	"V_HarnessOGL_gry",
	"V_HarnessO_brn",
	"V_HarnessO_gry",
	"V_HarnessOSpec_brn",
	"V_HarnessOSpec_gry",
	"V_TacVest_blk",
	"V_TacVest_blk_POLICE",
	"V_TacVest_brn",
	"V_TacVest_camo",
	"V_TacVest_khk",
	"V_TacVest_oli",
	"V_TacVestCamo_khk",
	"V_TacVestIR_blk",
	"V_Rangemaster_belt"
	
	] call BIS_fnc_selectRandom;
	_return;
};

//Secondary spawner Vests
SeccondaryVest = 
{
	_return = [
	
	"V_HarnessOGL_brn",
	"V_HarnessOGL_gry",
	"V_HarnessO_brn",
	"V_HarnessO_gry",
	"V_HarnessOSpec_brn",
	"V_HarnessOSpec_gry"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
//Harassing zombies Vests
HarassingVest = 
{
	_return = [
	
	"V_Rangemaster_belt"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
// No Vest config, replace the whole function with those lines. Loot won't spawn if vest is empty.
/*
PrimaryVest = "";
SeccondaryVest = "";
HarassingVest = "";
/*