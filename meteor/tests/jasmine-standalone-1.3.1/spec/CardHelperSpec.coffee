describe "CardHelper", ->
	describe "getExpFromLevel", ->
		expectExpAndLevel = (level, exp) ->
			(expect CardHelper.getExpFromLevel level).toBe exp
			(expect CardHelper.getLevelFromExp exp).toBe level
			
		it "exp and level", ->
			expectExpAndLevel 1, 0
			expectExpAndLevel 2, 120
			expectExpAndLevel 3, 270

		it "more exp", ->
			(expect CardHelper.getLevelFromExp 1).toBe 1
			(expect CardHelper.getLevelFromExp 119).toBe 1
			(expect CardHelper.getLevelFromExp 121).toBe 2
			(expect CardHelper.getLevelFromExp 269).toBe 2

	describe "getBaseExp", ->
		it "simple test", ->
			(expect CardHelper.getBaseExp 1).toBe 100
			(expect CardHelper.getBaseExp 2).toBe 300
			(expect CardHelper.getBaseExp 3).toBe 900
			(expect CardHelper.getBaseExp 4).toBe 2700
			(expect CardHelper.getBaseExp 5).toBe 8100
			(expect CardHelper.getBaseExp 6).toBe 24300
