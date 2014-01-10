class @BossListController extends RouteController
	data: ->
		bossList: BossCollection.getBossList()


Template.bossList.events "click #addBoss": ->
	BossCollection.addBoss 1, Math.ceil Math.random() * 10

Template.bossList.events "click .removeBoss": ->
	BossCollection.remove _id: @_id