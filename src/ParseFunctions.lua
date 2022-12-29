-- MODULE SCRIPT

local Functions = {}
local Utils = require(script.Parent.Utils)
local WsConds = Utils.WsConds
local ScaleAndOffset = Utils.ScaleAndOffset
local StripNonNums = Utils.StripNonNums

function Functions.UDim(unparsedValue, config, currData)
	local scale, offset = ScaleAndOffset(unparsedValue, config)
	return UDim.new(scale, offset)
end

function Functions.Content(unparsedValue, config, currData)
	return tostring(unparsedValue)
end

local EmptyUDim = UDim.new()
function Functions.ContentSize(unparsedValue, config, currData)
	--local scale, offset = ScaleAndOffset(unparsedValue, config)
	if unparsedValue == "scaled" then return true, {returns="TextScaled"}
	elseif typeof(unparsedValue) == "number" then return unparsedValue
	else local n = StripNonNums(unparsedValue); return tonumber(n) end
end

function Functions.Color(unparsedValue, config, currData)
	return unparsedValue
end

anchorPointConvertor = {
	["middle"] = .5,
	["center"] = .5,
	["left"] = 0,
	["right"] = 1,
	["top"] = 0,
	["bottom"] = 1,
}
function Functions.Anchor(unparsedValue, config, currData)
	-- turns the unparsed value into a list
	unparsedValue = WsConds(unparsedValue); local unparsedList = unparsedValue:split(" ")

	-- converts to a vector2
	if #unparsedList == 1 then -- if only 1 word
		local convertedValue = anchorPointConvertor[unparsedValue:lower()]
		return Vector2.new(convertedValue, convertedValue)

	elseif #unparsedList == 2 then -- if only 2 words
		return Vector2.new(
			anchorPointConvertor[unparsedList[1]:lower()],
			anchorPointConvertor[unparsedList[2]:lower()]
		)
	end
end

function Functions.Instance(unparsedValue, config, currData)
	if typeof(unparsedValue) ~= "Instance" then unparsedValue = nil end
	return unparsedValue
end

return Functions
