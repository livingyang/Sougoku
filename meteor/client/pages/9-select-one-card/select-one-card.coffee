class @SelectOneCardController extends RouteController
	data: ->
		userCards: UserCardCollection.getTotalDetailUserCard()

@GotoSelectOneCardPage = (options) ->
	Router.go "selectOneCard", null, options


Template.selectOneCard.events "click #cancel": ->
	Router.current().options.onCancel?()

Template.selectOneCard.events "click .card-icon": ->
	Router.current().options.onSelectCard? @_id