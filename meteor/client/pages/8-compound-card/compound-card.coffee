class @CompoundCardController extends RouteController
	data: ->
		mainUserCard = UserCardCollection.getDetailUserCardFromCardId @options.mainCardId
		
		totalCount = 0
		totalExp = 0
		foodUserCardList = (for foodUserCard in UserCardCollection.getDetailUserCardList() when @options.cardIdAndCountMap?[foodUserCard.card._id] > 0
			foodUserCard.selectedCount = @options.cardIdAndCountMap[foodUserCard.card._id]
			totalCount += foodUserCard.selectedCount
			totalExp += foodUserCard.compoundExp * foodUserCard.selectedCount
			foodUserCard
		)

		mainUserCard: mainUserCard
		totalCount: totalCount
		totalExp: totalExp
		foodUserCardList: foodUserCardList
		isReady: @options.mainCardId? and totalCount > 0
		hasMerge: _.contains (foodUserCard.card._id for foodUserCard in foodUserCardList), mainUserCard?.card._id

@GotoCompoundCardPage = (mainCardId, cardIdAndCountMap) ->
	Router.go "compoundCard", null, mainCardId: mainCardId, cardIdAndCountMap: cardIdAndCountMap

Template.compoundCard.events "click #selectMainCard": ->
	oldMainCardId = Router.current().options.mainCardId
	oldCardIdAndCountMap = Router.current().options.cardIdAndCountMap

	GotoSelectOneCardPage
		onSelectCard: (userCardId) ->
			GotoCompoundCardPage userCardId, oldCardIdAndCountMap
		onCancel: ->
			GotoCompoundCardPage oldMainCardId, oldCardIdAndCountMap

Template.compoundCard.events "click #selectFoodCard": ->
	oldMainCardId = Router.current().options.mainCardId
	oldCardIdAndCountMap = Router.current().options.cardIdAndCountMap

	if not oldCardIdAndCountMap?
		oldCardIdAndCountMap = {}
		for cardId, userCard of UserCardCollection.getUserCardMap() when userCard.count > 0
			oldCardIdAndCountMap[cardId] = 0
		oldCardIdAndCountMap

	GotoSelectMultiCardPage 
		cardIdAndCountMap: oldCardIdAndCountMap
		onSelectCardList: (cardIdAndCountMap) ->
			GotoCompoundCardPage oldMainCardId, cardIdAndCountMap
		onCancel: ->
			GotoCompoundCardPage oldMainCardId, oldCardIdAndCountMap

Template.compoundCard.events "click #compound": ->
	
	foodCardIdAndCountMap = {}
	for foodUserCard in @foodUserCardList
		foodCardIdAndCountMap[foodUserCard.card._id] = foodUserCard.selectedCount
	
	UserCardCollection.compoundCard @mainUserCard.card._id, foodCardIdAndCountMap
	GotoCompoundCardPage()
