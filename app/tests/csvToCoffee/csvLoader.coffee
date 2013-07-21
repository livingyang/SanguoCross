convertCsvToJsonArray = (csvArray, headerRowIndex, typeRowIndex, startFieldRowIndex) ->

	csvArray = [] if csvArray not instanceof Array
	headerRowIndex = 2 if headerRowIndex not instanceof Number
	typeRowIndex = 1 if typeRowIndex not instanceof Number
	startFieldRowIndex = 3 if startFieldRowIndex not instanceof Number

	result = (convertCsvRowToJson csvArray[headerRowIndex], fields, csvArray[typeRowIndex] for fields in csvArray[startFieldRowIndex..])

convertCsvField = (field, type) ->
	switch type
		when "number" then Number(field)
		when "bool" then Boolean(Number(field))
		else String(field)

convertCsvRowToJson = (csvHeaders, csvFields, csvFieldTypes) ->
	result = {}
	(result[header] = convertCsvField csvFields[i], csvFieldTypes[i] for header, i in csvHeaders if csvHeaders.length is csvFields.length)
	result

insertDocumentsToCollection = (collection, csvFilePath) ->
	fs = Npm.require("fs")
	documents = convertCsvToJsonArray (fs.readFileSync csvFilePath).toString().csvToArray({rSep:"\n"}) if fs.existsSync(csvFilePath)
	if collection.find().count() is 0
		collection.insert aDocument for aDocument in documents
		console.log "#{documents.length} document inserted to collection: #{collection._name}, from file: #{csvFilePath}"
	else
		console.log "cannot insert document from file: #{csvFilePath} because collection: #{collection._name} is not empty"
	collection

@insertDocumentsToCollection = insertDocumentsToCollection
