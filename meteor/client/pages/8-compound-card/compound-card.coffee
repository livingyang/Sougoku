class @CompoundCardController extends RouteController
	data: ->
		mainUserCard = UserCardCollection.getDetailUserCard @options.mainUserCardId
		foodUserCardList = (UserCardCollection.getDetailUserCard userCardId for userCardId in @options.foodUserCardIdList ? [])

		mainUserCard: mainUserCard
		foodUserCardList: foodUserCardList
		isReady: @options.mainUserCardId? and @options.foodUserCardIdList?.length > 0
		hasMerge: _.contains (foodUserCard.card._id for foodUserCard in foodUserCardList), mainUserCard?.card._id

@GotoCompoundCardPage = (mainUserCardId, foodUserCardIdList) ->
	Router.go "compoundCard", null, mainUserCardId: mainUserCardId, foodUserCardIdList: foodUserCardIdList ? []

Template.compoundCard.events "click #selectMainCard": ->
	oldMainUserCardId = Router.current().options.mainUserCardId
	oldFoodUserCardIdList = Router.current().options.foodUserCardIdList ? []

	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			GotoCompoundCardPage userCardId, _.without oldFoodUserCardIdList, userCardId
		onCancel: ->
			GotoCompoundCardPage oldMainUserCardId, oldFoodUserCardIdList

Template.compoundCard.events "click #selectFoodCard": ->
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
			GotoCompoundCardPage oldMainUserCardId, (userCardId for userCardId, isSelected of userCardIdWithSelectedList when isSelected)
		onCancel: ->
			GotoCompoundCardPage oldMainUserCardId, oldFoodUserCardIdList

Template.compoundCard.events "click #compound": ->
	UserCardCollection.compoundCard @mainUserCard._id, (foodUserCard._id for foodUserCard in @foodUserCardList)
	GotoCompoundCardPage @mainUserCard._id
