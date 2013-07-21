fs = require "fs"
exec = require("child_process").exec

dirDistSrc = "./dist/src"
dirDistSpec = "./dist/spec"

buildFile = (filePath, distDir) ->
	exec "coffee -o #{distDir} -c #{filePath}", (error, stdout, stderr) ->
	    if error?
	    	console.log('stdout: ' + stdout)
    		console.log('stderr: ' + stderr)
    		console.log('exec error: ' + error)

buildFile "../../lib/TimeRecoverProperty.coffee", dirDistSrc
buildFile "../../lib/LevelExpExchange.coffee", dirDistSrc
buildFile "../../lib/lib/IndexRecord.coffee", dirDistSrc

fs.readdir "spec", (err, files) ->
	files.forEach (filename) ->
		(buildFile "spec/" + filename, dirDistSpec) if filename.match "coffee"