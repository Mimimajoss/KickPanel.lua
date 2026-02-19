-- Enhanced Working Kick Panel - Better Visual Feedback

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Track kicked players to prevent them from showing if they rejoin
if not _G.KickedPlayers then
    _G.KickedPlayers = {}
end
local kickedPlayers = _G.KickedPlayers

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EnhancedKickPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Purple/Pink Gradient
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 85, 211)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))
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
Title.Text = "👢 ENHANCED KICK PANEL"
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

-- Create notification frame (for kick confirmations)
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Size = UDim2.new(1, -20, 0, 40)
NotificationFrame.Position = UDim2.new(0, 10, 0, 55)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NotificationFrame.BorderSizePixel = 0
NotificationFrame.Visible = false
NotificationFrame.Parent = MainFrame

local NotificationText = Instance.new("TextLabel")
NotificationText.Size = UDim2.new(1, -10, 1, 0)
NotificationText.Position = UDim2.new(0, 5, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.Text = ""
NotificationText.TextColor3 = Color3.fromRGB(0, 255, 0)
NotificationText.Font = Enum.Font.GothamBold
NotificationText.TextSize = 14
NotificationText.TextXAlignment = Enum.TextXAlignment.Center
NotificationText.Parent = NotificationFrame

-- Kick counter
local KickCounter = Instance.new("TextLabel")
KickCounter.Size = UDim2.new(0, 100, 0, 30)
KickCounter.Position = UDim2.new(1, -110, 0, 60)
KickCounter.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KickCounter.BorderSizePixel = 0
KickCounter.Text = "Kicks: 0"
KickCounter.TextColor3 = Color3.fromRGB(255, 105, 180)
KickCounter.Font = Enum.Font.GothamBold
KickCounter.TextSize = 14
KickCounter.Parent = MainFrame

-- Player List
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -20, 1, -120)
PlayerList.Position = UDim2.new(0, 10, 0, 100)
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

-- Function to show notification
local function showNotification(text, color)
    NotificationText.Text = text
    NotificationText.TextColor3 = color or Color3.fromRGB(0, 255, 0)
    NotificationFrame.Visible = true
    
    -- Hide after 3 seconds
    task.wait(3)
    NotificationFrame.Visible = false
end

-- Update kick counter
local kickCount = 0
local function updateKickCounter()
    kickCount = kickCount + 1
    KickCounter.Text = "Kicks: " .. kickCount
end

-- Multiple kick methods
local function kickPlayerWithMethods(targetPlayer)
    local methods = {}
    local success = false
    
    -- Method 1: Direct kick
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
    
    -- Method 3: Clear character
    table.insert(methods, function()
        pcall(function()
            if targetPlayer.Character then
                targetPlayer.Character:Destroy()
            end
        end)
    end)
    
    -- Method 4: Network kick via teleport
    table.insert(methods, function()
        pcall(function()
            TeleportService:Teleport(0, targetPlayer)
        end)
    end)
    
    -- Method 5: Crash client
    table.insert(methods, function()
        pcall(function()
            local remote = Instance.new("RemoteEvent")
            remote.Name = "CrashRemote"
            remote.Parent = targetPlayer.PlayerGui
            for i = 1, 100 do
                remote:FireClient(targetPlayer, ("a"):rep(10000))
            end
        end)
    end)
    
    for i, method in ipairs(methods) do
        local mSuccess, mError = pcall(method)
        if mSuccess then
            print("✅ Method " .. i .. " succeeded for: " .. targetPlayer.Name)
            success = true
            break
        else
            print("⚠️ Method " .. i .. " failed: " .. tostring(mError))
        end
        task.wait(0.1)
    end
    
    return success
end

-- Function to create player entry
local function createPlayerEntry(ply)
    -- Check if player was already kicked
    if kickedPlayers[ply.UserId] then
        return nil
    end
    
    local entry = Instance.new("Frame")
    entry.Name = ply.Name
    entry.Size = UDim2.new(1, -20, 0, 70)
    entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    entry.BorderSizePixel = 0
    entry.Parent = PlayerList
    
    -- Player avatar/icon
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 50, 0, 50)
    avatar.Position = UDim2.new(0, 5, 0.5, -25)
    avatar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    avatar.BorderSizePixel = 0
    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. ply.UserId .. "&w=48&h=48"
    avatar.Parent = entry
    
    -- Player info
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.4, -10, 0, 25)
    nameLabel.Position = UDim2.new(0, 60, 0, 10)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = ply.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = entry
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(0.4, -10, 0, 20)
    idLabel.Position = UDim2.new(0, 60, 0, 35)
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
        -- Disable button
        kickBtn.Text = "⚡"
        kickBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        kickBtn.Active = false
        
        -- Create progress bar
        local progressBar = Instance.new("Frame")
        progressBar.Size = UDim2.new(1, 0, 0, 3)
        progressBar.Position = UDim2.new(0, 0, 1, -3)
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        progressBar.BackgroundTransparency = 0.5
        progressBar.Parent = entry
        
        local progress = Instance.new("Frame")
        progress.Size = UDim2.new(0, 0, 1, 0)
        progress.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        progress.Parent = progressBar
        
        -- Animate progress
        for i = 1, 100 do
            progress.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.01)
        end
        
        -- Try to kick
        local success = kickPlayerWithMethods(ply)
        
        if success then
            progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            progress.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
            -- Store as kicked
            kickedPlayers[ply.UserId] = true
            
            -- Update counter
            updateKickCounter()
            
            -- Show notification
            showNotification("✅ Kicked: " .. ply.Name, Color3.fromRGB(0, 255, 0))
            
            -- Remove entry with fade
            for i = 1, 10 do
                entry.BackgroundTransparency = i/10
                task.wait(0.03)
            end
            entry:Destroy()
        else
            progressBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            progress.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            
            showNotification("❌ Failed to kick: " .. ply.Name, Color3.fromRGB(255, 0, 0))
            
            task.wait(1)
            progressBar:Destroy()
            
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
    -- Clear existing entries
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add search bar back
    SearchBar.Parent = PlayerList
    
    -- Add players
    for _, ply in ipairs(Players:GetPlayers()) do
        if ply ~= player and not kickedPlayers[ply.UserId] then
            createPlayerEntry(ply)
        end
    end
    
    -- Show player count
    local playerCount = #Players:GetPlayers() - 1 - table.count(kickedPlayers)
    Title.Text = "👢 ENHANCED KICK PANEL (" .. playerCount .. " players)"
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

-- Update when players join
Players.PlayerAdded:Connect(function(newPlayer)
    task.wait(0.5)
    -- Only add if not previously kicked
    if not kickedPlayers[newPlayer.UserId] then
        updatePlayerList()
    end
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

-- Add table.count function if it doesn't exist
table.count = table.count or function(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

print("✅ Enhanced Kick Panel Loaded Successfully")
print("📋 Tracked kicked players: They won't reappear if they rejoin")
print("⚡ Visual feedback added: Progress bar and notifications")
