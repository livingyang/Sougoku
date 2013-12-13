###
@CardCollection 卡牌的基础信息集合
###

@CardCollection = CreateCollectionFromPublicCsv "csv/1-human.csv"

CardCollection.getCard = (cardId) ->
	@findOne _id: String cardId

CardCollection.getIsOpenCursor = ->
	@find isOpen: "1"

CardCollection.randomOpenCard = ->
	Random.choice @getIsOpenCursor().fetch()

###
@UserCardCollection 属于用户的卡牌信息集合
_id: 用户id
其他键为对应的cardId，记录的信息
example:
{
	_id: userId,
	"1": {
		totalCount: 10,
		count: 5,
		exp: 0,
		mergeCount: 0
	}
}
###

@UserCardCollection = new Meteor.Collection "userCards"

UserCardCollection.getUserCardMap = (userId = Meteor.userId()) ->
	result = (@findOne _id: userId) ? {}
	delete result._id
	result

UserCardCollection.getDetailUserCardList = (userId = Meteor.userId()) ->
	for cardId, userCard of @getUserCardMap userId when (CardCollection.getCard cardId)?
		@getDetailUserCard userCard, CardCollection.getCard cardId

UserCardCollection.incUserCard = (cardId, incObj, userId = Meteor.userId()) ->
	updater = {}
	for k, v of incObj
		updater["#{cardId}.#{k}"] = v
	@update {_id: userId}, {$inc: updater}, {upsert: true}

UserCardCollection.addUserCard = (cardId, userId = Meteor.userId()) ->
	@incUserCard cardId, count: 1, totalCount: 1, userId

UserCardCollection.removeUserCard = (cardId, count, userId = Meteor.userId()) ->
	@incUserCard cardId, count: -count, userId
	
UserCardCollection.getDetailUserCard = (userCard, card) ->
	
	userCard.card = card
	
	userCard.exp ?= 0
	userCard.mergeCount ?= 0

	userCard.level = CardHelper.getLevelFromExp userCard.exp
	userCard.maxLevel = CardHelper.getMaxLevel (Number card.star), userCard.mergeCount
	userCard.limitLevel = CardHelper.getLimitLevel userCard.level, userCard.maxLevel
	userCard.compoundExp = CardHelper.getBaseExp card.star
	userCard.health = CardHelper.getLevelUpValue card.health, userCard.level, card.upHealth
	userCard.attack = CardHelper.getLevelUpValue card.attack, userCard.level, card.upAttack
	userCard

UserCardCollection.getDetailUserCardFromCardId = (cardId, userId = Meteor.userId()) ->
	userCard = @getUserCard cardId, userId
	card = CardCollection.getCard cardId
	if userCard? and card?
		@getDetailUserCard userCard, card
	else
		null

UserCardCollection.getUserCard = (cardId, userId = Meteor.userId()) ->
	(@getUserCardMap userId)[cardId]

UserCardCollection.compoundCard = (mainCardId, foodCardIdAndCountMap, userId = Meteor.userId()) ->
	totalExp = 0
	updater = {}
	for cardId, userCard of @getUserCardMap userId when foodCardIdAndCountMap[cardId]? and (CardCollection.getCard cardId)?
		card = CardCollection.getCard cardId

		compoundCount = if foodCardIdAndCountMap[cardId] < userCard.count
		then foodCardIdAndCountMap[cardId]
		else userCard.count
		totalExp += compoundCount * CardHelper.getBaseExp card.star
		updater["#{cardId}.count"] = -compoundCount

	updater["#{mainCardId}.exp"] = totalExp

	if foodCardIdAndCountMap[mainCardId] > 0
		updater["#{mainCardId}.mergeCount"] = foodCardIdAndCountMap[mainCardId]
	
	@update {_id: userId}, {$inc: updater}, {upsert: true}

