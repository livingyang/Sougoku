@BossCollection = new Meteor.Collection "boss"

BossCollection.getDelayMinutesTime = (delayMinutes) ->
	result = new Date()
	result.setMinutes result.getMinutes() + delayMinutes
	result

BossCollection.addBoss = (bossCardId, level, userId = Meteor.userId()) ->
	@insert
		bossCardId: bossCardId
		userId: userId
		disappearTime: @getDelayMinutesTime 3
		level: level

BossCollection.getBossList = (userId = Meteor.userId()) ->
	(@find userId: userId).fetch()