Template.home.events "click #fight": ->
	# alert "click"
	fight = {turn: [2, 4]}
	Router.go "fight", data : JSON.stringify fight

class @HomeController extends RouteController
	before: ->
		console.log "home before"
