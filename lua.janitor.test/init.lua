local LuaUnit = require("luaunit")

local JanitorTest = require("JanitorTest")

local luaUnit = LuaUnit.LuaUnit.new()

luaUnit:runSuiteByInstances({
	{"JanitorTest", JanitorTest}})

os.exit((luaUnit.result.notSuccessCount == nil) or (luaUnit.result.notSuccessCount == 0))
