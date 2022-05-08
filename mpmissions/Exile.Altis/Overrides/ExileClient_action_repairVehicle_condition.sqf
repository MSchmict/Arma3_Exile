 
private["_vehicle", "_result", "_availableHitpoints", "_canBeReparied"];
_vehicle = _this;
_result = "";
try 
{
	if ((vehicle player) isEqualTo _vehicle) then 
	{
		throw "Are you serious?";
	};
	if (isEngineOn _vehicle) then 
	{
		throw "Turn off the engine first!";
	};
	if ((locked _vehicle) isEqualTo 2) then 
	{
		throw "Unlock the vehicle first!";
	};
	_availableHitpoints = (getAllHitPointsDamage _vehicle) select 0;
	_canBeReparied = false;
	{
		if ((_vehicle getHitPointDamage _x) > 0) exitWith
		{
			_canBeReparied = true;
		};
	}
	forEach _availableHitpoints;
	if !(_canBeReparied) then 
	{
		throw "This vehicle looks fine.";
	}; 
	if !(local _vehicle) then
	{
		throw "Please get in as driver/pilot first.";
	};
	if !("Exile_Item_DuctTape" in (magazines player)) then
	{
		throw "You need duct tape to do that!";
	};
	if ((_vehicle distance player) > 7) then 
	{
		throw "You are too far away!";
	};
}
catch 
{
	_result = _exception;
};
_result