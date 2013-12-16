@FightHelper =
	countEnemyHealth: (enemyHealth, userAttack) ->
		enemyHealth - userAttack

	isEnemyDead: (enemyHealth) ->
		enemyHealth <= 0

	getRemainAttack: (remainAttack, health) ->
		remainAttack - health

	getAttackStrength: (remainAttack, maxAttack) ->
		remainAttack = 0 if remainAttack < 0
		remainAttack / maxAttack

	isAttackDone: (attackStrength) ->
		attackStrength <= 0

	isDefenseSuccess: (remainAttack, health) ->
		return true if remainAttack <= 0
		health > Math.random() * remainAttack >= 0

	getDefenseSuccessRate: (remainAttack, health) ->
		if health >= remainAttack or remainAttack <= 0
			1
		else
			health / remainAttack
