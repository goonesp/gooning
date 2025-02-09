-- Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Elements
local screenGui = script.Parent
local mainFrame = screenGui:FindFirstChild("MainFrame")
local successMessage = screenGui:FindFirstChild("SuccessMessage")
local blurEffect = Instance.new("BlurEffect", game.Lighting)
blurEffect.Size = 0
blurEffect.Enabled = false

-- Particles
local particleId = "rbxassetid://13328251594"
local particle = Instance.new("ParticleEmitter")
particle.Texture = particleId
particle.Lifetime = NumberRange.new(1)
particle.Rate = 5
particle.Speed = NumberRange.new(1, 3)

-- Feature Toggles
local espEnabled = false
local teamCheckEnabled = false
local hitboxEnabled = false
local aimbotEnabled = false

-- Keybinds
local espKey = Enum.KeyCode.E
local teamCheckKey = Enum.KeyCode.T
local hitboxKey = Enum.KeyCode.H
local aimbotKey = Enum.KeyCode.Q
local toggleUiKey = Enum.KeyCode.Insert

-- Function to toggle UI
local function toggleUI()
	screenGui.Enabled = not screenGui.Enabled
	blurEffect.Enabled = screenGui.Enabled
end

-- Function to show success message
local function showSuccessMessage()
	if successMessage then
		successMessage.Visible = true
		wait(3)
		successMessage.Visible = false
	end
	print("[?] Script executed successfully!")
end

-- ESP Function
local function toggleESP()
	espEnabled = not espEnabled
	print("ESP Toggled:", espEnabled)

	while espEnabled do
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local highlight = Instance.new("Highlight", player.Character)
				highlight.FillColor = teamCheckEnabled and (player.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)) or Color3.fromRGB(255, 0, 0)
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.Adornee = player.Character
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			end
		end
		wait(0.5)
	end
end

-- Hitbox Expander
local function toggleHitbox(size, transparency)
	hitboxEnabled = not hitboxEnabled
	print("Hitbox Expander Toggled:", hitboxEnabled)

	while hitboxEnabled do
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local head = player.Character.Head
				head.Size = Vector3.new(size, size, size)
				head.Transparency = transparency / 100
				head.Material = Enum.Material.Neon
				head.BrickColor = BrickColor.Red()
			end
		end
		wait(0.5)
	end
end

-- Aimbot
local function aimbot()
	aimbotEnabled = not aimbotEnabled
	print("Aimbot Toggled:", aimbotEnabled)

	while aimbotEnabled do
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local target = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
				if target then
					Mouse.TargetFilter = target
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, target.Position)
				end
			end
		end
		wait()
	end
end

-- UI Dragging
local dragging, dragInput, dragStart, startPos

local function updateInput(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateInput(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == toggleUiKey then
		toggleUI()
	elseif input.KeyCode == espKey then
		toggleESP()
	elseif input.KeyCode == teamCheckKey then
		teamCheckEnabled = not teamCheckEnabled
		print("Team Check Toggled:", teamCheckEnabled)
	elseif input.KeyCode == hitboxKey then
		toggleHitbox(5, 50)  -- Default size: 5, Transparency: 50%
	elseif input.KeyCode == aimbotKey then
		aimbot()
	end
end)

-- Initialize Script
showSuccessMessage()
