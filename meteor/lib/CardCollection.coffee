@CardCollection = CreateCollectionFromPublicCsv "csv/1-human.csv"

CardCollection.getIsOpenCursor = ->
	@find isOpen: "1"

Meteor.startup ->
	console.log  getExpFromLevel 1
	console.log  getExpFromLevel 2

	console.log getLevelFromExp 101, 0, 10


getExpFromLevel = (level) ->
	30 * level * level + 70 * level

getLevelFromExp = (exp, minLevel, maxLevel) ->
	return minLevel if exp <= getExpFromLevel minLevel
	return maxLevel if exp >= getExpFromLevel maxLevel
	return minLevel if maxLevel - minLevel is 1

	middleLevel = Math.floor (maxLevel + minLevel) / 2
	middleLevelExp = getExpFromLevel middleLevel
	if exp > middleLevelExp
		getLevelFromExp exp, minLevel, middleLevel
	else if exp < middleLevelExp
		getLevelFromExp exp, middleLevel, maxLevel
	else
		middleLevel

