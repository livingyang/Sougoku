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
