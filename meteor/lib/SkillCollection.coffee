###
@SkillCollection 技能的基础信息集合
###

@SkillCollection = CreateCollectionFromPublicCsv "csv/17-skill.csv"

SkillCollection.getSkill = (skillId) ->
	@findOne _id: skillId
