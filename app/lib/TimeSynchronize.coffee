if Meteor.isClient
	subServerAndClientTime = 0

	initServerTime = ->
		Meteor.call "getServerTimeStamp", (error, result) ->
			subServerAndClientTime = result - (new Date()).getTime()

	getServerTime = ->
		subServerAndClientTime + (new Date()).getTime()

	@initServerTime = initServerTime
	@getServerTime = getServerTime

if Meteor.isServer
	Meteor.methods getServerTimeStamp : () ->
		(new Date()).getTime()