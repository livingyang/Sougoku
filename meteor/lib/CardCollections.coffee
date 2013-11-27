
@CardCollections = new JsonLoader
	path: "csv/1-human.json"
	indexName: "id"
	onComplete: (loader) ->
		console.log loader