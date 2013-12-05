Template.home.events "click #selectOneCard": ->
	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			alert userCardId
			Router.go "home"
		onCancel: ->
			Router.go "home"

Template.home.events "click #selectMultiCard": ->
	selectedList = {}
	for userCard in UserCardCollection.getTotalDetailUserCard()
		selectedList[userCard._id] = true

	GotoSelectMultiCardPage 
		userCardIdWithSelectedList: selectedList
		onSelectCardList: (userCardIdWithSelectedList) ->
			alert JSON.stringify userCardIdWithSelectedList
			Router.go "home"
		onCancel: ->
			Router.go "home"
			
