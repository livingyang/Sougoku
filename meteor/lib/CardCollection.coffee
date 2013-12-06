###
@CardCollection 卡牌的基础信息集合
###

@CardCollection = CreateCollectionFromPublicCsv "csv/1-human.csv"

CardCollection.getCard = (cardId) ->
	@findOne _id: cardId

CardCollection.getIsOpenCursor = ->
	@find isOpen: "1"

CardCollection.randomOpenCard = ->
	Random.choice @getIsOpenCursor().fetch()

###
@UserCardCollection 属于用户的卡牌信息集合
###

@UserCardCollection = new Meteor.Collection "userCards"

UserCardCollection.getUserCard = (userCardId) ->
	@findOne _id: userCardId

UserCardCollection.getDetailUserCard = (userCardIdOrUserCard) ->
	userCard = if typeof userCardIdOrUserCard is "string" then @getUserCard userCardIdOrUserCard else userCardIdOrUserCard
	return if typeof userCard isnt "object"

	card = CardCollection.getCard userCard.cardId
	card.star = CardHelper.getStar card.rare

	userCard.level = CardHelper.getLevelFromExp userCard.exp
	userCard.limitMaxLevel = CardHelper.getLimitMaxLevel (Number card.maxLevel), (Number card.mergeMaxLevel), (Number userCard.mergeCount)
	userCard.limitLevel = CardHelper.getLimitLevel userCard.level, userCard.limitMaxLevel
	userCard.compoundExp = @getCompoundExp userCard, card
	
	userCard.card = card
	userCard

UserCardCollection.getTotalDetailUserCard = ->
	for userCard in @find().fetch()
		@getDetailUserCard userCard

UserCardCollection.getCompoundExp = (userCard, card = CardCollection.getCard userCard.cardId) ->
	(userCard.exp ? 0) + CardHelper.getBaseExpFromRare card.rare

if Meteor.isServer
	UserCardCollection.addUserCard = (userId, cardId) ->
		UserCardCollection.insert
			userId: userId
			cardId: cardId
			exp: 0
			mergeCount: 0

	Meteor.methods addRandomCard: ->
		card = CardCollection.randomOpenCard()
		UserCardCollection.addUserCard @userId, card._id

	Meteor.methods compoundCard: (mainUserCardId, foodUserCardIdList) ->

		# 检查是否合法
		return if foodUserCardIdList.length <= 0 or _.contains foodUserCardIdList, mainUserCardId

		# 检查 mainUserCardId是否属于玩家
		mainUserCard = UserCardCollection.getUserCard mainUserCardId
		return if mainUserCard?.userId isnt @userId

		# 获取所有用户卡牌信息
		foodUserCards = (UserCardCollection.getUserCard foodUserCardId for foodUserCardId in foodUserCardIdList)

		# 获取合成经验
		incObj = exp: 0, mergeCount: 0
		for foodUserCard in foodUserCards when foodUserCard.userId is @userId
			incObj.exp += UserCardCollection.getCompoundExp foodUserCard
			++incObj.mergeCount if foodUserCard.cardId is mainUserCard.cardId
			UserCardCollection.remove _id: foodUserCard._id

		UserCardCollection.update {_id: mainUserCardId}, {$inc: incObj}

if Meteor.isClient
	UserCardCollection.addRandomCard = ->
		Meteor.call "addRandomCard", (error, result) ->
			console.log result

	UserCardCollection.compoundCard = (mainUserCardId, foodUserCardIdList) ->
		Meteor.call "compoundCard", mainUserCardId, foodUserCardIdList, (error, result) ->
			console.log result

