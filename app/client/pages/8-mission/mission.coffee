setPageNameToList "mission"

getHolderImage = (imageName) ->
	image = $(document.createElement("img")).attr("data-src" : imageName)
	Holder.run({
		images: image[0]
	})
	image.attr("src")

isPlayingMission = () ->
	collie.Renderer.isPlaying()

stopPlayMissionResult = () ->
	collie.Renderer.stop()
	collie.Renderer.removeAllLayer()
	collie.Renderer.unload()
	collie.Timer.removeAll()

playMissionResult = (elParent, totalPoint, starList) ->
	collie.ImageManager.add
		icon : getHolderImage("holder.js/50x50/text:明星") 


	layer = new collie.Layer
		width : 320
		height : 320

	ground = new collie.DisplayObject(
		x: "center"
		y: "center"
		width : 320
		height : 320
		backgroundColor : "gray"
	).addTo(layer);

	oText = new collie.Text(
		x : 50
		y : 50
		fontSize : 30
		fontColor : "#000000"
		).addTo(layer).text(totalPoint)

	oCurText = new collie.Text(
		x : 50
		y : 100
		fontSize : 30
		fontColor : "#000000"
		).addTo(layer).text(0)

	(collie.Timer.cycle ( (oEvent) ->
		console.log "value : #{oEvent.value}"

		starResult = starList[oEvent.value]

		starIcon =  new collie.DisplayObject(
			x : "center"
			y : "bottom"
			velocityY : -50
			backgroundImage: "icon"
			).addTo(layer)

		pointText = new collie.Text(
			x : 50
			y : 50
			fontSize : 30
			fontColor : ["red", "black", "blue"][starResult.state]
			).addTo(starIcon).text(starResult.point)

		oCurText.text(Number(oCurText._sText) + starResult.point)

	), starList.length * 1000, { from : 0, to : starList.length - 1, loop : 1}).attach({
		complete : ->
			collie.Timer.delay ((oEvent) -> stopPlayMissionResult()), 1000
	})

	new collie.FPSConsole().load();
	collie.Renderer.addLayer layer
	collie.Renderer.load elParent
	collie.Renderer.start()

Template.mission.destroyed = ->
	stopPlayMissionResult()

Template.mission.events "click #start" : ->
	console.log "start"
	totalPoint = 100
	starList = [
		{
			point: 10
			state: 0 # 0 - bad , 1 - normal , 2 - good
		},
		{
			point: 6
			state: 1 # 0 - bad , 1 - normal , 2 - good
		},
		{
			point: 9
			state: 2
		},
		{
			point: 18
			state: 2
		},
		{
			point: 29
			state: 2
		},
		{
			point: 19
			state: 2
		},
	]

	if isPlayingMission()
		stopPlayMissionResult()
	else
		playMissionResult document.getElementById("fight"), totalPoint, starList