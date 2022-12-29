-- MODULE SCRIPT

local ParseFunctions = require(script.Parent.ParseFunctions.Functions)

return {
	["Width"]= {
		func= ParseFunctions.UDim,
		returns= "Size",
		combinesWith= "Height",
		combinedOrder= {"Width", "Height"}
	},
	["Height"]= {
		func= ParseFunctions.UDim,
		returns= "Size",
		combinesWith="Width",
		combinedOrder= {"Width", "Height"}
	},
	
	
	["TranslateX"]= {
		func= ParseFunctions.UDim,
		returns= "Position",
		combinesWith= "TranslateY",
		combinedOrder= {"TranslateX", "TranslateY"}
	},
	["TranslateY"]= {
		func= ParseFunctions.UDim,
		returns= "Position",
		combinesWith= "TranslateX",
		combinedOrder= {"TranslateX", "TranslateY"}
	},
	
	["Anchor"]= {
		func= ParseFunctions.Anchor,
		returns= "AnchorPoint",
		returnedDataType=Vector2,
	},
	
	["Background"]= {
		func= ParseFunctions.Color,
		returns= "BackgroundColor3"
	},
	
	["CornerRadius"]= {
		func= ParseFunctions.UDim,
		returns= "CornerRadius",
		subInstance= "UICorner"
	},
	
	["PaddingLeft"]= {
		func= ParseFunctions.UDim,
		returns= "PaddingLeft",
		subInstance= "UIPadding"
	},
	["PaddingRight"]= {
		func= ParseFunctions.UDim,
		returns= "PaddingRight",
		subInstance= "UIPadding"
	},
	["PaddingTop"]= {
		func= ParseFunctions.UDim,
		returns= "PaddingTop",
		subInstance= "UIPadding"
	},
	["PaddingBottom"]= {
		func= ParseFunctions.UDim,
		returns= "PaddingBottom",
		subInstance= "UIPadding"
	},
	
	["Content"]= {
		func= ParseFunctions.Content,
		returns= "Text"
	},
	["ContentSize"]= {
		func= ParseFunctions.ContentSize,
		returns= "TextSize"
	},
	
	["Parent"]= {
		func= ParseFunctions.Instance,
		returns= "Parent"
	}
	
	--[[["BorderColor"]= {
		func= ParseFunctions.Color,
		returns= "Color",
		subInstance= "UIStroke"
	},
	["BorderThickness"]= {
		func= ParseFunctions.Number,
		returns= "Color",
		subInstance= "UIStroke"
	},
	["BorderTransparency"]= {
		func= ParseFunctions.FracOrDec,
		returns= "Transparency",
		subInstance= "UIStroke"
	},
	["BorderMode"]= {
		func= ParseFunctions.Enums,
		enums= {Enum.LineJoinMode.Round, Enum.LineJoinMode.Bevel, Enum.LineJoinMode.Miter},
		returns= "LineJoinMode"
	}]]

}
