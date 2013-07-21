fs = require "fs"
require "./csvToArray.v2.1.js"

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

getJsonArrayFromCsv = (csvFilePath) ->
	(convertCsvToJsonArray (fs.readFileSync csvFilePath).toString().csvToArray({"rSep" : "\n"}))

isCsvFilePath = (csvFilePath) ->
	csvFilePath.slice(-4) is ".csv"

getFileName = (filePath) ->
	filePath.replace(/^.*[\\\/]/, '')

getCsvFileName = (csvFilePath) ->
	getFileName(csvFilePath).replace ".csv", ""

getCoffeeSaveData = (csvFilePath) ->
	filename = getCsvFileName(csvFilePath)

	if isCsvFilePath csvFilePath
	then "\n#{filename} = #{JSON.stringify(getJsonArrayFromCsv(csvFilePath))}\n@#{filename} = #{filename}\n"
	else ""

convertDirCsvToCoffee = (csvDir, coffeeFilePath) ->
	fs.writeFileSync coffeeFilePath, "# created by #{getFileName process.argv[1]}\n"
	fs.readdirSync(csvDir).forEach (filename) ->
		filePath = csvDir + filename
		if isCsvFilePath(filePath)
			console.log "convert csv file : #{filePath}"
			fs.appendFileSync coffeeFilePath, getCoffeeSaveData(filePath)

convertDirCsvToCoffee "./csv/", "../../lib/lib/CsvData.coffee"