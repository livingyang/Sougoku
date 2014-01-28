###
@MaterialCollection 卡牌的基础信息集合
###

@MaterialCollection = CreateCollectionFromPublicCsv "csv/12-material.csv"

MaterialCollection.getIsOpenCursor = ->
	@find isOpen: "1"

MaterialCollection.getMaterial = (materialId) ->
	@findOne _id: materialId

@UserMaterialCollection = new Meteor.Collection "userMaterial"

UserMaterialCollection.addMaterial = (materialId, userId = Meteor.userId()) ->
	updater = {}
	updater["#{materialId}.count"] = 1
	updater["#{materialId}.totalCount"] = 1
	console.log updater
	@update {_id: userId}, {$inc: updater}, {upsert: true}

UserMaterialCollection.removeMaterial = (materialId, count, userId = Meteor.userId()) ->
	updater = {}
	updater["#{materialId}.count"] = -count
	console.log updater
	@update {_id: userId}, {$inc: updater}, {upsert: true}

UserMaterialCollection.getMaterialIdAndCountMap = (userId = Meteor.userId()) ->
	_.omit (@findOne _id: userId), "_id"


UserMaterialCollection.getUserMaterial = (materialId, userId = Meteor.userId())->
	(@getMaterialIdAndCountMap userId)?[materialId]
