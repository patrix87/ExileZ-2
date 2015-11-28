class CfgPatches {
	class exilez {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
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