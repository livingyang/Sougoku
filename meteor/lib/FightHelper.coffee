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
		health > Math.random() * remainAttack >= 0