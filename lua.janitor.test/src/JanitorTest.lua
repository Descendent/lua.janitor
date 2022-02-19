local LuaUnit = require("luaunit")

local Janitor = require("Janitor")

local JanitorTest = {}

function JanitorTest:TestNew_WithFunction()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:AddValue(a)

	o:CleanupAll()

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestAddValue()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:AddValue(a)

	o:CleanupAll()

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestAddValue_WhereNotValid()
	local o = Janitor.New()

	local a = {}
	o:AddValue(a)

	LuaUnit.assertError(function ()
		o:AddValue(a)
	end)
end

function JanitorTest:TestAddValue_WithFunction()
	local cleanup = {}

	local o = Janitor.New()

	local a = {}
	o:AddValue(a, function (value)
		cleanup[value] = true
	end)

	o:CleanupAll()

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestAdd()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:Add("a", a)

	o:CleanupAll()

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestAdd_WhereExists()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:Add("a", a)

	local b = {}
	o:Add("a", b)

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestAdd_WhereNotValid()
	local o = Janitor.New()

	local a = {}
	o:AddValue(a)

	LuaUnit.assertError(function ()
		o:Add("a", a)
	end)
end

function JanitorTest:TestAdd_WithFunction()
	local cleanup = {}

	local o = Janitor.New()

	local a = {}
	o:Add("a", a, function (value)
		cleanup[value] = true
	end)

	o:CleanupAll()

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestCleanup()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:Add("a", a)

	o:Cleanup("a")

	LuaUnit.assertTrue(cleanup[a])
end

function JanitorTest:TestCleanupAll()
	local cleanup = {}

	local o = Janitor.New(function (value)
		cleanup[value] = true
	end)

	local a = {}
	o:AddValue(a)

	local b = {}
	o:AddValue(b)

	local c = {}
	o:AddValue(c)

	o:CleanupAll()

	LuaUnit.assertEquals(cleanup, {[a] = true, [b] = true, [c] = true})
end

return JanitorTest
