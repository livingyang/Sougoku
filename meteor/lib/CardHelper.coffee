@CardHelper =

	getExpFromLevel: (level) ->
		if level > 1 then 30 * level * level - 20 else 0

	getLevelFromExp: (exp) ->
		if exp > 1 then Math.floor Math.sqrt (exp + 20) / 30 else 1

	getBaseExp: (star) ->
		if star > 0 then 100 * Math.pow 3, star - 1 else 0

	getBaseExpFromRare: (rare) ->
		@getBaseExp @getStar rare

	getBetweenValue: (minLevel, maxLevel, minValue, maxValue, curLevel) ->
		Math.floor (curLevel * maxValue - curLevel * minValue - minLevel * maxValue + maxLevel * minValue) / (maxLevel - minLevel)

	getLimitMaxLevel: (maxLevel, mergeMaxLevel, mergeCount = 0) ->
		limitMaxLevel = maxLevel + mergeCount * 10
		if limitMaxLevel < mergeMaxLevel then limitMaxLevel else mergeMaxLevel

	getLimitLevel: (curLevel, limitMaxLevel = curLevel) ->
		if curLevel < limitMaxLevel then curLevel else limitMaxLevel

	getStar: (rare) ->
		rareMap =
			"C": 1
			"UC": 2
			"R": 3
			"SR": 4
			"EU": 5

		if rareMap[rare]? then rareMap[rare] else 1
