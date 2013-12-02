Template.myCards.userCards = ->
	userCards = (UserCardCollection.find {}).fetch()
	for userCard in userCards
		# add base info
		_.defaults userCard, CardCollection.getCard userCard.cardId
		userCard.level = CardHelper.getLevelFromExp userCard.exp

	userCards

Template.myCards.events "click #addCard": ->
	UserCardCollection.addRandomCard()

Template.myCards.events "click #compoundCard": ->
	mainCard = UserCardCollection.findOne {}
	foodCard = UserCardCollection.findOne {}, skip: 1

	UserCardCollection.compoundCard mainCard._id, [foodCard._id]

