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
```
