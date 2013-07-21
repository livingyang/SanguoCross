describe "IndexRecordSpec", ->
	it "初始化", ->
		record = new IndexRecord({array: [{key:"1"}], key: "key"})
		expect(record.count()).toBe(1)

	it "读取数据", ->
		record = new IndexRecord({array: [{key:"1"}], key: "key"})
		expect(record.objectForKey("1")["key"]).toBe("1")

	it "读取随机数据", ->
		record = new IndexRecord({array: [{key:"1"}], key: "key"})
		expect(record.randomObject()["key"]).toBe("1")
		expect(record.randomKey()).toBe("1")
