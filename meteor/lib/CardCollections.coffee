TestCollection = CreateCollectionFromCsv "csv/1-human.csv", (isSuccess, collection) ->
	console.log isSuccess
	console.log collection.find().fetch()