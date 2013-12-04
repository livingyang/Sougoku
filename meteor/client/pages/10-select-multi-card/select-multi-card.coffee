
keySelectedUserIdList = "keySelectedUserIdList"

resetList = ->
	setList {}

getList = ->
	(Session.get keySelectedUserIdList) ? {}

setList = (userCardIdList) ->
	Session.set keySelectedUserIdList, userCardIdList

selectUserCardId = (userCardId) ->
	userCardIdList = getList()
	userCardIdList[userCardId] = not userCardIdList[userCardId]
	setList userCardIdList

class @SelectMultiCardController extends RouteController
	data: ->
		userCards = UserCardCollection.getTotalDetailUserCard()
		for userCard in userCards
			userCard.isSelected = Boolean getList()[userCard._id]

		userCards: userCards

@GotoSelectMultiCardPage = (options) ->
	resetList()
	Router.go "selectMultiCard", null, options


Template.selectMultiCard.events "click #cancel": ->
	if Router.current().options.onCancel?
		Router.current().options.onCancel()
	else
		Router.go "/"

Template.selectMultiCard.events "click #ok": ->
	Router.current().options.onSelectCardList? getList()
	
Template.selectMultiCard.events "click .card-icon": ->
	selectUserCardId @_id