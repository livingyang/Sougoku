@CardCollection = CreateCollectionFromPublicCsv "csv/1-human.csv"

CardCollection.getIsOpenCursor = ->
	@find isOpen: "1"

Meteor.startup ->
	# console.log  getExpFromLevel 1
	# console.log  getExpFromLevel 2

	# console.log getLevelFromExp 101, 0, 10
