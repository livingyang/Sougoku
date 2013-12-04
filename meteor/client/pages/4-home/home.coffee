Template.home.events "click #selectOneCard": ->
	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			console.log userCardId
			Router.go "home"
		onCancel: ->
			Router.go "home"

class @HomeController extends RouteController
	before: ->
		console.log "home before"
