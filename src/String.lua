local module = {}

for i, v in pairs(string) do
	module[i] = v
end

function module.split(str, sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	str:gsub(pattern, function(c)
		fields[#fields + 1] = c
	end)
		
	return fields
end

function module.charAt(str, index)
	return string.sub(str, index, index)
end

function module.startsWith(str, pattern)
	return str:sub(1, pattern:len()) == pattern
end

function module.endsWith(str, pattern)
	return str:sub(str:len() - pattern:len() + 1) == pattern
end

function module.toArray(str)
	local arr = {}
	
	for i = 1, #str, 1 do
		table.insert(arr, i, str:sub(i, i))
	end
	
	return arr
end

function module.trim(str, pattern)
	if string.find(str, pattern) then
		local pos = string.find(str, pattern)
		
		return str:sub(1, pos - 1)
	else
		return str
	end
end

function module.firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

function module.findLast(str, pattern, ...)
	local args = {...}

	local index = str:len()
	local index2
	local finished = false
	while not finished and index > 0 do
		local found, other = string.find(str, pattern, index)
		
		if not found then
			index = index - 1
		else
			finished = true
			index, index2 = found, other
		end
	end
	
	if index <= 0 then
		index = nil
	end
	
	return index, index2
end

return module
