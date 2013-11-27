Template.home.events "click #fight": ->
	fight = {turn: [2, 4]}
	Router.go "fight", data : JSON.stringify fight

Template.home.events "click #cardList": ->
	Router.go "cardList"

class @HomeController extends RouteController
	before: ->
		console.log "home before"
