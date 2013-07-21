isValidLevelExpArray = (levelExpArray) ->
	if levelExpArray instanceof Array and levelExpArray.length >= 1 and levelExpArray[0] is 0
		result = true
		for exp, i in levelExpArray[1..]
			result = result and (levelExpArray[i] < exp)
		result
	else false

getLevelFromExpArray = (levelExpArray, exp) ->
	if isValidLevelExpArray(levelExpArray) and typeof exp is "number"
		result = 0
		for levelExp, i in levelExpArray
			if exp >= levelExp
				result = i + 1
		result
	else 0

getMaxLevelFromExpArray = (levelExpArray) ->
	if isValidLevelExpArray levelExpArray then levelExpArray.length else 0
	

canUpLevelFromExpArray = (levelExpArray, exp) ->
	level = getLevelFromExpArray levelExpArray, exp
	level isnt 0 and level < getMaxLevelFromExpArray levelExpArray

getLevelExpFromExpArray = (levelExpArray, level) ->
	if isValidLevelExpArray(levelExpArray) and typeof level is "number" and 0 < level <= getMaxLevelFromExpArray levelExpArray
		levelExpArray[level - 1]
	else 0

getNextLevelExpFromExpArray = (levelExpArray, exp) ->
	if canUpLevelFromExpArray levelExpArray, exp
	then getLevelExpFromExpArray(levelExpArray, getLevelFromExpArray(levelExpArray, exp) + 1) - exp
	else 0

@isValidLevelExpArray = isValidLevelExpArray
@getLevelFromExpArray = getLevelFromExpArray
@getMaxLevelFromExpArray = getMaxLevelFromExpArray
@canUpLevelFromExpArray = canUpLevelFromExpArray
@getLevelExpFromExpArray = getLevelExpFromExpArray
@getNextLevelExpFromExpArray = getNextLevelExpFromExpArray
