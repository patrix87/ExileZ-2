class CfgPatches {
	class exilez {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {
			"Ryanzombies",
			"ryanzombiesfunctions",
			"Ryanzombiesanims",
			"Ryanzombiesfaces"
		};
	};
};

class CfgFunctions {
	class exilez {
		class exilez {
			file = "exilez\init";
			class init {
				postInit = 1;
			};
		};
	};
};

class CfgRemoteExec
{
	class Functions
	{
		mode = 1;
		jip = 0;
		class BIS_fnc_MP {allowedTargets = 0;};
		class fnc_RyanZombies_SwitchMove{ allowedTargets=0; };
	};
	class Commands
	{
		mode=1;
		jip=0;
		class switchmove {allowedTargets = 0;};
	};
};
