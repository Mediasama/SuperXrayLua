-- X-Ray Part Detector with Enhanced Particle Information
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Main Screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Player:WaitForChild("PlayerGui")

-- Main Frame
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
title.Text = "X-Ray Particle Detector"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Highlighted Part Info
local infoLabel = Instance.new("TextLabel")
infoLabel.Text = "No part selected"
infoLabel.Size = UDim2.new(1, -20, 0, 50)
infoLabel.Position = UDim2.new(0, 10, 0, 50)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = frame

-- Highlight Functionality
local highlightedPart = nil

local function highlightPart(part)
    if highlightedPart and highlightedPart:FindFirstChild("Highlight") then
        highlightedPart.Highlight:Destroy()
    end

    if part then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(128, 0, 255)
        highlight.OutlineTransparency = 0.7
        highlight.Parent = part
        highlightedPart = part

        infoLabel.Text = "Selected Part: " .. part.Name .. "\nParent: " .. (part.Parent and part.Parent.Name or "None") .. "\nChildren: " .. #part:GetChildren()
    else
        highlightedPart = nil
        infoLabel.Text = "No part selected"
    end
end

-- X-Ray Functionality
local function toggleVisibility(part)
    if part then
        part.Transparency = part.Transparency == 0 and 0.7 or 0
    end
end

-- Part Selection and X-Ray
local function onMouseClick()
    local mouse = Player:GetMouse()
    local target = mouse.Target

    if target and target:IsA("BasePart") then
        highlightPart(target)
    else
        highlightPart(nil)
    end
end

local xrayButton = Instance.new("TextButton")
xrayButton.Text = "Toggle X-Ray"
xrayButton.Size = UDim2.new(0, 150, 0, 40)
xrayButton.Position = UDim2.new(0.5, -75, 1, -100) -- Подняли кнопку выше
xrayButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
xrayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
xrayButton.TextScaled = true
xrayButton.Font = Enum.Font.Gotham
xrayButton.Parent = frame

local xrayCorner = Instance.new("UICorner")
xrayCorner.CornerRadius = UDim.new(0, 10)
xrayCorner.Parent = xrayButton

xrayButton.MouseButton1Click:Connect(function()
    if highlightedPart then
        toggleVisibility(highlightedPart)
    end
end)

Player:GetMouse().Button1Down:Connect(onMouseClick)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "-"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -80, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.Parent = frame

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 5)
minimizeCorner.Parent = minimizeButton

local isMinimized = false

minimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        frame.Size = UDim2.new(0, 150, 0, 50)
        minimizeButton.Text = "+"
        isMinimized = true
    else
        frame.Size = UDim2.new(0, 500, 0, 300)
        minimizeButton.Text = "-"
        isMinimized = false
    end
end)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Footer
local footer = Instance.new("TextLabel")
footer.Text = "Enhanced X-Ray Particle Detector"
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(150, 150, 255)
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.Parent = frame
