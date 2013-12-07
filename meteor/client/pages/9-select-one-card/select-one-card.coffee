class @SelectOneCardController extends RouteController
	data: ->
		userCards: UserCardCollection.getDetailUserCardList()

@GotoSelectOneCardPage = (options) ->
	Router.go "selectOneCard", null, options

Template.selectOneCard.events "click #cancel": ->
	console.log this
	if Router.current().options.onCancel?
		Router.current().options.onCancel()
	else
		Router.go "/"

Template.selectOneCard.events "click .div-user-card": ->
	Router.current().options.onSelectCard? @card._id