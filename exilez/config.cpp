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