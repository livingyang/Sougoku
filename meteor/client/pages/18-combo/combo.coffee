class @ComboListController extends RouteController
	data: ->
		comboList = ComboCollection.find().fetch()
		for combo in comboList
			combo.cardList = (CardCollection.getCard cardId for cardId in combo.cardIdList.split " ")
		comboList: comboList
