local module = {}

string = require(script.String)
table = require(script.Table)

setmetatable(module, 
{
	__call = function(this)
		local thisScript = getfenv(1)
		local parentScript = getfenv(2)
		
		for i, v in pairs(thisScript) do
			if type(v) == "function" or type(v) == "table" and i ~= "script" then
				parentScript[i] = v
			end
		end
			
		return require(script:FindFirstChild("Misc"))	
	end
})

return module
