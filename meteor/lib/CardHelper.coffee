@CardHelper =

	getExpFromLevel: (level) ->
		
		return 0 if not level instanceof Number

		if level <= 1
			0
		else
			30 * level * level

	getLevelFromExp: (exp) ->

		return 1 if not exp instanceof Number

		if exp <= 1
			1
		else
			Math.floor Math.sqrt exp / 30

	getBaseExp: (cost) ->
		return 0 if not cost instanceof Number
		100 * Math.pow 3, cost - 1

	getBetweenValue: (minLevel, maxLevel, minValue, maxValue, curLevel) ->
		Math.floor (curLevel * maxValue - curLevel * minValue - minLevel * maxValue + maxLevel * minValue) / (maxLevel - minLevel)

