class @CompoundCardController extends RouteController
	data: ->
		mainUserCard: UserCardCollection.getDetailUserCard @options.mainUserCardId
		foodUserCardList: UserCardCollection.getDetailUserCard userCardId for userCardId in @options.foodUserCardIdList or []

@GotoCompoundCardPage = (mainUserCardId, foodUserCardIdList) ->
	Router.go "compoundCard", null, mainUserCardId: mainUserCardId, foodUserCardIdList: foodUserCardIdList

Template.compoundCard.events "click #selectMainCard": ->
	# alert "selectMainCard"
	oldMainUserCardId = Router.current().options.mainUserCardId
	oldFoodUserCardIdList = Router.current().options.foodUserCardIdList ? []

	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			# alert userCardId
			# Router.go "home"
			GotoCompoundCardPage userCardId, _.without oldFoodUserCardIdList, userCardId
		onCancel: ->
			# Router.go "home"
			GotoCompoundCardPage oldMainUserCardId, oldFoodUserCardIdList

Template.compoundCard.events "click #selectFoodCard": ->
	# alert "selectFoodCard"

	oldMainUserCardId = Router.current().options.mainUserCardId
	oldFoodUserCardIdList = Router.current().options.foodUserCardIdList ? []
	
	selectedList = {}

	for userCard in UserCardCollection.getTotalDetailUserCard()
		selectedList[userCard._id] = false

	for userCardId in oldFoodUserCardIdList
		selectedList[userCardId] = true

	delete selectedList[oldMainUserCardId]

	GotoSelectMultiCardPage 
		userCardIdWithSelectedList: selectedList
		onSelectCardList: (userCardIdWithSelectedList) ->
			# alert JSON.stringify userCardIdWithSelectedList
			# Router.go "home"
			GotoCompoundCardPage oldMainUserCardId, (userCardId for userCardId, isSelected of userCardIdWithSelectedList when isSelected)
		onCancel: ->
			# Router.go "home"
			GotoCompoundCardPage oldMainUserCardId, oldFoodUserCardIdList