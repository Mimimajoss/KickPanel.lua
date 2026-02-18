-- Simple Kick Panel - Save as "KickPanel.lua" on GitHub

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KickPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Gradient
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)), -- Purple
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180)) -- Pink
})
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Header.BackgroundTransparency = 0.3
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ KICK PANEL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Player List
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -20, 1, -60)
PlayerList.Position = UDim2.new(0, 10, 0, 50)
PlayerList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerList.BackgroundTransparency = 0.3
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 6
PlayerList.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
PlayerList.Parent = MainFrame

-- Layout
local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.Parent = PlayerList

-- Search Bar
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -20, 0, 30)
SearchBar.Position = UDim2.new(0, 10, 0, 10)
SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBar.BorderSizePixel = 0
SearchBar.PlaceholderText = "🔍 Search players..."
SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.Parent = PlayerList

-- Function to create player button
local function createPlayerButton(ply)
    local Button = Instance.new("TextButton")
    Button.Name = ply.Name
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.BackgroundTransparency = 0.2
    Button.BorderSizePixel = 0
    Button.Parent = PlayerList
    
    -- Player Name
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    NameLabel.Position = UDim2.new(0, 10, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = ply.Name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Button
    
    -- Kick Button
    local KickBtn = Instance.new("TextButton")
    KickBtn.Size = UDim2.new(0, 70, 0, 30)
    KickBtn.Position = UDim2.new(1, -80, 0.5, -15)
    KickBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    KickBtn.BorderSizePixel = 0
    KickBtn.Text = "KICK"
    KickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    KickBtn.Font = Enum.Font.GothamBold
    KickBtn.TextSize = 12
    KickBtn.Parent = Button
    
    -- Kick function
    KickBtn.MouseButton1Click:Connect(function()
        -- Show confirmation
        local ConfirmGui = Instance.new("ScreenGui")
        ConfirmGui.Name = "ConfirmGui"
        ConfirmGui.Parent = player.PlayerGui
        
        local ConfirmFrame = Instance.new("Frame")
        ConfirmFrame.Size = UDim2.new(0, 300, 0, 150)
        ConfirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
        ConfirmFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ConfirmFrame.BorderSizePixel = 0
        ConfirmFrame.Parent = ConfirmGui
        
        local ConfirmText = Instance.new("TextLabel")
        ConfirmText.Size = UDim2.new(1, 0, 0, 50)
        ConfirmText.Position = UDim2.new(0, 0, 0, 20)
        ConfirmText.BackgroundTransparency = 1
        ConfirmText.Text = "Kick " .. ply.Name .. "?"
        ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ConfirmText.Font = Enum.Font.GothamBold
        ConfirmText.TextSize = 16
        ConfirmText.Parent = ConfirmFrame
        
        local YesBtn = Instance.new("TextButton")
        YesBtn.Size = UDim2.new(0, 100, 0, 40)
        YesBtn.Position = UDim2.new(0.2, -50, 1, -50)
        YesBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        YesBtn.BorderSizePixel = 0
        YesBtn.Text = "YES"
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.Font = Enum.Font.GothamBold
        YesBtn.Parent = ConfirmFrame
        
        local NoBtn = Instance.new("TextButton")
        NoBtn.Size = UDim2.new(0, 100, 0, 40)
        NoBtn.Position = UDim2.new(0.8, -50, 1, -50)
        NoBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        NoBtn.BorderSizePixel = 0
        NoBtn.Text = "NO"
        NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        NoBtn.Font = Enum.Font.GothamBold
        NoBtn.Parent = ConfirmFrame
        
        YesBtn.MouseButton1Click:Connect(function()
            -- Try multiple kick methods
            local success, err = pcall(function()
                -- Method 1: Direct kick
                ply:Kick("Kicked by admin")
            end)
            
            if not success then
                pcall(function()
                    -- Method 2: Remove from game
                    ply:Destroy()
                end)
            end
            
            ConfirmGui:Destroy()
            print("Kicked: " .. ply.Name)
        end)
        
        NoBtn.MouseButton1Click:Connect(function()
            ConfirmGui:Destroy()
        end)
    end)
    
    return Button
end

-- Function to update player list
local function updatePlayerList()
    -- Clear existing buttons (except search bar and layout)
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Add players
    for _, ply in ipairs(Players:GetPlayers()) do
        if ply ~= player then
            createPlayerButton(ply)
        end
    end
end

-- Search functionality
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = string.lower(SearchBar.Text)
    
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            if searchText == "" or string.find(string.lower(child.Name), searchText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end)

-- Initial update
updatePlayerList()

-- Update when players join/leave
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Make draggable
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("✅ Kick Panel Loaded Successfully")
print("📋 Total players: " .. #Players:GetPlayers() - 1)
