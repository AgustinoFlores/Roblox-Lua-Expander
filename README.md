# Roblox-Lua-Expander

The Roblox Lua Expander is used to expand what Lua can do inside Roblox. It adds new functionality to the Lua code within Roblox to allow different functions found in different programming languages, opens the opportunity for Object Oriented Programming, and streamlines Roblox features.

Visit the Wiki!

To use:
Just include this line of code to any script (local or server) to allow the use of this script. Must be included in all scripts.

```lua
local Util = require(5792611014)()
```
This will allow any script to use the functionalities found in the RLE.
```lua
  local Util = require(5792611014)()
  
  local tab = {
	inner = {"Heyo", "Wow"},
	otherInner = {
		insideOther = {
			WowAnotherTable = {"Oof"}
		}
	}
}

table.removeValue(tab, "Oof") --searches the entire table, including inner tables, to remove a specific value

table.print(tab) --Allows the printing of tables
```
Output:
```
{ [inner] = { [1] = Heyo [2] = Wow } [otherInner] = { [insideOther] = { [WowAnotherTable] = { } } } }
```

The RLE includes different libraries to allow you to expand what Lua can do. Currently only the Class library exists which allows the use of Object Oriented Programming within Roblox.

Module Script MyClass
```lua
local util = require(5792611014)()
local Class = util.LoadLibrary("Class")

MyClass = Class{
	num = 1
}

function MyClass:init(number)
	self.num = number
end

function MyClass:Print()
	print(self.num)
end

return MyClass
```

Server Script
```lua
local MyClass = require(script.MyClass)

local newClass = MyClass(10)
newClass:Print()
```

Output:
```
10
```

If you want to see how the code works just visit the following link and add it to your ToolBox:
https://www.roblox.com/library/5792611014/Roblox-Lua-Expander

If you have any questions feel free to message me on either Discord or Roblox
Roblox: chocolatemanlol
Discord: Choco#7316

Enjoy!
