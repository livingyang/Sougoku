Template.cardList.cardList = -> 
	CardCollection.getIsOpenCursor()

Template.card.events "click .img-card": ->
	alert @_id
