class @CompoundCardController extends RouteController
	data: ->
		hasMainCard: @params.mainCardId?
		mainCard: UserCardCollection.getDetailUserCard @params.mainCardId
		t: 111