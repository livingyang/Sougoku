testBoss =
	attack: 10
	defense: 10

getBossValue = (base, level) ->
	base * level * level + base * level

Session.setDefault "bossLevel", 1
Session.setDefault "bossAttack", 11
Session.setDefault "bossHealth", 12

class @FightController extends RouteController
	data: ->
		bossLevel = Session.get "bossLevel"
		bossAttack = Session.get "bossAttack"
		bossHealth = Session.get "bossHealth"

		attackBoss:
			level: bossLevel
			attack: getBossValue bossAttack, bossLevel
			health: getBossValue bossHealth, bossLevel
			strong: "100%"
			winRate: "100%"

		defenseBoss:
			level: bossLevel
			attack: getBossValue bossAttack, bossLevel
			health: getBossValue bossHealth, bossLevel
			curHealth: 100