// ROAMING TRADER by JohnO
// http://www.exilemod.com/profile/38-john/
// http://www.exilemod.com/topic/7664-roaming-trader-script

// Trader vehicle handling added by second_coming 
// http://www.exilemod.com/profile/60-second_coming/

diag_log format['[travellingtrader] Started'];

if (!isServer) exitWith {};

_world = (toLower worldName);

	// По умолчанию Черноруссия 
	_spawnCenter = [7652.9634, 7870.8076,0];
	_max = 7500;
	_wayPointOne = getMarkerPos "NEAF Aircraft Traders";
	_wayPointTwo = [11430,11384,0]; // Near Klen
	_wayPointThree = [13463,6298,0]; // Solnichniy
	_wayPointFour = [11591,3388,0]; // Near Otmel
	_wayPointFive = [1930,2246,0]; // Kamenka
	_wayPointSix = [4221,11697,0]; // Near Bash
	_wayPointSeven = getMarkerPos "Stary Traders";
	_wayPoints = [_wayPointOne,_wayPointTwo,_wayPointThree,_wayPointFour,_wayPointFive,_wayPointSix,_wayPointSeven,_wayPointOne];

if (_world isEqualTo 'altis') then 
{
	_spawnCenter = [15834.2,15787.8,0];
	_max = 9000;
	_wayPointOne = getMarkerPos "AlmyraTraders";
	_wayPointTwo = getMarkerPos "TraderCityMarker";
	_wayPointThree = getMarkerPos "NorthZarosTraders";
	_wayPointFour = getMarkerPos "TraderZoneSilderas";
	_wayPoints = [_wayPointOne,_wayPointTwo,_wayPointThree,_wayPointFour,_wayPointOne];
};
 
_min = 1500; // Минимальное расстояние от позиции центра (число) в метрах
_mindist = 20; // Минимальное расстояние от ближайшего объекта (число) в метрах, т. е.. создать точку это расстояние от чего-нибудь в пределах х метров..
_water = 0; // водный режим 0: не может быть в воде 1: может быть в воде или нет, 2: должен быть в воде
_shoremode = 0; // 0: не нужно быть на берег, 1: должны быть на берегу

_possiblePosStart = [_wayPointOne,100,300,_mindist,_water,20,_shoremode] call BIS_fnc_findSafePos; //Используйте это, если вы хотите совершенно случайное место появления 

// Создайте трейдера и убедиться, что он не реагирует на выстрелы 

_group = createGroup resistance;
_group setCombatMode "BLUE";

"Exile_Trader_CommunityCustoms" createUnit [_possiblePosStart, _group, "trader = this; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this disableAI 'SUPPRESSION'; "];
trader allowDamage false; 
removeGoggles trader;
trader forceAddUniform "U_IG_Guerilla3_1";
trader addVest "V_TacVest_blk_POLICE";
trader addBackpack "B_FieldPack_oli";
trader addHeadgear "H_Cap_blk";
trader setCaptive true;

// Spawn Traders Vehicle
_vehicleObject = createVehicle ["Exile_Car_Volha_Black", _possiblePosStart, [], 0, "CAN_COLLIDE"];
clearBackpackCargoGlobal _vehicleObject;
clearItemCargoGlobal _vehicleObject;
clearMagazineCargoGlobal _vehicleObject;
clearWeaponCargoGlobal _vehicleObject;
_vehicleObject setVariable ["ExileIsPersistent", false];
_vehicleObject setFuel 1;

diag_log format['[travellingtrader] Vehicle spawned @ %1',_possiblePosStart];

_vehicleObject addEventHandler ["HandleDamage", {
_amountOfDamage = 0;
_amountOfDamage
}];

trader assignasdriver _vehicleObject;
[trader] orderGetin true;
 
{
	_wp = _group addWaypoint [_x, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointspeed "LIMITED"; 
} forEach _wayPoints; 
 
_traderPos = position trader;
_mk = createMarker ["TraderLocation",_traderPos];
"TraderLocation" setMarkerType "mil_warning";
"TraderLocation" setMarkerText "Travelling Trader";

// трейдер стоит до сих пор, пока игроки находятся рядом с ним.
while {true} do
	{
		_pos = position _vehicleObject;
		_mk setMarkerPos _pos;
		_requiredMin = 2;
		_nearPlayers = (count (_pos nearEntities [['Man'],15]));
		
		if(trader in _vehicleObject) then
		{			 
			_requiredMin = 1;
		};
		
		if (_nearPlayers >= _requiredMin) then
		{
			[trader] orderGetin false;
			uiSleep 0.5;
			_vehicleObject setVehicleLock "LOCKED";
			_vehicleObject setFuel 0;
			trader action ["LightOff", trader];	
			trader action ["salute", trader];		
			trader disableAI "MOVE";
			uiSleep 5;
		}
		else
		{	
			trader assignasdriver _vehicleObject;
			[trader] orderGetin true;
			_vehicleObject setFuel 1;
			_vehicleObject setVehicleLock "UNLOCKED";
			uiSleep 0.5;
			trader moveInDriver _vehicleObject;
			trader action ["LightOn", trader];	
			trader enableAI "MOVE";
		};
		_vehicleObject setFuel 1;
		uiSleep 5;
		if(!Alive trader)exitWith {};
	};		
	
