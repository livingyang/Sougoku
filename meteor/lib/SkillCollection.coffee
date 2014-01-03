###
@SkillCollection 技能的基础信息集合
###

@SkillCollection = CreateCollectionFromPublicCsv "csv/17-skill.csv"

SkillCollection.getSkill = (skillId) ->
	@findOne _id: skillId

SkillCollection.getFightSkill = (skillId) ->
	skill = @getSkill skillId
	skill?.isActive = Math.random() * 100 < skill.probability
	skill

SkillCollection.getSkillUpHealth = (fightSkill, baseHealth) ->
	if fightSkill?.isActive and (fightSkill.type.match "h")? and baseHealth > 0
	then baseHealth * fightSkill.probability / 100
	else 0

SkillCollection.getSkillUpAttack = (fightSkill, baseAttack) ->
	if fightSkill?.isActive and (fightSkill.type.match "a")? and baseAttack > 0
	then baseAttack * fightSkill.probability / 100
	else 0
