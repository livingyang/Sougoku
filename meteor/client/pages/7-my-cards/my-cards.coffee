
class @MyCardsController extends RouteController
	data: ->
		userCards: UserCardCollection.getDetailUserCardList()

Template.myCards.events "click .div-user-card": ->
	GotoCompoundCardPage @card._id
