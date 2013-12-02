Template.myCards.userCards = ->
	for userCard in (UserCardCollection.find {}).fetch()
		UserCardCollection.getDetailUserCard userCard

Template.myCards.events "click .icon-card": ->
	console.log @_id
	Router.go "compoundCard", mainCardId: @_id

Template.myCards.events "click #addCard": ->
	UserCardCollection.addRandomCard()

Template.myCards.events "click #compoundCard": ->
	mainCard = UserCardCollection.findOne {}
	foodCard = UserCardCollection.findOne {}, skip: 1

	UserCardCollection.compoundCard mainCard._id, [foodCard._id]

