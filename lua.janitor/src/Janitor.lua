local Janitor = {}
Janitor.__index = Janitor

local function DoNothing(o)
end

function Janitor.New(thunk)
	local self = setmetatable({}, Janitor)

	if thunk == nil then
		self._thunkDefault = DoNothing
	else
		self._thunkDefault = thunk
	end

	self._thunk = {}
	self._value = {}

	return self
end

function Janitor:AddValue(value, thunk)
	assert(self._thunk[value] == nil)

	if thunk == nil then
		self._thunk[value] = self._thunkDefault
	else
		self._thunk[value] = thunk
	end

	return value
end

function Janitor:Add(key, value, thunk)
	assert(self._thunk[value] == nil)

	self:Cleanup(key)
	self._value[key] = self:AddValue(value, thunk)

	return value
end

local function Cleanup(self, value)
	local thunk = self._thunk[value]

	if thunk == nil then
		return
	end

	self._thunk[value] = nil

	thunk(value)
end

function Janitor:Cleanup(key)
	local value = self._value[key]

	if value == nil then
		return
	end

	self._value[key] = nil

	Cleanup(self, value)
end

function Janitor:CleanupAll()
	local i

	i = next(self._value)
	while i ~= nil do
		self:Cleanup(i)

		i = next(self._value)
	end

	i = next(self._thunk)
	while i ~= nil do
		Cleanup(self, i)

		i = next(self._thunk)
	end
end

return Janitor
