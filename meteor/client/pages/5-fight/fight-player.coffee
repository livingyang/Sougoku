@PlayFight = (fightData, completeFunc, preloadRes) ->
	console.log fightData
	# completeFunc?()
	queue = new createjs.LoadQueue();
	queue.installPlugin(createjs.Sound);
	queue.on "complete", handleComplete = ->
		console.log "complete"
		createjs.Sound.play "sound"

	queue.loadFile({id:"sound", src:"bgm/BGM030.m4a"}, false);
	# queue.loadManifest([
	# 	{id: "card", src:"card/CD000AA.jpg"}
	# 	]);
	queue.load()

	Router.go "fightPlayer", null, fightData: fightData, completeFunc: completeFunc

class @FightPlayerController extends RouteController
	run: ->
		super

		console.log this
		Router.go "home" if not @options.fightData? and not @options.completeFunc?
		
