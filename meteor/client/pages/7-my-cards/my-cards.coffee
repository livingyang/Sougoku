Template.myCards.userCards = -> UserCardCollection.getTotalDetailUserCard()

Template.myCards.events "click .div-user-card": ->
	GotoCompoundCardPage @_id
