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

-- Aimbot Logic
local aimbotEnabled = false
local aimbotKey = Enum.KeyCode.F1

aimbotToggle.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	print("Aimbot " .. (aimbotEnabled and "Enabled" or "Disabled"))
end)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == aimbotKey then
		aimbotEnabled = not aimbotEnabled
		print("Aimbot " .. (aimbotEnabled and "Enabled" or "Disabled"))
	end
end)

RunService.Heartbeat:Connect(function()
	if aimbotEnabled then
		local closestPlayer
		local closestDistance = math.huge

		for _, target in pairs(players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("Head") then
				local targetHead = target.Character.Head
				local screenPos = camera:WorldToViewportPoint(targetHead.Position)
				local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude

				if distance < closestDistance then
					closestDistance = distance
					closestPlayer = target
				end
			end
		end

		if closestPlayer then
			local targetHead = closestPlayer.Character.Head
			camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
		end
	end
end)

-- ESP Logic
local espEnabled = false
local espKey = Enum.KeyCode.F2
local teamCheck = true
local espColor = Color3.fromRGB(255, 0, 0)

espToggle.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	print("ESP " .. (espEnabled and "Enabled" or "Disabled"))
end)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == espKey then
		espEnabled = not espEnabled
		print("ESP " .. (espEnabled and "Enabled" or "Disabled"))
	end
end)

RunService.Heartbeat:Connect(function()
	if espEnabled then
		for _, target in pairs(players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("Head") then
				local head = target.Character.Head
				local highlight = target.Character:FindFirstChild("Highlight")
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Parent = target.Character
				end

				if teamCheck and target.Team == player.Team then
					highlight.FillTransparency = 1
				else
					highlight.FillColor = espColor
					highlight.FillTransparency = 0.5
				end
			end
		end
	end
end)

-- Hitbox Expander Logic
local hitboxEnabled = false

hitboxToggle.MouseButton1Click:Connect(function()
	hitboxEnabled = not hitboxEnabled
	print("Hitbox Expander " .. (hitboxEnabled and "Enabled" or "Disabled"))
end)

RunService.Heartbeat:Connect(function()
	if hitboxEnabled then
		for _, target in pairs(players:GetPlayers()) do
			if target.Character and target.Character:FindFirstChild("Head") then
				local head = target.Character.Head
				head.Size = Vector3.new(10, 10, 10)
				head.Transparency = 0.5
			end
		end
	end
end)

-- Default to Aimbot tab
switchTab("Aimbot")

-- Toggle UI with Insert key
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		screenGui.Enabled = not screenGui.Enabled
	end
end)
