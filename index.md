# API Reference

### Janitor

#### Constructors

##### Janitor **New**()
##### Janitor **New**(function thunk)
Creates and returns a new `Janitor` instance.  If `thunk` is given, it will be used later as the `Janitor` instance's default cleanup function.  `thunk` must be a function that accepts a dynamic parameter.

#### Methods

##### dynamic **Add**(dynamic key, dynamic value)
##### dynamic **Add**(dynamic key, dynamic value, function thunk)
Adds an entry for value `value` to this `Janitor` instance, with key `key` for later reference.  If `thunk` is given, it will be used later as the entry's cleanup function.  `thunk` must be a function that accepts a dynamic parameter.  Returns `value`.

##### dynamic **AddValue**(dynamic value)
##### dynamic **AddValue**(dynamic value, function thunk)
Adds an entry for value `value` to this `Janitor` instance.  If `thunk` is given, it will be used later as the entry's cleanup function.  `thunk` must be a function that accepts a dynamic parameter.  Returns `value`.

##### nil **Cleanup**(dynamic key)
Removes the entry with key `key` from this `Janitor` instance.  If the entry has a cleanup function, that function will be called, with the entry's value as the argument; otherwise, this `Janitor` instance's default cleanup function will be called, with the entry's value as the argument.

##### nil **CleanupAll**()
Removes all entries from this `Janitor` instance.  For each entry: if the entry has a cleanup function, that function will be called, with the entry's value as the argument; otherwise, this `Janitor` instance's default cleanup function will be called, with the entry's value as the argument.

# Examples

## Usage

### Example.lua

```lua
local Janitor = require("Janitor")

local Thing = {}
Thing.__index = Thing

function Thing.New()
	local self = setmetatable({}, Thing)

	return self
end

function Thing:Destroy()
	print("Destroy")
end

local _janitor = Janitor.New(Thing.Destroy)

_janitor:AddValue(Thing.New())
_janitor:AddValue(Thing.New())
_janitor:AddValue(Thing.New())

_janitor:CleanupAll()
```

### 🧾 (Output)

```text
Destroy
Destroy
Destroy
```
