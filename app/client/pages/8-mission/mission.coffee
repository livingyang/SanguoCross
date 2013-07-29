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

playMissionResult = (elParent, totalPoint) ->
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

	repeatArray = (duration, array, func) ->
		collie.Timer.repeat ((oEvent) -> func array[oEvent.count - 1]), duration, {loop: array.length}

	array = [0, 1, 2, 3];
	# repeatArray 1000, array, (ele) -> console.log "ele = #{ele}"


	class TimeLineObject
		constructor: () ->
			@animeData = []			

		onTimelineComplete: ->
			if @animeData.length is 0
				console.log "stop!!"
			else
				@createTimeline(@animeData.pop())

		start: (animeData) ->
			@animeData = animeData
			@createTimeline(@animeData.pop())

		createTimeline: (data) ->
			console.log "createTimeline data: #{data}"
			timeline = collie.Timer.timeline()
			timeline.add(0, "delay", (->), 1000 * data)
			timeline.attach {
				complete: () =>
					@onTimelineComplete()
			}
			timeline

			

	timeline = new TimeLineObject()
	timeline.start [1, 2, 3, 4]
	

	new collie.FPSConsole().load();
	collie.Renderer.addLayer layer
	collie.Renderer.load elParent
	collie.Renderer.start()

Template.mission.destroyed = ->
	stopPlayMissionResult()

Template.mission.events "click #start" : ->
	console.log "start"
	totalPoint = 100

	if isPlayingMission()
		stopPlayMissionResult()
	else
		playMissionResult document.getElementById("fight"), totalPoint