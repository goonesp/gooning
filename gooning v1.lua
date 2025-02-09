-- LocalScript inside StarterPlayerScripts

-- Services
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local gui = player:WaitForChild("PlayerGui")
local players = game.Players
local RunService = game:GetService("RunService")

-- UI Variables
local screenGui = Instance.new("ScreenGui", gui)
screenGui.Name = "ESP_Aimbot_UI"

-- Outer Frame
local outerFrame = Instance.new("Frame", screenGui)
outerFrame.Size = UDim2.new(0, 300, 0, 250)
outerFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
outerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
outerFrame.BackgroundTransparency = 0.5
outerFrame.BorderSizePixel = 2
outerFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Draggable UI Logic
local dragging
local dragInput
local dragStart
local startPos

local function onDrag(input)
	if dragging then
		local delta = input.Position - dragStart
		outerFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end

local function onInputBegan(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
		dragging = true
		dragStart = input.Position
		startPos = outerFrame.Position
	end
end

local function onInputEnded(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end

UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)
UserInputService.InputChanged:Connect(onDrag)

-- Tab Buttons and Content
local tabFrame = Instance.new("Frame", outerFrame)
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local contentFrame = Instance.new("Frame", outerFrame)
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1

local tabs = {"Aimbot", "ESP", "Hitbox"}
local activeTab = "Aimbot"

local function switchTab(tabName)
	activeTab = tabName
	for _, button in pairs(tabFrame:GetChildren()) do
		if button:IsA("TextButton") then
			button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end

	for _, tabContent in pairs(contentFrame:GetChildren()) do
		if tabContent:IsA("Frame") then
			tabContent.Visible = tabContent.Name == tabName
		end
	end

	local selectedButton = tabFrame:FindFirstChild(tabName)
	if selectedButton then
		selectedButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end
end

for _, tabName in pairs(tabs) do
	local tabButton = Instance.new("TextButton", tabFrame)
	tabButton.Size = UDim2.new(0, 100, 0, 40)
	tabButton.Position = UDim2.new(0, (#tabs - 1) * 100, 0, 0)
	tabButton.Text = tabName
	tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabButton.MouseButton1Click:Connect(function()
		switchTab(tabName)
	end)
end

-- Aimbot Tab Content
local aimbotFrame = Instance.new("Frame", contentFrame)
aimbotFrame.Size = UDim2.new(1, 0, 1, 0)
aimbotFrame.BackgroundTransparency = 1
aimbotFrame.Name = "Aimbot"

local aimbotToggle = Instance.new("TextButton", aimbotFrame)
aimbotToggle.Size = UDim2.new(0, 200, 0, 40)
aimbotToggle.Position = UDim2.new(0.5, -100, 0.2, -20)
aimbotToggle.Text = "Toggle Aimbot"
aimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimbotKeybindTextBox = Instance.new("TextBox", aimbotFrame)
aimbotKeybindTextBox.Size = UDim2.new(0, 150, 0, 30)
aimbotKeybindTextBox.Position = UDim2.new(0.5, -75, 0.5, 40)
aimbotKeybindTextBox.PlaceholderText = "F1"
aimbotKeybindTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimbotKeybindTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ESP Tab Content
local espFrame = Instance.new("Frame", contentFrame)
espFrame.Size = UDim2.new(1, 0, 1, 0)
espFrame.BackgroundTransparency = 1
espFrame.Name = "ESP"
espFrame.Visible = false

local espToggle = Instance.new("TextButton", espFrame)
espToggle.Size = UDim2.new(0, 200, 0, 40)
espToggle.Position = UDim2.new(0.5, -100, 0.2, -20)
espToggle.Text = "Toggle ESP"
espToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)

local espKeybindTextBox = Instance.new("TextBox", espFrame)
espKeybindTextBox.Size = UDim2.new(0, 150, 0, 30)
espKeybindTextBox.Position = UDim2.new(0.5, -75, 0.5, 40)
espKeybindTextBox.PlaceholderText = "F2"
espKeybindTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espKeybindTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Color Picker for ESP
local espColorFrame = Instance.new("Frame", espFrame)
espColorFrame.Size = UDim2.new(0, 200, 0, 40)
espColorFrame.Position = UDim2.new(0.5, -100, 0.8, 0)
espColorFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local rInput = Instance.new("TextBox", espColorFrame)
rInput.Size = UDim2.new(0, 60, 0, 30)
rInput.Position = UDim2.new(0, 0, 0, 0)
rInput.PlaceholderText = "R"
rInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local gInput = Instance.new("TextBox", espColorFrame)
gInput.Size = UDim2.new(0, 60, 0, 30)
gInput.Position = UDim2.new(0, 70, 0, 0)
gInput.PlaceholderText = "G"
gInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
gInput.TextColor3 = Color3.fromRGB(255, 255, 255)

local bInput = Instance.new("TextBox", espColorFrame)
bInput.Size = UDim2.new(0, 60, 0, 30)
bInput.Position = UDim2.new(0, 140, 0, 0)
bInput.PlaceholderText = "B"
bInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
bInput.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Hitbox Tab Content
local hitboxFrame = Instance.new("Frame", contentFrame)
hitboxFrame.Size = UDim2.new(1, 0, 1, 0)
hitboxFrame.BackgroundTransparency = 1
hitboxFrame.Name = "Hitbox"
hitboxFrame.Visible = false

local hitboxToggle = Instance.new("TextButton", hitboxFrame)
hitboxToggle.Size = UDim2.new(0, 200, 0, 40)
hitboxToggle.Position = UDim2.new(0.5, -100, 0.2, -20)
hitboxToggle.Text = "Toggle Hitbox Expander"
hitboxToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle UI visibility with Insert Key
local uiVisible = true
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		uiVisible = not uiVisible
		screenGui.Enabled = uiVisible
	end
end)

-- Initialize
switchTab("Aimbot")
