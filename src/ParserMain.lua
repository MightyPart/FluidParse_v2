-- MODULE SCRIPT

local ParserMain = {}

ParserMain.Fusion = nil

DataTypesConfig = require(script.Parent.DataTypesConfig)

MakePlural = {
	UDim = UDim2,
}
ToType = {
	UDim = UDim
}
EmptyTable = {}

PriorityNames = {"Height", "Width", "TranslateX", "TranslateY"}

local function _ConvertVariables(value, variables)
	if typeof(value) ~= "string" then return value end
	if not value:match("^__") then return value end
	return variables[value]
end

local function _ParseValue(name, value, variables, parsedData)
	local config = DataTypesConfig[name]
	if not config then return end

	value = _ConvertVariables(value, variables)
	return config.func(value, config, parsedData)
end

local function ParseData(unparsedData)
	local variables = {}
	for name,value in unparsedData do
		if typeof(name) ~= "string" then continue end
		if name:match("^__") then variables[name] = value end
	end
	
	local parsedData = table.create(#unparsedData - #variables)
	local overwrites = {}
	-- iterates through all of the prioritised unparsed data and parses them
	for name,value in unparsedData do
		if not table.find(PriorityNames, name) then continue end
		parsedData[name] = _ParseValue(name, value, variables, parsedData)
	end
	-- iterates through all of the unparsed data and parses them
	for name,value in unparsedData do
		if table.find(PriorityNames, name) then continue end
		local parsedValue, overwritesForParsedValue = _ParseValue(name, value, variables, parsedData)
		parsedData[name] = parsedValue; overwrites[name] = overwritesForParsedValue
	end

	return parsedData, overwrites
end

-- adds parsed data to the combinedparsedData table using the config
local function _Add(tble, value, config, overwrites)
	-- adds the overwrites into the config
	if overwrites then for key,val in overwrites do config[key] = val end end
	
	local subInst = config.subInstance
	if not subInst then tble[config.returns] = value; return end
	
	local subTble = tble[subInst]
	if not subTble then tble[subInst] = {}; subTble = tble[subInst] end
	subTble[config.returns] = value
end

local function CombineData(parsedData, overwrites)
	local combinedParsedData = table.create(#parsedData)

	for name,value in parsedData do
		-- get the relevant data from the config
		local config = DataTypesConfig[name]
		local combinesWith = config.combinesWith
		local combinedOrder = config.combinedOrder

		if not combinesWith then _Add(combinedParsedData, value, config, overwrites[name]) continue end

		-- gets the plural version of the data type for the combined data
		local valueType = typeof(value)
		local emptyValue = ToType[valueType].new()
		local pluralDataType = MakePlural[typeof(value)]

		-- gets the value and the config for the data to combine with
		local toCombineWithParsedValue = parsedData[combinesWith]
		local toCombineWithConfig = DataTypesConfig[combinesWith]

		-- creates a list of the values that will be combined
		local combinedList = table.create(2)
		combinedList[name] = value
		combinedList[combinesWith] = toCombineWithParsedValue
		
		local combinedValue = pluralDataType.new(
			combinedList[combinedOrder[1]] or emptyValue,
			combinedList[combinedOrder[2]] or emptyValue
		)
		_Add(combinedParsedData, combinedValue, config) -- overwrites are not allowed for combined datatypes
	end
	
	return combinedParsedData
end

ParserMain.Parse = function(unparsedData)
	local parsedData, overwrites = ParseData(unparsedData)
	parsedData = CombineData(parsedData, overwrites)

	return parsedData
end

ParserMain.ApplyProps = function(inst, props)
	
	for key,val in props do
		if typeof(val) == "table" then -- if a sub inst
			local subInst = inst:FindFirstChildOfClass(key)
			if not subInst then subInst = Instance.new(key) end 

			for key2,val2 in val do  subInst[key2] = val2 end
			subInst.Parent = inst
			
		else -- if not a sub inst
			inst[key] = val
		end
	end
	
end

ParserMain.ParseFusion = function(unparsedData)
	local fusionChildrenKey, fusionChildrenVal = nil, nil
	if not (fusionChildrenKey or fusionChildrenVal) then
		fusionChildrenKey, fusionChildrenVal = ParserMain.Fusion.Children, {}
	end
	
	for key,val in unparsedData do
		if typeof(key) ~= "table" then continue end
		fusionChildrenKey, fusionChildrenVal = key, val
	end
	
	local parsedData, overwrites = ParseData(unparsedData)
	parsedData = CombineData(parsedData, overwrites)
	
	for key,val in parsedData do
		if typeof(val) == "table" then
			table.insert(fusionChildrenVal, ParserMain.Fusion.New(key)(val))
			parsedData[key] = nil
		end
	end
	
	parsedData[fusionChildrenKey] = fusionChildrenVal
	
	
	--parsedData[ParserMain.Fusion.Children] = children
	return parsedData
end

return ParserMain
