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
			