Template.myCards.userCards = -> UserCardCollection.getTotalDetailUserCard()

Template.myCards.events "click .icon-card": ->
	GotoCompoundCardPage @_id

Template.myCards.events "click #addCard": ->
	UserCardCollection.addRandomCard()
