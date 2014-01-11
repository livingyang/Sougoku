###
setBossUpdater
###

lastInterval = null

setBossUpdater = (updater) ->
	Meteor.clearInterval lastInterval

	if updater?
		lastInterval = Meteor.setInterval updater, 1000

###
class @BossListController 
###

class @BossListController extends RouteController
	unload: ->
		setBossUpdater null

	data: ->
		bossList = BossCollection.getBossList()
		for boss in bossList
			boss.disappearTimeFromNow = @getDisappearTimeFromNow boss.disappearTime

		setBossUpdater =>
			console.log "Meteor.setInterval"
			for boss in bossList
				$("##{boss._id}").text @getDisappearTimeFromNow boss.disappearTime
			
		bossList: bossList

	getDisappearTimeFromNow: (disappearTime) ->
		disappearTimeFromNow = disappearTime - Date.now()
		disappearTimeFromNow = 0 if disappearTimeFromNow < 0
		moment.utc(disappearTimeFromNow).format "HH:mm:ss"
		
Template.bossList.events "click #addBoss": ->
	BossCollection.addBoss 1, Math.ceil Math.random() * 10

Template.bossList.events "click .attackBoss": ->
	BossCollection.defeatBoss @_id

Template.bossList.events "click .removeBoss": ->
	BossCollection.remove _id: @_id