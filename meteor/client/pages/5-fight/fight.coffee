Template.fight.events "click canvas": ->
	alert "click"

class @FightController extends RouteController
	template: "fight"

	before: ->
		console.log "before"

	after: ->
		console.log Session.get "lastFight"

	run: ->
		console.log "run"
		super

	data: ->
		canvasWidth: document.body.scrollWidth
		canvasHeight: document.body.scrollHeight

Meteor.startup ->
	Session.set "lastFight", {data: "ddd"}