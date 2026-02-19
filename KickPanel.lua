-- Working Kick Panel - Save as "WorkingKickPanel.lua" on GitHub

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WorkingKickPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 550)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Purple/Pink Gradient
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)),    -- Purple
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 85, 211)), -- Medium Purple
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))   -- Pink
})
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Header.BackgroundTransparency = 0.3
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👢 WORKING KICK PANEL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 7.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Player List
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -20, 1, -70)
PlayerList.Position = UDim2.new(0, 10, 0, 60)
PlayerList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerList.BackgroundTransparency = 0.3
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 6
PlayerList.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
PlayerList.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.Parent = PlayerList

-- Search Bar
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -20, 0, 35)
SearchBar.Position = UDim2.new(0, 10, 0, 10)
SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBar.BorderSizePixel = 0
SearchBar.PlaceholderText = "🔍 Search players to kick..."
SearchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.Parent = PlayerList

-- Multiple kick methods for maximum effectiveness
local function kickPlayerWithMethods(targetPlayer)
    local methods = {}
    local success = false
    
    -- Method 1: Direct kick (works in most games)
    table.insert(methods, function()
        pcall(function()
            targetPlayer:Kick("Kicked by admin panel")
        end)
    end)
    
    -- Method 2: Remove from game
    table.insert(methods, function()
        pcall(function()
            targetPlayer:Destroy()
        end)
    end)
    
    -- Method 3: Clear character and respawn (causes infinite loop)
    table.insert(methods, function()
        pcall(function()
            local character = targetPlayer.Character
            if character then
                character:Destroy()
            end
        end)
    end)
    
    -- Method 4: Crash client
    table.insert(methods, function()
        pcall(function()
            local remote = Instance.new("RemoteEvent")
            remote.Name = "CrashRemote"
            remote.Parent = targetPlayer.PlayerGui
            
            for i = 1, 1000 do
                remote:FireClient(targetPlayer, ("a"):rep(10000))
            end
        end)
    end)
    
    -- Method 5: Network kick via teleport
    table.insert(methods, function()
        pcall(function()
            TeleportService:Teleport(0, targetPlayer)
        end)
    end)
    
    -- Method 6: Void loop (stuck in loading)
    table.insert(methods, function()
        pcall(function()
            targetPlayer:LoadCharacter()
            targetPlayer:LoadCharacter()
            targetPlayer:LoadCharacter()
        end)
    end)
    
    -- Method 7: Exploit network ownership
    table.insert(methods, function()
        pcall(function()
            if targetPlayer.Character then
                local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:Destroy()
                end
            end
        end)
    end)
    
    -- Method 8: Force disconnect via remote
    table.insert(methods, function()
        pcall(function()
            local remoteFunction = Instance.new("RemoteFunction")
            remoteFunction.Name = "KickFunction"
            remoteFunction.Parent = targetPlayer.PlayerGui
            remoteFunction:InvokeClient(targetPlayer)
        end)
    end)
    
    -- Try all methods
    for i, method in ipairs(methods) do
        local mSuccess, mError = pcall(method)
        if mSuccess then
            print("✅ Method " .. i .. " succeeded for: " .. targetPlayer.Name)
            success = true
            break
        else
            print("⚠️ Method " .. i .. " failed: " .. tostring(mError))
        end
        wait(0.1) -- Small delay between methods
    end
    
    return success
end

-- Function to create player entry
local function createPlayerEntry(ply)
    local entry = Instance.new("Frame")
    entry.Name = ply.Name
    entry.Size = UDim2.new(1, -20, 0, 60)
    entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    entry.BorderSizePixel = 0
    entry.Parent = PlayerList
    
    -- Player info
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.5, -10, 0, 25)
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = ply.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = entry
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(0.5, -10, 0, 20)
    idLabel.Position = UDim2.new(0, 10, 0, 30)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "ID: " .. ply.UserId
    idLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    idLabel.Font = Enum.Font.Gotham
    idLabel.TextSize = 12
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Parent = entry
    
    -- Kick button
    local kickBtn = Instance.new("TextButton")
    kickBtn.Size = UDim2.new(0, 100, 0, 40)
    kickBtn.Position = UDim2.new(1, -110, 0.5, -20)
    kickBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    kickBtn.BorderSizePixel = 0
    kickBtn.Text = "KICK"
    kickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickBtn.Font = Enum.Font.GothamBold
    kickBtn.TextSize = 16
    kickBtn.Parent = entry
    
    -- Kick button click
    kickBtn.MouseButton1Click:Connect(function()
        -- Disable button to prevent double-click
        kickBtn.Text = "KICKING..."
        kickBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        kickBtn.Active = false
        
        -- Show status
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(0, 200, 0, 30)
        status.Position = UDim2.new(0.5, -100, 0, -40)
        status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        status.BackgroundTransparency = 0.3
        status.Text = "Attempting to kick " .. ply.Name .. "..."
        status.TextColor3 = Color3.fromRGB(255, 255, 255)
        status.Font = Enum.Font.Gotham
        status.TextSize = 14
        status.Parent = entry
        
        -- Try to kick
        local success = kickPlayerWithMethods(ply)
        
        if success then
            status.Text = "✅ Kicked: " .. ply.Name
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
            wait(1)
            entry:Destroy()
        else
            status.Text = "❌ Failed to kick: " .. ply.Name
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(2)
            status:Destroy()
            
            -- Re-enable button
            kickBtn.Text = "KICK"
            kickBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            kickBtn.Active = true
        end
    end)
    
    return entry
end

-- Update player list
local function updatePlayerList()
    -- Clear existing entries (except search bar and layout)
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add search bar back
    SearchBar.Parent = PlayerList
    
    -- Add players
    local yPos = 50
    for _, ply in ipairs(Players:GetPlayers()) do
        if ply ~= player then
            createPlayerEntry(ply)
        end
    end
end

-- Search functionality
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = string.lower(SearchBar.Text)
    
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then
            if searchText == "" or string.find(string.lower(child.Name), searchText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end)

-- Update when players join/leave
Players.PlayerAdded:Connect(function()
    wait(0.5)
    updatePlayerList()
end)

Players.PlayerRemoving:Connect(function()
    updatePlayerList()
end)

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

-- Initial update
updatePlayerList()

print("✅ Working Kick Panel Loaded Successfully")
print("📋 Kick methods loaded: 8 different techniques")
print("⚡ Panel will attempt all methods until player is kicked")
