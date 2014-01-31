Template.home.rendered = ->
	$('#bg-home').layout
		east__size: .1

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
			
Template.home.events "click #btn-modal": ->

	data = data: Random.id()
	modal = $("#modal")
	modal.html(Template["home-modal"] data).modal()

	$("#home-ok").on "click", ->
		console.log data
		modal.modal "hide"

Template.home.events "click #fight-boss": ->
	FightBoss {}
