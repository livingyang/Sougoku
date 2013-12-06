describe "CardHelper", ->
	describe "getExpFromLevel", ->
		expectExpAndLevel = (level, exp) ->
			(expect CardHelper.getExpFromLevel level).toBe exp
			(expect CardHelper.getLevelFromExp exp).toBe level
			
		it "exp and level", ->
			expectExpAndLevel 1, 0
			expectExpAndLevel 2, 100
			expectExpAndLevel 3, 250

		it "more exp", ->
			(expect CardHelper.getLevelFromExp 1).toBe 1
			(expect CardHelper.getLevelFromExp 99).toBe 1
			(expect CardHelper.getLevelFromExp 100).toBe 2
			(expect CardHelper.getLevelFromExp 249).toBe 2

	describe "getBaseExp", ->
		it "simple test", ->
			(expect CardHelper.getBaseExp 1).toBe 100
			(expect CardHelper.getBaseExp 2).toBe 300
			(expect CardHelper.getBaseExp 3).toBe 900
			(expect CardHelper.getBaseExp 4).toBe 2700
			(expect CardHelper.getBaseExp 5).toBe 8100
			(expect CardHelper.getBaseExp 6).toBe 24300

		it "getBaseExpFromRare", ->
			(expect CardHelper.getBaseExpFromRare "C").toBe 100
			(expect CardHelper.getBaseExpFromRare "UC").toBe 300
			(expect CardHelper.getBaseExpFromRare "R").toBe 900
			(expect CardHelper.getBaseExpFromRare "SR").toBe 2700
			(expect CardHelper.getBaseExpFromRare "EU").toBe 8100

	describe "getBetweenValue", ->
		it "simple test", ->
			(expect CardHelper.getBetweenValue 1, 3, 1, 3, 1).toBe 1
			(expect CardHelper.getBetweenValue 1, 3, 1, 3, 2).toBe 2
			(expect CardHelper.getBetweenValue 1, 3, 1, 3, 3).toBe 3

			(expect CardHelper.getBetweenValue 1, 3, 100, 300, 2).toBe 200
			
	describe "getLimitLevel", ->
		it "getLimitMaxLevel", ->
			(expect CardHelper.getLimitMaxLevel 10, 30, 1).toBe 20
			(expect CardHelper.getLimitMaxLevel 11, 30, 1).toBe 21
			(expect CardHelper.getLimitMaxLevel 11, 30, 2).toBe 30

		it "default value", ->
			(expect CardHelper.getLimitMaxLevel 10, 10).toBe 10
			(expect CardHelper.getLimitMaxLevel 10, 20).toBe 10

			(expect CardHelper.getLimitLevel 14).toBe 14
			(expect CardHelper.getLimitLevel 20).toBe 20
			
		it "simple test", ->
			(expect CardHelper.getLimitLevel 6, 10).toBe 6
			(expect CardHelper.getLimitLevel 10, 10).toBe 10
			(expect CardHelper.getLimitLevel 14, 10).toBe 10

	describe "getStar", ->
		it "simple test", ->
			(expect CardHelper.getStar "C").toBe 1
			(expect CardHelper.getStar "EU").toBe 5
			(expect CardHelper.getStar()).toBe 1
			