Template.myCards.userCards = -> UserCardCollection.getTotalDetailUserCard()

Template.myCards.events "click .icon-card": ->
	console.log @_id
	Router.go "compoundCard", {}, {query: {test: "ttt", mainCardId: @_id}, callback: -> alert "aaa"}

Template.myCards.events "click #addCard": ->
	UserCardCollection.addRandomCard()

Template.myCards.events "click #compoundCard": ->
	mainCard = UserCardCollection.findOne {}
	foodCard = UserCardCollection.findOne {}, skip: 1

	UserCardCollection.compoundCard mainCard._id, [foodCard._id]

