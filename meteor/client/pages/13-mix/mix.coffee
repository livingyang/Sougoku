class @MixController extends RouteController
	data: ->
		userCardMap = UserCardCollection.getUserCardMap()
		userMaterial = UserMaterialCollection.getMaterialIdAndCountMap()

		console.log userCardMap
		console.log userMaterial

		mixTargetList = MixCollection.getMixList()
		for mixTarget in mixTargetList
			mixTarget.canMix = MixCollection.canMix mixTarget
		# mixTarget.count = @getMixObjectCurrentCount type, id, userId

			for mixPart in mixTarget.mixPartList
				# mixPart.count = MixCollection.getMixObjectCurrentCount mixPart.type, mixPart._id
				switch mixPart.type
					when "C"
						mixPart.count = userCardMap[mixPart._id]?.count ? 0
					when "M"
						mixPart.count = userMaterial[mixPart._id]?.count ? 0
				
			

		mixTargetList: mixTargetList

Template.mix.events "click .mix-btn": ->
	# alert "mix click"
	MixCollection.mix @type, @targetId
