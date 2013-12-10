###
@MixCollection 炼成的基础信息集合
###

@MixCollection = CreateCollectionFromPublicCsv "csv/15-mix.csv"

MixCollection.getMixObject = (type, id) ->
	switch type
		when "C"
			_.defaults (CardCollection.getCard id), (UserCardCollection.getUserCard id)
		when "M"
			_.defaults (MaterialCollection.getMaterial id), (UserMaterialCollection.getUserMaterial id)
		else
			console.log "Error MixCollection.getMixObject type: #{type} id: #{id}"
			null

MixCollection.parseMixTarget = (mixTarget, userId = Meteor.userId()) -> 
	_.defaults mixTarget, @getMixObject mixTarget.type, mixTarget.targetId
	
	mixTarget.mixPartList = (for mixPart in mixTarget.mixPartList.split " " when (mixPart.split ":").length is 3
		[type, id, needCount] = mixPart.split ":"
		mixObject = @getMixObject type, id
		mixObject.needCount = needCount
		mixObject.count ?= 0
		mixObject.type = type
		mixObject.partId = id

		# if not add this, it will casue crash, I dont know why
		delete mixObject._id

		mixObject)
	
	mixTarget.canMix = MixCollection.canMix mixTarget
	mixTarget.count ?= 0

	mixTarget

MixCollection.getMixList = (userId = Meteor.userId()) ->
	@parseMixTarget mixTarget, userId for mixTarget in MixCollection.find().fetch()

MixCollection.canMix = (mixTarget) ->
	canMix = true
	canMix and= (mixPart.count >= mixPart.needCount) for mixPart in mixTarget.mixPartList
	canMix

MixCollection.mix = (type, targetId, userId = Meteor.userId()) ->
	mixTarget = @parseMixTarget (@findOne type: type, targetId: targetId), userId
	return if not @canMix mixTarget

	switch type
		when "C"
			UserCardCollection.addUserCard targetId
		when "M"
			UserMaterialCollection.addMaterial targetId

	for mixPart in mixTarget.mixPartList
		switch mixPart.type
			when "C"
				UserCardCollection.removeUserCard mixPart.partId, mixPart.needCount
			when "M"
				UserMaterialCollection.removeMaterial mixPart.partId, mixPart.needCount

