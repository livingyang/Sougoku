###
@MaterialCollection 卡牌的基础信息集合
###

@MaterialCollection = CreateCollectionFromPublicCsv "csv/12-material.csv"

MaterialCollection.getIsOpenCursor = ->
	@find isOpen: "1"

@UserMaterialCollection = new Meteor.Collection "userMaterial"

UserMaterialCollection.addMaterial = (materialId) ->
	updater = {}
	updater[materialId] = 1
	console.log updater
	@update {_id: Meteor.userId()}, {$inc: updater}, {upsert: true}

UserMaterialCollection.getUserMaterialCount = ->
	@findOne _id: Meteor.userId()
