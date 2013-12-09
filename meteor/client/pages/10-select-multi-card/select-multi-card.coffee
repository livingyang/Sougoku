
keyCardIdAndCountMap = "keyCardIdAndCountMap"

getCountMap = ->
	(Session.get keyCardIdAndCountMap) ? {}

setCountMap = (cardIdAndCountMap) ->
	Session.set keyCardIdAndCountMap, cardIdAndCountMap

addCardId = (cardId, maxCount = 1) ->
	cardIdAndCountMap = getCountMap()
	cardIdAndCountMap[cardId] ?= 0
	if cardIdAndCountMap[cardId] < maxCount
		++cardIdAndCountMap[cardId]
	else
		cardIdAndCountMap[cardId] = maxCount
	setCountMap cardIdAndCountMap

removeCardId = (cardId) ->
	cardIdAndCountMap = getCountMap()
	--cardIdAndCountMap[cardId] if cardIdAndCountMap[cardId] >= 1
	setCountMap cardIdAndCountMap

class @SelectMultiCardController extends RouteController
	data: ->
		detailUserCardList = UserCardCollection.getDetailUserCardList()
		cardIdAndCountMap = getCountMap()
		userCards: (for detailUserCard in detailUserCardList when cardIdAndCountMap[detailUserCard.card._id]?
			detailUserCard.selectedCount = cardIdAndCountMap[detailUserCard.card._id]
			detailUserCard)
		
@GotoSelectMultiCardPage = (options) ->
	setCountMap options.cardIdAndCountMap
	Router.go "selectMultiCard", null, options

Template.selectMultiCard.events "click #cancel": ->
	console.log Router.current().options

	if Router.current().options.onCancel?
		Router.current().options.onCancel()
	else
		Router.go "/"

Template.selectMultiCard.events "click #ok": ->
	Router.current().options.onSelectCardList? getCountMap()
	
Template.selectMultiCard.events "click .btn-plus": ->
	addCardId @card._id, @count

Template.selectMultiCard.events "click .div-user-card": ->
	addCardId @card._id, @count

Template.selectMultiCard.events "click .btn-minus": ->
	removeCardId @card._id
