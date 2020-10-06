local module = {}

for i, v in pairs(table) do
	module[i] = v
end

function module.isArray(tab)
	local i = 1
	 
	for index, _ in pairs(tab) do
		if type(index) ~= "number" then return false end
		if index ~= i then return false end
		i += 1
	end
	
	return true
end

function module.concat(...)
	local args = {...}
	
	if #args <= 1 then
		if args[1] and type(args[1]) == "table" then
			return args[1]
		end
		
		return nil
	end
	
	local newTab = {}
	local isArr = true
	
	for i, v in ipairs(args) do
		if type(v) == "table" then
			if not module.isArray(v) then
				isArr = false
			end
		end
	end
	
	if isArr then
		local index = 1
		for i, v in ipairs(args) do
			if type(v) == "table" then
				for j, k in ipairs(v) do
					table.insert(newTab, index, k)
					index = index + 1
				end
			end
		end
	else
		for i, v in ipairs(args) do
			if type(v) == "table" then
				for j, k in pairs(v) do
					newTab[j] = k
				end
			end
		end
	end
	
	return newTab
end

function module.join(...)
	return table.concat(...)
end

function module.find(tab, value, init)
	if module.isArray(tab) then
		return table.find(tab, value, init)
	end
	
	for i, v in pairs(tab) do
		if type(v) == "table" then
			local val = table.pack(module.find(v, value))
			
			if table.unpack(val) ~= nil then return i, table.unpack(val) end
		end
		
		if v == value then return i end
	end
	
	return nil
end

function module.reverse(tab)
	local newTable = {}
	local success, err = pcall(function()
		for i = #tab, 1, -1 do
			table.insert(newTable, tab[i])
		end
	end)
	
	if success then
		return newTable
	else
		warn(err)
	end
end

function module.slice(tab, startIndex, endIndex)
	local newTab = {}
	
	for i = startIndex, endIndex, 1 do
		table.insert(newTab, tab[i])
	end
	
	return newTab
end

function module.splice(tab, startIndex, remove, ...)
	local args = {...}
	local removed = {}
	
	for i = startIndex + remove - 1, startIndex, -1 do
		table.insert(removed, tab[i])
		table.remove(tab, i)
	end
	
	for i, v in pairs(args) do
		table.insert(tab, startIndex + (i - 1), v) 
	end
	
	return removed
end

function module.insert(tab, index, val)
	if val == nil then
		table.insert(tab, index)
	else
		if type(index) == "number" then
			table.insert(tab, index, val)
		else
			tab[index] = val
		end
	end
end

function module.remove(tab, index)
	if module.isArray(tab) then
		return table.remove(tab, index)
	end
	
	local returnedElement
	for i, v in pairs(tab) do
		if i == index then
			returnedElement = v
			tab[i] = nil
			
			return returnedElement
		end
	end
end

function module.removeValue(tab, value)
	local indeces = table.pack(module.find(tab, value))
	
	local currentTable = tab[indeces[1]]
	local index = 2
	
	while index < #indeces do
		currentTable = currentTable[indeces[index]]
		index += 1
	end
	
	local deletedValue = currentTable[indeces[#indeces]]
	currentTable[indeces[#indeces]] = nil
	
	return deletedValue
end

function module.copyTable(refTable)
	local newTable = {}
	
	for i, v in pairs(refTable) do
		if type(v) == "table" then
			newTable[i] = module.copyTable(v)
		else
			newTable[i] = v
		end
	end
	
	return newTable
end

function module.toString(tab)
	local str = "{"
	local toAdd
	
	for i, v in pairs(tab) do
		if type(v) == "table" then
			toAdd = module.toString(v)
		else
			toAdd = tostring(v)
		end
		str = str .. " [" .. i .. "] = " .. toAdd
	end
	
	str = str .. " }"
	
	return str
end

function module.print(...)
	for i, v in pairs({...}) do
		if type(v) == "table" then
			print(module.toString(v))
		else
			print(v)
		end
	end
end

function module.shift(tab)
	if module.isArray(tab) then
		return table.remove(tab, 1)
	end
	
	local count = 1
	local val
	for i,v in pairs(tab) do
		if count > 1 then break end
		
		val = tab[i]
		tab[i] = nil
		count = count + 1
	end
	
	return val
end

function module.unshift(tab, ...)
	local temp = module.copyTable(tab)
	module.empty(tab)
	local args = {...}
	
	for i,arg in pairs(args) do
		if type(arg) == "table" then
			for index, v in pairs(arg) do
				tab[index] = v
			end
		else
			tab[i] = arg
		end
	end
	
	local size = #tab
	for i, v in pairs(temp) do
		if module.isArray(temp) then
			tab[i + size] = v
		else
			tab[i] = v
		end
	end

	return #tab
end

function module.empty(tab)
	for i, v in pairs(tab) do
		tab[i] = nil
	end
end

return module
