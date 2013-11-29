@CardCollection = CreateCollectionFromCsv "csv/1-human.csv", (isSuccess, collection) ->
	console.log isSuccess
	console.log "card count: #{collection.find().count()}"