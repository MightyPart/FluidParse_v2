-- MODULE SCRIPT

local Utils = {
	OpsBasic = {"+", "++", "--", "+-", "-"},
	Ops = {"+", "-", "/", "*"},
	OpsReplace = {
		["%+"]= "",
		["%+%+"]= "",
		["%-%-"]= "",
		["%+%-"]= "-",
		["%-"]= "-"
	}
}

function Utils.GmatchCount(gmatch)
	local count = 0 for m in gmatch do count+=1 end return count
end

function Utils.Strip(str)
	return str:gsub("^%s+", ""):gsub("%s+$", "")
end

function Utils.StripNonNums(str)
	return str:gsub("%D+", "")
end

function Utils.WsConds(str)
	return str:gsub("%s+", " ")
end

function Utils.StartsWithBasicOp(str)
	return (str:match("^+") or str:match("^-")) and true or false
end

function Utils.ReplaceOps(str)
	for k,v in Utils.OpsReplace do str = str:gsub(k, v) end
	return str
end

function Utils.IsScaleOrOffset(str)
	if Utils.GmatchCount(str:gmatch("%%$")) >= 1 then return "scale", 100
	elseif Utils.GmatchCount(str:gmatch("px$")) >= 1 then return "offset", 1 end
end

function Utils.StripNonNumExpr(str)
	return str:gsub("[^%d.%-]+", "")
end

function Utils.ScaleAndOffset(unparsedValue, config)
	local parsedValues, scaleVals, offsetVals = {},{}, {}

	-- turns the unparsed value into a list
	unparsedValue = Utils.WsConds(unparsedValue); local unparsedList = unparsedValue:split(" ")

	for key,val in unparsedList do
		-- combines "val" with the previous entry in the unparsed list if it is a basic operator
		if not Utils.StartsWithBasicOp(val) then
			local prevVal = unparsedList[math.max(key-1, 0)]
			if table.find(Utils.OpsBasic, prevVal) then
				val = prevVal..val
			end
		end

		-- determines if the parsed value is a scale or an offset
		local isScaleOrOffset, divAmount = Utils.IsScaleOrOffset(val)
		if not isScaleOrOffset then continue end

		-- simplifies operators and divides the parsed value if it is a scale
		val = Utils.StripNonNumExpr(Utils.ReplaceOps(val))
		val = tonumber(val)/divAmount
		table.insert(parsedValues, val)

		-- adds the parsed value to the correct list ("scaleVals" or "offsetVals")
		if isScaleOrOffset == "scale" then table.insert(scaleVals, val)
		else table.insert(offsetVals, val) end
	end

	-- adds all of the scale values together, and all of the offset values together
	local scale, offset = 0,0
	table.foreach(scaleVals, function(i, v) scale += v end)
	table.foreach(offsetVals, function(i, v) offset += v end)
	
	return scale, offset
end

return Utils
