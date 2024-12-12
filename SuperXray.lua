-- Modular Script Library with Navigation
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Main Screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.5, -250, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
frame.Parent = screenGui
frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Dragging functionality
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        update(input)
    end
end)

-- Rounded Corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Title Label
local title = Instance.new("TextLabel")
title.Text = "Script Library"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Tabs Navigation
local tabs = {"Main", "ESP", "Super X-Ray"}
local currentTab = nil
local tabFrames = {}

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
tabBar.Parent = frame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 10)
tabCorner.Parent = tabBar

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Text = tabName
    tabButton.Size = UDim2.new(0, 100, 0, 30)
    tabButton.Position = UDim2.new(0, (i - 1) * 110, 0, 5)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    tabButton.TextScaled = true
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = tabBar

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = tabButton

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -20, 1, -80)
    tabFrame.Position = UDim2.new(0, 10, 0, 80)
    tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    tabFrame.Visible = (i == 1)
    tabFrame.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = tabFrame

    tabFrames[tabName] = tabFrame

    tabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabFrames) do
            tab.Visible = false
        end
        tabFrame.Visible = true
    end)
end

-- Main Tab Content
local mainLabel = Instance.new("TextLabel")
mainLabel.Text = "Welcome to Script Library!"
mainLabel.Size = UDim2.new(1, -20, 0, 50)
mainLabel.Position = UDim2.new(0, 10, 0, 10)
mainLabel.BackgroundTransparency = 1
mainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainLabel.TextScaled = true
mainLabel.Font = Enum.Font.Gotham
mainLabel.Parent = tabFrames["Main"]

-- ESP Tab Content
local espLabel = Instance.new("TextLabel")
espLabel.Text = "ESP Feature Coming Soon!"
espLabel.Size = UDim2.new(1, -20, 0, 50)
espLabel.Position = UDim2.new(0, 10, 0, 10)
espLabel.BackgroundTransparency = 1
espLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
espLabel.TextScaled = true
espLabel.Font = Enum.Font.Gotham
espLabel.Parent = tabFrames["ESP"]

-- Super X-Ray Tab Content
local xrayButton = Instance.new("TextButton")
xrayButton.Text = "Activate Super X-Ray"
xrayButton.Size = UDim2.new(0, 200, 0, 40)
xrayButton.Position = UDim2.new(0, 10, 0, 10)
xrayButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
xrayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
xrayButton.TextScaled = true
xrayButton.Font = Enum.Font.Gotham
xrayButton.Parent = tabFrames["Super X-Ray"]

local function activateXRay()
    local xrayGui = Instance.new("ScreenGui")
    xrayGui.Parent = Player:WaitForChild("PlayerGui")

    local xrayFrame = Instance.new("Frame")
    xrayFrame.Size = UDim2.new(0, 500, 0, 300)
    xrayFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    xrayFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    xrayFrame.Parent = xrayGui
    xrayFrame.AnchorPoint = Vector2.new(0.5, 0.5)

    local xrayCorner = Instance.new("UICorner")
    xrayCorner.CornerRadius = UDim.new(0, 15)
    xrayCorner.Parent = xrayFrame

    local title = Instance.new("TextLabel")
    title.Text = "Super X-Ray"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(200, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = xrayFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 10)
    closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = xrayFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 5)
    closeCorner.Parent = closeButton

    closeButton.MouseButton1Click:Connect(function()
        xrayGui:Destroy()
    end)
end

xrayButton.MouseButton1Click:Connect(function()
    activateXRay()
end)
