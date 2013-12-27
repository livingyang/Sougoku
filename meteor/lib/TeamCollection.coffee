###
@TeamCollection 记录用户的队伍信息
_id: 用户id
其他键为对应的cardId的上阵次数

example:
	{_id: "xxxx", 1: 1, 4: 2}
	用户xxxx的队伍信息，已经上阵1号卡牌1张，4号卡牌2张
###

@TeamCollection = new Meteor.Collection "team"

TeamCollection.setTeam = (teamCardIdAndCountMap, userId = Meteor.userId()) ->
	@update {_id: userId}, {$set: teamCardIdAndCountMap}, {upsert: true}

TeamCollection.getTeam = (userId = Meteor.userId()) ->
	_.omit (@findOne _id: userId), "_id"