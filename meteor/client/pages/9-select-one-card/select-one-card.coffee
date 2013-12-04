class @SelectOneCardController extends RouteController
	data: ->
		userCards: UserCardCollection.getTotalDetailUserCard()

@GotoSelectOneCardPage = (options) ->
	Router.go "selectOneCard", null, options


Template.selectOneCard.events "click #cancel": ->
	if Router.current().options.onCancel?
		Router.current().options.onCancel()
	else
		Router.go "/"

Template.selectOneCard.events "click .card-icon": ->
	Router.current().options.onSelectCard? @_id