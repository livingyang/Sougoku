
bossHealth = 12
bossAttack = 11

userHealth = 20
userAttack = 21

getBossValue = (base, level) ->
	base * level * level + base * level

getBossLevel = ->
	Session.get "bossLevel"

resetBossLevel = (level) ->
	Session.set "bossLevel", level
	Session.set "bossRemainHealth", getBossValue bossHealth, level
	Session.set "bossRemainAttack", getBossValue bossAttack, level

Session.setDefault "bossLevel", 1
Session.setDefault "bossRemainHealth", getBossValue bossHealth, 1
Session.setDefault "bossRemainAttack", getBossValue bossAttack, 1

class @FightController extends RouteController
	data: ->
		bossLevel = getBossLevel()
		maxBossHealth = getBossValue bossHealth, bossLevel
		maxBossAttack = getBossValue bossAttack, bossLevel

		bossRemainHealth = Session.get "bossRemainHealth"
		bossRemainAttack = Session.get "bossRemainAttack"

		attackBoss:
			level: getBossLevel()
			attack: maxBossAttack
			health: maxBossHealth
			remainAttack: bossRemainAttack
			strong: "#{(100 * FightHelper.getAttackStrength bossRemainAttack, maxBossAttack).toFixed 2}%"
			winRate: "#{(100 * FightHelper.getDefenseSuccessRate bossRemainAttack, userHealth).toFixed 2}%"

		defenseBoss:
			level: getBossLevel()
			attack: maxBossAttack
			health: maxBossHealth
			remainHealth: bossRemainHealth

Template.fight.events "click #attack": ->
	bossRemainHealth = Session.get "bossRemainHealth"
	bossRemainHealth = FightHelper.countEnemyHealth bossRemainHealth, userAttack
	if FightHelper.isEnemyDead bossRemainHealth
		resetBossLevel getBossLevel() + 1
	else
		Session.set "bossRemainHealth", bossRemainHealth

Template.fight.events "click #defense": ->
	bossRemainAttack = Session.get "bossRemainAttack"
	bossRemainAttack = FightHelper.getRemainAttack bossRemainAttack, userHealth
	if FightHelper.isDefenseSuccess bossRemainAttack, userHealth
		resetBossLevel getBossLevel() + 1
	else
		Session.set "bossRemainAttack", bossRemainAttack