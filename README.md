Example
```lua
-- Fusion stuff
local Fusion = require(--[[PATH TO FUSION HERE]])
local New, Children = Fusion.New, Fusion.Children
-- Parser Stuff
local ParserMain = require(--[[PATH TO PARSE HERE]])
ParserMain.Fusion = Fusion
local Parse = ParserMain.ParseFusion

local gui = Instance.new("ScreenGui")

New "Frame" (Parse{
	__Padding = "20px";
	Width="40% + 100px"; Height="20% + 50px";
	TranslateX="50%"; TranslateY="50%"; Anchor="Center";
	Background=BrickColor.Red().Color;
	CornerRadius="10%";
	PaddingLeft="__Padding"; PaddingRight="__Padding";
	PaddingTop="__Padding"; PaddingBottom="__Padding";
	Parent = gui;
	
	[Children] = {New "TextButton" (Parse{
		Width="100%"; Height="50px";
		TranslateY="100%"; Anchor="Left Bottom";
		CornerRadius="10%";
		Content="Hello!!!"
	})}
})

gui.Parent = game:GetService("StarterGui")


--[[
New "Frame" {
	Size=UDim2.new(.4,100, .2,50),
	Position=UDim2.fromScale(.5,.5);
	AnchorPoint=Vector2.new(.5,.5),
	BackgroundColor3=BrickColor.Red().Color,
	Parent = gui,
	
	[Children] = {
		New "UIPadding" {
			PaddingLeft=UDim.new(0,20), PaddingRight=UDim.new(0,20),
			PaddingTop=UDim.new(0,20), PaddingBottom=UDim.new(0,20)
		},
		New "UICorner" {
			CornerRadius=UDim.new(.1,0)
		},
		New "TextButton" {
			Size=UDim2.new(1,0, 0,50),
			Position=UDim2.fromScale(0,1);
			AnchorPoint=Vector2.new(0,1),
			Text="Hello!!!",
			
			[Children] = New "UICorner" {
				CornerRadius=UDim.new(.1,0)
			}
		}
	}
}

gui.Parent = game:GetService("StarterGui")
]]
```
