@FightDoneCallback = FightDoneCallback = ->
	Router.go "home"

# Template.fight.events "click canvas": ->
	# console.log document.getElementById "fight-canvas"

class @FightController extends RouteController
	template: "fight"

	before: ->

		Template[@template].rendered = ->
			console.log "rendered"
			console.log document.getElementById "fight-canvas"
			
			stage = new createjs.Stage("fight-canvas");
			# //Create a Shape DisplayObject.
			circle = new createjs.Shape();
			circle.graphics.beginFill("red").drawCircle(0, 0, 40);
			# //Set position of Shape instance.
			circle.x = circle.y = 50;
			# //Add Shape instance to stage display list.
			stage.addChild(circle);
			# //Update stage will render next frame
			stage.update();


		console.log "before"

	# after: ->
	# 	console.log "fight after"

		# stage = new createjs.Stage "#fight-canvas"
		# createjs.Ticker.addEventListener "tick", stage
		# createjs.Ticker.setFPS(60)

		# lab = new createjs.Text "000", "bold 36px Arial", "red"
		# stage.addChild lab
		# lab.set x: 200, y : 100
		# console.log document.getElementById "fight-canvas"
	

		# Template.fight.events "click canvas": ->
		# 	alert "click"
		# 	Router.go "home"

		# try
		# 	fightData = JSON.parse @params.data
		# catch e
		# 	FightDoneCallback()
		# 	console.log "parse fightData error, @params.data: #{@params.data}"
		
	# run: ->
	# 	super

	data: ->
		canvasWidth: document.body.scrollWidth
		canvasHeight: document.body.scrollHeight