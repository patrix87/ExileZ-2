// Can't be empty
//Primary spawner classes
PrimaryClasses = 
{
	_return = [
	
	"RyanZombieC_man_polo_2_Fslow", 
	"RyanZombieC_man_polo_4_Fslow", 
	"RyanZombieC_man_polo_5_Fslow", 
	"RyanZombieC_man_polo_6_Fslow", 
	"RyanZombieC_man_p_fugitive_Fslow", 
	"RyanZombieC_man_w_worker_Fslow", 
	"RyanZombieC_scientist_Fslow", 
	"RyanZombieC_man_hunter_1_Fslow", 
	"RyanZombieC_man_pilot_Fslow", 
	"RyanZombieC_journalist_Fslow", 
	"RyanZombieC_Orestesslow", 
	"RyanZombieC_Nikosslow", 
	"RyanZombieB_Soldier_02_fslow", 
	"RyanZombieB_Soldier_02_f_1slow", 
	"RyanZombieB_Soldier_02_f_1_1slow", 
	"RyanZombieB_Soldier_03_fslow", 
	"RyanZombieB_Soldier_03_f_1slow", 
	"RyanZombieB_Soldier_03_f_1_1slow", 
	"RyanZombieB_Soldier_04_fslow", 
	"RyanZombieB_Soldier_04_f_1slow", 
	"RyanZombieB_Soldier_04_f_1_1slow", 
	"RyanZombieB_Soldier_lite_Fslow", 
	"RyanZombieB_Soldier_lite_F_1slow", 
	"RyanZombieB_RangeMaster_Fmedium", 
	//"RyanZombieboss1", //NOT COOL
	"RyanZombieCrawler1",
	"RyanZombieSpider1"
	
	] call BIS_fnc_selectRandom;
	_return;
};
	
//Secondary spawner classes
SecondaryClasses = 
{
	_return = [
	
	"RyanZombieB_RangeMaster_Fmedium", 
	//"RyanZombieboss1", //NOT COOL
	"RyanZombieCrawler1",
	"RyanZombieSpider1"
	
	] call BIS_fnc_selectRandom;
	_return;
}; 
	
//Harassing zombies classes
HarassingClasses = 
{
	_return = [
	
	"RyanZombieC_man_polo_2_Fslow", 
	"RyanZombieC_man_polo_4_Fslow", 
	"RyanZombieC_man_polo_5_Fslow", 
	"RyanZombieC_man_polo_6_Fslow", 
	"RyanZombieC_man_p_fugitive_Fslow", 
	"RyanZombieC_man_w_worker_Fslow", 
	"RyanZombieC_scientist_Fslow", 
	"RyanZombieC_man_hunter_1_Fslow", 
	"RyanZombieC_man_pilot_Fslow", 
	"RyanZombieC_journalist_Fslow", 
	"RyanZombieC_Orestesslow", 
	"RyanZombieC_Nikosslow"
	
	] call BIS_fnc_selectRandom;
	_return;
};