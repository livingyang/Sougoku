

cardImages = [
	"/card/CD001AA.jpg"
	"/card/CD001DA.jpg"
	"/card/CD001GA.jpg"
	"/card/CD001HA.jpg"
	"/card/CD002EA.jpg"
	"/card/CD002FA.jpg"
	"/card/CD003BA.jpg"
	"/card/CD003CA.jpg"
	"/card/CD003IA.jpg"
	"/card/CD003JA.jpg"
]

class @FightController extends RouteController

	data: ->
		canvasWidth: document.body.scrollWidth
		canvasHeight: document.body.scrollHeight

	before: ->
		try
			fightData = JSON.parse @params.data

			Template[@template].rendered = =>
				@playFight fightData, document.getElementById "fight-canvas"

		catch e
			Router.go "home"
			console.log "parse fightData error, @params.data: #{@params.data}"

	playFight: (fightData, canvas)->
		# console.log fightData
		# console.log canvas

		stage = new createjs.Stage canvas
		createjs.Ticker.addEventListener "tick", stage
		createjs.Ticker.setFPS(60)

		container = new createjs.Container()
		stage.addChild container

		container.set
			x: canvas.width / 2
			y: canvas.height / 2

		container.set scaleX: 0.5, scaleY: 0.5 if canvas.height < 400

		console.log [canvas.width, canvas.height]

		# 所有的卡片
		totalCard = new createjs.Text "0", "24px Arial", "green"
		container.addChild totalCard
		totalCard.set x: -400, y: -200

		# fps
		labFps = new createjs.Text "0", "24px Arial", "red"
		container.addChild labFps
		labFps.set x: -350, y: -200
		labFps.addEventListener "tick", ->
			labFps.text = Math.round(createjs.Ticker.getMeasuredFPS()) + " fps";

		# toggle cache
		cards = []

		rect = new createjs.Shape();
		rect.graphics.beginFill("red").drawRect -350, -150, 100, 100
		container.addChild rect

		isCache = false
		rect.addEventListener "click", ->
			for card in cards
				# console.log card
				# console.log card.getBounds()
				if isCache
					card.cache 0, 0, card.getBounds().width, card.getBounds().height
				else
					card.uncache()
			isCache = not isCache

		# add image
		addRect = new createjs.Shape();
		addRect.graphics.beginFill("blue").drawRect -350, 0, 100, 100
		# addRect.set x: 0
		container.addChild addRect

		@_loadResource (queue) =>
			addRect.addEventListener "click", =>

				# console.log queue
				card = @_createCardContainer (queue.getItem Random.choice cardImages).tag, 100, 100, 100
				container.addChild card
				cards.push card
				totalCard.text = cards.length

				randomPos = ->
					x: (Random.fraction() - 0.5) * 400
					y: (Random.fraction() - 0.5) * 400
				card.set randomPos()
				
				# createjs.Tween.get(card, {loop:true})
				# .to(randomPos(), 1000)
	
	_loadResource: (loadCompleteFunc) ->
		queue = new createjs.LoadQueue(false)
		queue.installPlugin createjs.Sound
		console.log "#{new Date()}, load start"
		queue.addEventListener "complete", (aEvent) ->
			# console.log aEvent.target instanceof createjs.LoadQueue
			loadCompleteFunc?(aEvent.target)
			console.log "#{new Date()}, load end"

		# queue.loadFile fightBossData.init.scene, false
		# queue.loadFile fightBossData.init.boss, false
		# for cardData in fightBossData.init.cardList
		# 	queue.loadFile {id: cardData.image, src: cardData.image}, false

		# queue.loadFile {id: "m1.mp3", src: "m1.mp3"}, false
		# queue.loadFile {id: "m2.mp3", src: "m2.mp3"}, false
		# queue.loadFile {id: "m3.mp3", src: "m3.mp3"}, false
		# queue.loadFile {id: "bg.mp3", src: "bg.mp3"}, false
		queue.loadFile id: imageFile, src: imageFile, false for imageFile in cardImages
		
		queue.load()

	_createCardContainer: (image, health, attack, level)->
		container = new createjs.Container()
		card = new createjs.Bitmap image
		container.addChild card

		if not card.getBounds()?
			console.log image

		shape = new createjs.Shape()
		shape.graphics = new createjs.Graphics().beginFill("rgba(255,255,255,1)").drawRoundRect(0, 0, card.getBounds().width, card.getBounds().height, 10)
		card.mask = shape

		textHealth = new createjs.Text health, "24px Arial", "#ffffff"
		container.addChild textHealth

		textHealth.y = container.getBounds().height * 0.85
		textHealth.x = 10

		textAttack = new createjs.Text attack, "24px Arial", "#ffffff"
		container.addChild textAttack

		textAttack.y = container.getBounds().height * 0.85
		textAttack.x = container.getBounds().width * 0.8

		container