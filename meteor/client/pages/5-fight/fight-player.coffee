@PlayFight = (fightData, completeFunc, preloadRes) ->

	# 1 提前读取资源
	queue = new createjs.LoadQueue();
	queue.installPlugin(createjs.Sound);
	queue.on "complete", handleComplete = ->
		createjs.Sound.stop()
		createjs.Sound.play "m4a/BGM018.m4a", loop: -1

		# 2 读取完资源后，进入战斗页面
		Router.go "fightPlayer", null, fightData: fightData, completeFunc: completeFunc

	# 测试数据
	# ------- 
	preloadRes = [
		{id:"m4a/BGM018.m4a", src:"m4a/BGM018.m4a"}
		{id:"scene/BG008AB.jpg", src:"scene/BG008AB.jpg"}
	]
	# fightData = a: 33

	fightData.imgBg = "scene/BG008AB.jpg"
	# -------

	queue.loadManifest preloadRes

Template.fightPlayer.rendered = ->
	controller = Router.current()
	fightData = controller.options.fightData
	completeFunc = controller.options.completeFunc
	if not fightData? or not completeFunc?
		Router.go "home"
		return
	
	console.log controller.options.fightData

	canvas = document.getElementById("fight-canvas")
	canvas.width = document.body.clientWidth
	canvas.height = document.body.clientHeight

	stage = new createjs.Stage canvas
	createjs.Ticker.addEventListener "tick", stage
	
	# 1 生成场景

	image = new createjs.Bitmap fightData.imgBg
	stage.addChild image
	image.set regX : 50, regY : 50

	# stage.update()

# class @FightPlayerController extends RouteController
# 	run: ->
# 		super

# 		console.log this
# 		Router.go "home" if not @options.fightData? and not @options.completeFunc?
		
