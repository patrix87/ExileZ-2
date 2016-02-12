// ExileZ 2.0 by Patrix87 of http:\\multi-jeux.quebec //

//Give a random location around a center position.

//_NewPosition = [_position,MinDistance,MaxDistance] call GetRandomLocation;

private[
	"_xOffset",
	"_yOffset",
	"_center",
	"_position",
	"_maxDistance",
	"_minDistance",
	"_radius",
	"_angle",
	"_centerX",
	"_centerY",
	"_newX",
	"_newY"
	];


_center = _this select 0;
_minDistance = _this select 1;
_maxDistance = _this select 2;
_angle = 0;
_radius = 0;
// randomize location

_radius = floor ((random (_maxDistance-_minDistance))+_minDistance);
_angle = floor (random 360);

_xOffset = _radius * (cos _angle);
_yOffset = _radius * (sin _angle);

_centerX = _center select 0;
_centerY = _center select 1;

_newX = _centerX + _xOffset;
_newY = _centerY + _yOffset;

_newX = round(_newX);
_newY = round(_newY);

_position = [_newX,_newY];

// clear walls and floors
_position = _position findEmptyPosition [0,10,"Man"];

// return
_position;