local module = {}

table = require(script.Parent.Table)

local switch = {}
setmetatable(switch, {
	__call = function(self, item)
		if not item then
			warn("Switch statement needs a value to be compared")
		else
			return function(data)
				for i, v in pairs(data) do
					if item == module.convertFromString(i) then
						if type(v) == "function" then
							return v()
						else
							return v
						end
					end
				end
				
				if data.default then
					return data.default
				end
				
				warn("No default value given, switch case will return nil")
				return nil
			end
		end
	end
})

function module.convertFromString(val)
	if val == "true" then
		return true
	end
	
	if val == "false" then
		return false
	end
	
	if val == "nil" or val == "null" then
		return nil
	end
	
	local num = tonumber(val)
	
	if num ~= nil and tostring(num) == val then
		return num
	end
	
	return val
end

function module.CreateVal(valType, parent, name, value)
	local inst, success, err
	
	if value then
		success, err = pcall(function()
			inst = Instance.new(valType)
			inst.Parent = parent
			inst.Name = name
			inst.Value = value
		end)
	else
		local temp = name
		name = parent
		value = temp
		
		success, err = pcall(function()
			inst = Instance.new(valType)
			inst.Name = name
			inst.Value = value
		end)
	end
	
	if success then
		return inst
	else
		warn(err)
	end
end

function module.ClearChildren(inst, exempt)
	if exempt == nil then
		inst:ClearAllChildren()
	end
	
	for i, v in pairs(inst:GetChildren()) do
		if not table.find(exempt, v.Name) then
			v:Destroy()
		end
	end
end

function module.debounce(func)
	local isRunning = false
	
	return function(...)
		if not isRunning then
			isRunning = true
			func(...)
			isRunning = false
		end
	end
end

function module.getPlayersByTeam(...)
	local players = {}
	local teams = {...}
	
	for i, v in pairs(teams) do
		if type(v) == "table" then
			for index, team in pairs(v) do
				print(team)
				for _, plr in pairs(team:GetPlayers()) do
					table.insert(players, plr)
				end
			end
		else
			for _, plr in pairs(v:GetPlayers()) do
				table.insert(players, plr)
			end
		end
		
	end
	
	return players
end

function module.LoadLibrary(libName)
	for i, v in pairs(script:GetChildren()) do
		if v.Name == libName and v:IsA("ModuleScript") then
			return require(v)
		end
	end
end

module.switch = switch

return module
