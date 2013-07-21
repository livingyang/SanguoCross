describe "TimeRecoverProperty", ->
	it "用默认参数的进行初始化", ->
    	expect(TimeRecoverProperty).not.toThrow();
		prop = new TimeRecoverProperty()
		expect(prop.maxRecoverTime).toBe(1)
		expect(prop.curRecoverTime).toBe(0)
		expect(prop.timeToValueRate).toBe(1)
		expect(prop.timeStamp).toBe(0)

	it "用错误参数进行初始化", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: "2"
			curRecoverTime: -10
			timeToValueRate: -1
			timeStamp: -1
		expect(prop.maxRecoverTime).toBe(1)
		expect(prop.curRecoverTime).toBe(0)
		expect(prop.timeToValueRate).toBe(1)
		expect(prop.timeStamp).toBe(-1)

	it "可以获取属性值，根据时间与属性值比率来进行转换", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 8
			timeToValueRate: 2
			timeStamp: 12

		expect(prop.getCurValue()).toBe(4)
		expect(prop.getMaxValue()).toBe(5)

	it "更新时间戳时，将同步更新恢复值，若时间戳比当前时间戳旧，则不更新", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.updateTime 6).toBe(true)
		expect(prop.timeStamp).toBe(6)
		expect(prop.curRecoverTime).toBe(6)
		expect(prop.updateTime 5).toBe(false)
		expect(prop.timeStamp).toBe(6)
		expect(prop.curRecoverTime).toBe(6)

	it "通过时间更新时，当前时间值无法超过最大时间值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		prop.updateTime 12
		expect(prop.timeStamp).toBe(12)
		expect(prop.curRecoverTime).toBe(10)

	it "可以直接设置当前时间值，此时可以超过最大时间值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.getCurValue()).toBe(0)
		prop.curRecoverTime = 13
		expect(prop.curRecoverTime).toBe(13)
		expect(prop.getCurValue()).toBe(Math.floor 13 / 2)

		prop.updateTime 10
		expect(prop.timeStamp).toBe(10)
		expect(prop.curRecoverTime).toBe(13)

	it "获取剩余时间值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.getRemainRecoverTime()).toBe(10)

		prop.curRecoverTime = 7
		expect(prop.getRemainRecoverTime()).toBe(3)

		prop.curRecoverTime = 17
		expect(prop.getRemainRecoverTime()).toBe(0)

	it "可以增加属性值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.upValue()).toBe(false)
		expect(prop.upValue -1).toBe(false)
		expect(prop.upValue "1").toBe(false)

		expect(prop.upValue 6).toBe(true)
		expect(prop.getCurValue()).toBe(6)
		expect(prop.curRecoverTime).toBe(12)

		expect(prop.timeStamp).toBe(0)

	it "可以减少属性值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.downValue()).toBe(false)
		expect(prop.downValue -1).toBe(false)
		expect(prop.downValue "1").toBe(false)
		expect(prop.downValue 1).toBe(false)

		expect(prop.upValue 6).toBe(true)

		expect(prop.downValue 3).toBe(true)
		expect(prop.getCurValue()).toBe(3)
		expect(prop.curRecoverTime).toBe(6)


		expect(prop.downValue 4).toBe(false)
		expect(prop.getCurValue()).toBe(3)
		expect(prop.curRecoverTime).toBe(6)
