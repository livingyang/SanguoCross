describe "LevelExpExchange", ->
	it "是否为有效的等级数据", ->
		expect(isValidLevelExpArray "0, 1, 2").toBe(false)
		expect(isValidLevelExpArray [-1, 0, 10, 1000]).toBe(false)
		expect(isValidLevelExpArray [10, 1000]).toBe(false)
		expect(isValidLevelExpArray [0, 1000, 10]).toBe(false)
		expect(isValidLevelExpArray [0, 10, 10]).toBe(false)

		expect(isValidLevelExpArray [0]).toBe(true)
		expect(isValidLevelExpArray [0, 1]).toBe(true)
		expect(isValidLevelExpArray [0, 10, 1000]).toBe(true)

	it "根据经验获取等级", ->
		expect(getLevelFromExpArray [0, 10, 1000]).toBe(0)
		expect(getLevelFromExpArray [0, 10, 1000], "1").toBe(0)
		expect(getLevelFromExpArray [0, 10, 1000], -1).toBe(0)

		expect(getLevelFromExpArray [0], -1).toBe(0)
		expect(getLevelFromExpArray [0], 0).toBe(1)
		expect(getLevelFromExpArray [0], 1000).toBe(1)
		
		expect(getLevelFromExpArray [0, 10, 1000], 0).toBe(1)
		expect(getLevelFromExpArray [0, 10, 1000], 9).toBe(1)
		expect(getLevelFromExpArray [0, 10, 1000], 10).toBe(2)
		expect(getLevelFromExpArray [0, 10, 1000], 999).toBe(2)
		expect(getLevelFromExpArray [0, 10, 1000], 1000).toBe(3)
		expect(getLevelFromExpArray [0, 10, 1000], 100000000).toBe(3)

	it "获取最大等级", ->
		expect(getMaxLevelFromExpArray()).toBe(0)
		expect(getMaxLevelFromExpArray [1, 10]).toBe(0)
		expect(getMaxLevelFromExpArray [0, 100, 10]).toBe(0)

		expect(getMaxLevelFromExpArray [0]).toBe(1)
		expect(getMaxLevelFromExpArray [0, 10, 1000]).toBe(3)

	it "是否可升级", ->
		expect(canUpLevelFromExpArray [0, 10, 1000]).toBe(false)
		expect(canUpLevelFromExpArray [0, 10, 1000], -1).toBe(false)
		expect(canUpLevelFromExpArray [0, 10, 1000], "1").toBe(false)

		expect(canUpLevelFromExpArray [0, 10, 1000], 0).toBe(true)
		expect(canUpLevelFromExpArray [0, 10, 1000], 999).toBe(true)
		expect(canUpLevelFromExpArray [0, 10, 1000], 1000).toBe(false)
		expect(canUpLevelFromExpArray [0, 10, 1000], 1000000).toBe(false)
		expect(canUpLevelFromExpArray [0], 0).toBe(false)

	it "根据等级获取经验", ->
		expect(getLevelExpFromExpArray [0, 10, 1000]).toBe(0)
		expect(getLevelExpFromExpArray [0, 10, 1000], -1).toBe(0)
		expect(getLevelExpFromExpArray [0, 10, 1000], "1").toBe(0)

		expect(getLevelExpFromExpArray [0, 10, 1000], 1).toBe(0)
		expect(getLevelExpFromExpArray [0, 10, 1000], 2).toBe(10)
		expect(getLevelExpFromExpArray [0, 10, 1000], 3).toBe(1000)

		expect(getLevelExpFromExpArray [0, 10, 1000], 0).toBe(0)
		expect(getLevelExpFromExpArray [0, 10, 1000], 4).toBe(0)

	it "获取下一等级的经验", ->
		expect(getNextLevelExpFromExpArray [0, 10, 1000]).toBe(0)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], -1).toBe(0)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], "1").toBe(0)

		expect(getNextLevelExpFromExpArray [0, 10, 1000], 0).toBe(10)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], 10).toBe(990)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], 999).toBe(1)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], 1000).toBe(0)
		expect(getNextLevelExpFromExpArray [0, 10, 1000], 1000000).toBe(0)
		expect(getNextLevelExpFromExpArray [0], 0).toBe(0)
