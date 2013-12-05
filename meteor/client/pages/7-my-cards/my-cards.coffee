Template.myCards.userCards = -> UserCardCollection.getTotalDetailUserCard()

Template.myCards.events "click .icon-card": ->
	GotoCompoundCardPage @_id
