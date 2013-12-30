###
@ComboCollection combo的基础信息集合
###

@ComboCollection = CreateCollectionFromPublicCsv "csv/16-combo.csv"

ComboCollection.isActiveCombe = (teamCardIdList, cardIdList) ->
	cardIdList.length is (_.intersection teamCardIdList, cardIdList).length

ComboCollection.getActiveComboIdList = (teamCardIdList) ->
	for combo in @find().fetch() when @isActiveCombe teamCardIdList, combo.cardIdList.split " "
		combo._id

ComboCollection.getActiveComboList = (teamCardIdList) ->
	combo for combo in @find().fetch() when @isActiveCombe teamCardIdList, combo.cardIdList.split " "
