Template.home.events "click #selectOneCard": ->
	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			alert userCardId
			Router.go "home"
		onCancel: ->
			Router.go "home"

Template.home.events "click #selectMultiCard": ->
	cardIdAndCountMap = {}
	for userCard in UserCardCollection.getDetailUserCardList()
		cardIdAndCountMap[userCard.card._id] = userCard.count

	GotoSelectMultiCardPage 
		cardIdAndCountMap: cardIdAndCountMap
		onSelectCardList: (cardIdAndCountMap) ->
			alert JSON.stringify cardIdAndCountMap
			Router.go "home"
		onCancel: ->
			Router.go "home"
			
