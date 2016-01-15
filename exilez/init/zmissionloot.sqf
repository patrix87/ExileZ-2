// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

Private [
"_lootqte",
"_maxOfEach",
"_position",
"_items",
"_item",
"_cargoBox",
"_lootBox",
"_antiflag"
];

_lootqte = 50;
_maxOfEach = 2;
_position = _this select 0;

_items =[
"B_Carryall_cbr",
"B_Carryall_khk",
"B_Carryall_mcamo",
"B_Carryall_ocamo",
"B_Carryall_oli",
"B_Carryall_oucamo",
"B_Parachute",
"V_RebreatherB",
"V_RebreatherIA",
"V_RebreatherIR",
"V_PlateCarrier1_blk",
"V_PlateCarrier1_rgr",
"V_PlateCarrierL_CTRG",
"V_PlateCarrier2_rgr",
"V_PlateCarrier3_rgr",
"V_PlateCarrierH_CTRG",
"V_PlateCarrierIAGL_dgtl",
"V_PlateCarrierIAGL_oli",
"V_PlateCarrierGL_blk",
"V_PlateCarrierGL_mtp",
"V_PlateCarrierGL_rgr",
"H_HelmetO_ocamo",
"H_HelmetO_oucamo",
"U_B_FullGhillie_ard",
"U_B_FullGhillie_lsh",
"U_B_FullGhillie_sard",
"U_I_FullGhillie_ard",
"U_I_FullGhillie_lsh",
"U_I_FullGhillie_sard",
"U_O_FullGhillie_ard",
"U_O_FullGhillie_lsh",
"U_O_FullGhillie_sard",
"U_B_Wetsuit",
"U_I_Wetsuit",
"U_O_Wetsuit",
"arifle_MX_SW_Black_F",
"arifle_MX_SW_F",
"LMG_Mk200_F",
"LMG_Zafir_F",
"MMG_01_hex_F",
"MMG_01_tan_F",
"MMG_02_black_F",
"MMG_02_camo_F",
"MMG_02_sand_F",
"arifle_Katiba_C_F",
"arifle_Katiba_F",
"arifle_Katiba_GL_F",
"arifle_Mk20_F",
"arifle_Mk20_plain_F",
"arifle_Mk20_GL_F",
"arifle_Mk20_GL_plain_F",
"arifle_Mk20C_F",
"arifle_Mk20C_plain_F",
"arifle_TRG20_F",
"arifle_TRG21_F",
"arifle_TRG21_GL_F",
"arifle_MX_Black_F",
"arifle_MX_F",
"arifle_MX_GL_Black_F",
"arifle_MX_GL_F",
"arifle_MXC_Black_F",
"arifle_MXC_F",
"arifle_SDAR_F",
"arifle_MXM_Black_F",
"arifle_MXM_F",
"srifle_DMR_01_F",
"srifle_EBR_F",
"srifle_DMR_03_F",
"srifle_DMR_03_khaki_F",
"srifle_DMR_03_multicam_F",
"srifle_DMR_03_tan_F",
"srifle_DMR_03_woodland_F",
"srifle_DMR_06_camo_F",
"srifle_DMR_06_olive_F",
"srifle_DMR_02_camo_F",
"srifle_DMR_02_F",
"srifle_DMR_02_sniper_F",
"srifle_DMR_05_blk_F",
"srifle_DMR_05_hex_F",
"srifle_DMR_05_tan_f",
"srifle_DMR_04_F",
"srifle_DMR_04_Tan_F",
"srifle_LRR_camo_F",
"srifle_LRR_F",
"srifle_GM6_camo_F",
"srifle_GM6_F",
"optic_Arco",
"optic_Hamr",
"optic_MRCO",
"optic_DMS",
"optic_AMS",
"optic_AMS_khk",
"optic_AMS_snd",
"optic_KHS_blk",
"optic_KHS_hex",
"optic_KHS_old",
"optic_KHS_tan",
"optic_SOS",
"optic_LRPS",
"optic_NVS",
"DemoCharge_Remote_Mag",
"SLAMDirectionalMine_Wire_Mag",
"IEDLandSmall_Remote_Mag",
"IEDUrbanSmall_Remote_Mag",
"HandGrenade",
"HandGrenade",
"HandGrenade",
"Exile_Item_SafeKit",
"Exile_Item_CodeLock",
"Exile_Item_CodeLock",
"Exile_Item_CodeLock",
"NVGoggles",
"NVGoggles_INDEP",
"NVGoggles_OPFOR",
"Rangefinder",
"Laserdesignator",
"Laserdesignator_02",
"Laserdesignator_03"
];


_cargoBox = [

"B_CargoNet_01_ammo_F",
"O_CargoNet_01_ammo_F",
"I_CargoNet_01_ammo_F"
	
] call BIS_fnc_selectRandom;
	
	
/* DON'T EDIT BELOW ADVANCED USERS ONLY */
//////////////////////////////////////////


_lootBox = _cargoBox createvehicle _position;
_antiflag = "Exile_Construction_Flag_Static" createvehicle _position;

clearMagazineCargoGlobal _lootBox;
clearWeaponCargoGlobal _lootBox;
clearItemCargoGlobal _lootBox;
_lootBox enableRopeAttach false;
_lootBox setVariable ["permaLoot",true];
_lootBox allowDamage false;

for "_i" from 1 to _lootqte do {
	_item = _items call BIS_fnc_selectRandom;
	_lootBox addItemCargoGlobal [_item, (ceil random _maxOfEach)];
};
