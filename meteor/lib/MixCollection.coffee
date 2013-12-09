###
@MixCollection 炼成的基础信息集合
###

@MixCollection = CreateCollectionFromPublicCsv "csv/15-mix.csv"

MixCollection.getMixObject = (type, id) ->
	switch type
		when "C"
			CardCollection.getCard id
		when "M"
			MaterialCollection.getMaterial id
		else
			console.log "Error MixCollection.getMixObject type: #{type} id: #{id}"
			null

MixCollection.getMixObjectCurrentCount = (type, id, userId = Meteor.userId()) ->
	switch type
		when "C"
			(UserCardCollection.getUserCard id, userId)?.count ? 0
		when "M"
			(UserMaterialCollection.getUserMaterial id, userId)?.count ? 0
		else
			console.log "Error MixCollection.getMixObjectCurrentCount type: #{type} id: #{id}"
			0

MixCollection.parseMixTarget = (mixTarget, userId = Meteor.userId()) -> 
	_.defaults mixTarget, @getMixObject mixTarget.type, mixTarget.targetId
	
	mixTarget.mixPartList = (for mixPart in mixTarget.mixPartList.split " " when (mixPart.split ":").length is 3
		[type, id, needCount] = mixPart.split ":"
		mixObject = @getMixObject type, id
		mixObject.needCount = needCount
		mixObject.type = type
		# mixObject.count = @getMixObjectCurrentCount type, id, userId
		# @getMixObjectCurrentCount type, id, userId
		mixObject)

	mixTarget

MixCollection.getMixList = (userId = Meteor.userId()) ->
	@parseMixTarget mixTarget, userId for mixTarget in MixCollection.find().fetch()

MixCollection.canMix = (mixTarget) ->
	canMix = true
	canMix and= (mixPart.count >= mixPart.needCount) for mixPart in mixTarget.mixPartList
	canMix
	true

MixCollection.mix = (type, targetId, userId = Meteor.userId()) ->
	# mixTarget = @parseMixTarget (@findOne type: type, targetId: targetId), userId
	# return if not @canMix mixTarget

	# console.log mixTarget
	switch type
		when "C"
			UserCardCollection.addUserCard targetId
		when "M"
			UserMaterialCollection.addMaterial targetId

	# for mixPart in mixTarget.mixPartList
	# 	switch mixPart.type
	# 		when "C"
	# 			UserCardCollection.removeUserCard mixPart._id, mixPart.needCount
	# 		when "M"
	# 			UserMaterialCollection.removeMaterial mixPart._id, mixPart.needCount


# Meteor.startup ->
	
# 	console.log MixCollection.getMixList() if Meteor.isClient
