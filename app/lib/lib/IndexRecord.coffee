class IndexRecord
	constructor: (options) ->
		@records = options.array ? []
		@key = options.key ? ""
		@keyIndexes = {}
		for record, i in @records
			if not record[@key]?
				console.log "IndexRecord.constructor record: #{record}, hasn't key #{@key}"
				break
			if @keyIndexes[@key]?
				console.log "IndexRecord.constructor records, has same key #{@key}"
				break
			@keyIndexes[record[@key]] = i
		
	objectForKey: (key) -> @records[@keyIndexes[key]]

	randomKey: () -> @records[Math.floor((Math.random() * @records.length))][@key]
	randomObject: () -> @records[Math.floor((Math.random() * @records.length))]

	count: () -> @records.length

@IndexRecord = IndexRecord