# ExileTravellingTrader
Скрипт Путешествующий Торговец для Exile mod.

для добавления торговцу товара , измените Exile_Trader_CommunityCustoms в миссии config.cpp

Вам нужно будет отредактировать маркер путевые точки на карте, или стационарные позиций travellingTrader.sqf


	_wayPointOne = getMarkerPos "NEAF Aircraft Traders";
	_wayPointTwo = [11430,11384,0]; // Near Klen
	_wayPointThree = [13463,6298,0]; // Solnichniy
	_wayPointFour = [11591,3388,0]; // Near Otmel
	_wayPointFive = [1930,2246,0]; // Kamenka
	_wayPointSix = [4221,11697,0]; // Near Bash
	_wayPointSeven = getMarkerPos "Stary Traders";
	_wayPoints = [_wayPointOne,_wayPointTwo,_wayPointThree,_wayPointFour,_wayPointFive,_wayPointSix,_wayPointSeven,_wayPointOne];

Если нужно, добавьте это к линии createUnit в файле scripts.txt

 !"createUnit [_possiblePosStart, _group, ""trader = this; this disableAI"
