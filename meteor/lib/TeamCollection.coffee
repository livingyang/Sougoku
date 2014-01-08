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

TeamCollection.getComboList = (userId = Meteor.userId()) ->
	teamCardIdList = (cardId for cardId, count of @getTeam() when count > 0)
	ComboCollection.getActiveComboList teamCardIdList
	
TeamCollection.generateFightData = (userId = Meteor.userId()) ->
	
	# 1 cardFightArray
	userCardMap = UserCardCollection.getUserCardMap()
	
	cardFightArray = []
	for cardId, count of @getTeam()
		userCard = UserCardCollection.getDetailUserCard userCardMap[cardId], CardCollection.getCard cardId
		for i in [0...count]
			cardFightArray.push
				health: userCard.health
				attack: userCard.attack
				skill1: SkillCollection.getFightSkill userCard.card.skillId1
				skill2: SkillCollection.getFightSkill userCard.card.skillId2

	# 2 team health and attack
	teamHealth = 0
	teamAttack = 0

	for cardFight in cardFightArray
		teamHealth += cardFight.health
		teamHealth += SkillCollection.getSkillUpHealth cardFight.skill1, cardFight.health
		teamHealth += SkillCollection.getSkillUpHealth cardFight.skill2, cardFight.health

		teamAttack += cardFight.attack
		teamAttack += SkillCollection.getSkillUpAttack cardFight.skill1, cardFight.attack
		teamAttack += SkillCollection.getSkillUpAttack cardFight.skill2, cardFight.attack

	# 3 combo data
	comboList = @getComboList()

	comboUpHealthPercent = 0
	comboUpAttackPercent = 0
	for combo in comboList
		comboUpHealthPercent += Number combo.upPercent if (combo.type.match "h")?
		comboUpAttackPercent += Number combo.upPercent if (combo.type.match "a")?
	

	cardFightArray: cardFightArray
	teamHealth: teamHealth
	teamAttack: teamAttack
	comboList: comboList
	comboUpHealthPercent: comboUpHealthPercent
	comboUpAttackPercent: comboUpAttackPercent
	finalHealth: teamHealth + teamHealth * comboUpHealthPercent / 100
	finalAttack: teamAttack + teamAttack * comboUpAttackPercent / 100
