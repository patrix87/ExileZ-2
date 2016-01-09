// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//Give a random location around a center position.

private[
	"_xOffset",
	"_yOffset",
	"_center",
	"_position",
	"_maxDistance",
	"_minDistance"
	];

_center = _this select 0;
_minDistance = _this select 1;
_maxDistance = _this select 2;
	
// randomize location
_xOffset = floor ((random (_maxDistance-_minDistance))+_minDistance);
_yOffset = floor ((random (_maxDistance-_minDistance))+_minDistance);
_xOffset = [_xOffset,(-_xOffset)] call BIS_fnc_selectRandom;
_yOffset = [_yOffset,(-_yOffset)] call BIS_fnc_selectRandom;
_position = [round((_center select 0) + _xOffset),round((_center select 1) + _yOffset)];

// clear walls and floors
_position = _position findEmptyPosition [0,3,"Man"];


// return

_position;