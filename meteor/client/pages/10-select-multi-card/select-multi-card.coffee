
keySelectedUserIdList = "keySelectedUserIdList"

getList = ->
	(Session.get keySelectedUserIdList) ? {}

setList = (userCardIdWithSelectedList) ->
	Session.set keySelectedUserIdList, userCardIdWithSelectedList

selectUserCardId = (userCardId) ->
	userCardIdWithSelectedList = getList()
	userCardIdWithSelectedList[userCardId] = not userCardIdWithSelectedList[userCardId]
	setList userCardIdWithSelectedList

class @SelectMultiCardController extends RouteController
	data: ->
		userCards = for userCardId, isSelected of getList()
			userCard = UserCardCollection.getDetailUserCard userCardId
			userCard.isSelected = isSelected
			userCard
		userCards: userCards
		
@GotoSelectMultiCardPage = (options) ->
	setList options.userCardIdWithSelectedList
	Router.go "selectMultiCard", null, options


Template.selectMultiCard.events "click #cancel": ->
	console.log Router.current().options

	if Router.current().options.onCancel?
		Router.current().options.onCancel()
	else
		Router.go "/"

Template.selectMultiCard.events "click #ok": ->
	Router.current().options.onSelectCardList? getList()
	
Template.selectMultiCard.events "click .div-user-card": ->
	selectUserCardId @_id