@CardCollection = CreateCollectionFromPublicCsv "csv/1-human.csv"

CardCollection.getIsOpenCursor = ->
	@find(isOpen: "1")

Meteor.startup ->
	console.log CardCollection.getIsOpenCursor().count()
