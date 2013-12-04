class @CompoundCardController extends RouteController
	run: ->
		super
		console.log this
	data: ->
		hasMainCard: @params.mainCardId?
		mainCard: UserCardCollection.getDetailUserCard @params.mainCardId
		t: 111