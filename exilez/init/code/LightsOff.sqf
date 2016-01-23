{
	{
		_x setDamage 0.95;
	}foreach([15000,15000] nearObjects [_x,20000]);
}foreach["Land_fs_roof_F","Lamps_Base_F", "PowerLines_base_F","Land_PowerPoleWooden_L_F"];

/* these are apparently on client side... they don't make much difference anyway
{   
	{    
		_x setDamage 1;   
	}foreach([15000,15000] nearObjects [_x,20000]);
}foreach["Land_runway_edgelight","Land_Flush_Light_yellow_F","Land_Flush_Light_green_F","Land_NavigLight"];
*/