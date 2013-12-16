describe "FightHelperSpec", ->
	describe "UserAttack", ->
		it "countEnemyHealth", ->
			(expect FightHelper.countEnemyHealth 10, 1).toBe 9
			(expect FightHelper.countEnemyHealth 10, 5).toBe 5
			(expect FightHelper.countEnemyHealth 10, 10).toBe 0
			(expect FightHelper.countEnemyHealth 10, 11).toBe -1
			(expect FightHelper.countEnemyHealth 10, 100).toBe -90

		it "isEnemyDead", ->
			(expect FightHelper.isEnemyDead 10).toBe false
			(expect FightHelper.isEnemyDead 1).toBe false
			(expect FightHelper.isEnemyDead 0).toBe true
			(expect FightHelper.isEnemyDead -10).toBe true

	describe "UserDefense", ->
		it "getRemainAttack", ->
			(expect FightHelper.getRemainAttack 10, 1).toBe 9
			(expect FightHelper.getRemainAttack 10, 5).toBe 5
			(expect FightHelper.getRemainAttack 10, 10).toBe 0
			(expect FightHelper.getRemainAttack 10, 11).toBe -1
			(expect FightHelper.getRemainAttack 10, 100).toBe -90

		it "getAttackStrength", ->
			(expect FightHelper.getAttackStrength 10, 10).toBe 1
			(expect FightHelper.getAttackStrength 5, 10).toBe 0.5
			(expect FightHelper.getAttackStrength 0, 10).toBe 0
			(expect FightHelper.getAttackStrength -1, 10).toBe 0
			(expect FightHelper.getAttackStrength -10, 10).toBe 0

		it "isAttackDone", ->
			(expect FightHelper.isAttackDone 0).toBe true
			(expect FightHelper.isAttackDone -1).toBe true
			(expect FightHelper.isAttackDone 1).toBe false
			(expect FightHelper.isAttackDone 2).toBe false
			(expect FightHelper.isAttackDone 0.5).toBe false

		it "isDefenseSuccess", ->
			(expect FightHelper.isDefenseSuccess 10, 0).toBe false
			(expect FightHelper.isDefenseSuccess 10, 10).toBe true
			(expect FightHelper.isDefenseSuccess 0, 0).toBe false
			(expect FightHelper.isDefenseSuccess 0, 10).toBe true