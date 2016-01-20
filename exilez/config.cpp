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
	class ZOM {
		class ZOMZ {
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
		class fnc_RyanZombies_SwitchMove{ allowedTargets=0; };
	};
	class Commands
	{
		mode=0;
		jip=0;
	};
};