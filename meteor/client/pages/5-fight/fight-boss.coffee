@FightBoss = (fightData) ->
	createjs.Sound.play "bgm/BGM036.OGG", loop: 2
	return
	Router.go "fight-boss"

	handleComplete = ->
		console.log "complete"
		createjs.Sound.play("sound")

	queue = new createjs.LoadQueue(false)
	queue.installPlugin(createjs.Sound)
	queue.addEventListener("complete", handleComplete)
	queue.loadFile({id:"sound", src:"bgm/BGM036.OGG"}, false)
	queue.load()

	return
	Meteor.setTimeout ->
		Router.go "home"
	, 1000

class @FightBossController extends RouteController
	run: ->
		console.log this
		super