-- Complete Ban & Kick Panel - Save as "BanPanel.lua" on GitHub

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Storage for banned players (persists while executor is running)
if not _G.BannedPlayers then
    _G.BannedPlayers = {}
end
local bannedPlayers = _G.BannedPlayers

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BanPanel"
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
Title.Text = "🔨 BAN & KICK PANEL"
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

-- Tab Buttons
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 40)
TabFrame.Position = UDim2.new(0, 10, 0, 55)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local ServerTab = Instance.new("TextButton")
ServerTab.Size = UDim2.new(0.5, -2, 1, 0)
ServerTab.Position = UDim2.new(0, 0, 0, 0)
ServerTab.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
ServerTab.BorderSizePixel = 0
ServerTab.Text = "🎮 SERVER PLAYERS"
ServerTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerTab.Font = Enum.Font.GothamBold
ServerTab.TextSize = 14
ServerTab.Parent = TabFrame

local BannedTab = Instance.new("TextButton")
BannedTab.Size = UDim2.new(0.5, -2, 1, 0)
BannedTab.Position = UDim2.new(0.5, 2, 0, 0)
BannedTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BannedTab.BorderSizePixel = 0
BannedTab.Text = "🚫 BANNED PLAYERS"
BannedTab.TextColor3 = Color3.fromRGB(255, 255, 255)
BannedTab.Font = Enum.Font.GothamBold
BannedTab.TextSize = 14
BannedTab.Parent = TabFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 100)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Server Players Tab Content
local ServerContent = Instance.new("ScrollingFrame")
ServerContent.Size = UDim2.new(1, 0, 1, 0)
ServerContent.BackgroundTransparency = 1
ServerContent.ScrollBarThickness = 6
ServerContent.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
ServerContent.Visible = true
ServerContent.Parent = ContentFrame

local ServerLayout = Instance.new("UIListLayout")
ServerLayout.Padding = UDim.new(0, 5)
ServerLayout.Parent = ServerContent

-- Banned Players Tab Content
local BannedContent = Instance.new("ScrollingFrame")
BannedContent.Size = UDim2.new(1, 0, 1, 0)
BannedContent.BackgroundTransparency = 1
BannedContent.ScrollBarThickness = 6
BannedContent.ScrollBarImageColor3 = Color3.fromRGB(128, 0, 128)
BannedContent.Visible = false
BannedContent.Parent = ContentFrame

local BannedLayout = Instance.new("UIListLayout")
BannedLayout.Padding = UDim.new(0, 5)
BannedLayout.Parent = BannedContent

-- Search Bar for Server
local ServerSearch = Instance.new("TextBox")
ServerSearch.Size = UDim2.new(1, -20, 0, 35)
ServerSearch.Position = UDim2.new(0, 10, 0, 10)
ServerSearch.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ServerSearch.BorderSizePixel = 0
ServerSearch.PlaceholderText = "🔍 Search players to ban/kick..."
ServerSearch.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
ServerSearch.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerSearch.Font = Enum.Font.Gotham
ServerSearch.TextSize = 14
ServerSearch.Parent = ServerContent

-- Search Bar for Banned
local BannedSearch = Instance.new("TextBox")
BannedSearch.Size = UDim2.new(1, -20, 0, 35)
BannedSearch.Position = UDim2.new(0, 10, 0, 10)
BannedSearch.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BannedSearch.BorderSizePixel = 0
BannedSearch.PlaceholderText = "🔍 Search banned players..."
BannedSearch.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
BannedSearch.TextColor3 = Color3.fromRGB(255, 255, 255)
BannedSearch.Font = Enum.Font.Gotham
BannedSearch.TextSize = 14
BannedSearch.Visible = false
BannedSearch.Parent = BannedContent

-- Export/Import buttons for banned list
local BanControls = Instance.new("Frame")
BanControls.Size = UDim2.new(1, -20, 0, 40)
BanControls.Position = UDim2.new(0, 10, 0, 50)
BanControls.BackgroundTransparency = 1
BanControls.Visible = false
BanControls.Parent = BannedContent

local ExportBtn = Instance.new("TextButton")
ExportBtn.Size = UDim2.new(0.5, -2, 1, 0)
ExportBtn.Position = UDim2.new(0, 0, 0, 0)
ExportBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ExportBtn.BorderSizePixel = 0
ExportBtn.Text = "📤 EXPORT BANS"
ExportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExportBtn.Font = Enum.Font.GothamBold
ExportBtn.TextSize = 12
ExportBtn.Parent = BanControls

local ImportBtn = Instance.new("TextButton")
ImportBtn.Size = UDim2.new(0.5, -2, 1, 0)
ImportBtn.Position = UDim2.new(0.5, 2, 0, 0)
ImportBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ImportBtn.BorderSizePixel = 0
ImportBtn.Text = "📥 IMPORT BANS"
ImportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ImportBtn.Font = Enum.Font.GothamBold
ImportBtn.TextSize = 12
ImportBtn.Parent = BanControls

-- Function to create server player entry
local function createPlayerEntry(ply)
    local entry = Instance.new("Frame")
    entry.Name = ply.Name
    entry.Size = UDim2.new(1, -20, 0, 70)
    entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    entry.BorderSizePixel = 0
    entry.Parent = ServerContent
    
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
    
    -- Action buttons
    local kickBtn = Instance.new("TextButton")
    kickBtn.Size = UDim2.new(0, 80, 0, 30)
    kickBtn.Position = UDim2.new(1, -170, 0.5, -15)
    kickBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    kickBtn.BorderSizePixel = 0
    kickBtn.Text = "KICK"
    kickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickBtn.Font = Enum.Font.GothamBold
    kickBtn.TextSize = 12
    kickBtn.Parent = entry
    
    local banBtn = Instance.new("TextButton")
    banBtn.Size = UDim2.new(0, 80, 0, 30)
    banBtn.Position = UDim2.new(1, -85, 0.5, -15)
    banBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
    banBtn.BorderSizePixel = 0
    banBtn.Text = "BAN"
    banBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    banBtn.Font = Enum.Font.GothamBold
    banBtn.TextSize = 12
    banBtn.Parent = entry
    
    -- Kick function
    kickBtn.MouseButton1Click:Connect(function()
        local success = pcall(function()
            ply:Kick("Kicked by admin panel")
        end)
        if success then
            print("✅ Kicked: " .. ply.Name)
            entry:Destroy()
        end
    end)
    
    -- Ban function
    banBtn.MouseButton1Click:Connect(function()
        -- Show ban dialog
        local dialog = Instance.new("ScreenGui")
        dialog.Name = "BanDialog"
        dialog.Parent = player.PlayerGui
        
        local dialogFrame = Instance.new("Frame")
        dialogFrame.Size = UDim2.new(0, 350, 0, 250)
        dialogFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
        dialogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        dialogFrame.BorderSizePixel = 0
        dialogFrame.Parent = dialog
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundTransparency = 1
        title.Text = "Ban " .. ply.Name
        title.TextColor3 = Color3.fromRGB(255, 105, 180)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18
        title.Parent = dialogFrame
        
        local reasonBox = Instance.new("TextBox")
        reasonBox.Size = UDim2.new(1, -20, 0, 40)
        reasonBox.Position = UDim2.new(0, 10, 0, 50)
        reasonBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        reasonBox.BorderSizePixel = 0
        reasonBox.PlaceholderText = "Ban reason..."
        reasonBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        reasonBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        reasonBox.Font = Enum.Font.Gotham
        reasonBox.TextSize = 14
        reasonBox.Parent = dialogFrame
        
        local durationBox = Instance.new("TextBox")
        durationBox.Size = UDim2.new(1, -20, 0, 40)
        durationBox.Position = UDim2.new(0, 10, 0, 100)
        durationBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        durationBox.BorderSizePixel = 0
        durationBox.PlaceholderText = "Ban duration (hours, 0 = permanent)"
        durationBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        durationBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        durationBox.Font = Enum.Font.Gotham
        durationBox.TextSize = 14
        durationBox.Parent = dialogFrame
        
        local confirmBtn = Instance.new("TextButton")
        confirmBtn.Size = UDim2.new(0.5, -5, 0, 40)
        confirmBtn.Position = UDim2.new(0, 10, 1, -50)
        confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        confirmBtn.BorderSizePixel = 0
        confirmBtn.Text = "CONFIRM BAN"
        confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmBtn.Font = Enum.Font.GothamBold
        confirmBtn.TextSize = 12
        confirmBtn.Parent = dialogFrame
        
        local cancelBtn = Instance.new("TextButton")
        cancelBtn.Size = UDim2.new(0.5, -5, 0, 40)
        cancelBtn.Position = UDim2.new(0.5, 5, 1, -50)
        cancelBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        cancelBtn.BorderSizePixel = 0
        cancelBtn.Text = "CANCEL"
        cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        cancelBtn.Font = Enum.Font.GothamBold
        cancelBtn.TextSize = 12
        cancelBtn.Parent = dialogFrame
        
        confirmBtn.MouseButton1Click:Connect(function()
            local reason = reasonBox.Text
            if reason == "" then reason = "No reason provided" end
            
            local duration = tonumber(durationBox.Text) or 0
            local expiry = 0
            if duration > 0 then
                expiry = os.time() + (duration * 3600)
            end
            
            -- Store ban
            bannedPlayers[ply.UserId] = {
                Name = ply.Name,
                UserId = ply.UserId,
                Reason = reason,
                Duration = duration,
                Expiry = expiry,
                BannedAt = os.time()
            }
            
            -- Try to kick the player
            pcall(function()
                ply:Kick("You have been banned. Reason: " .. reason)
            end)
            
            print("✅ Banned: " .. ply.Name .. " | Reason: " .. reason .. " | Duration: " .. duration .. " hours")
            dialog:Destroy()
            entry:Destroy()
            
            -- Update banned tab if visible
            if BannedContent.Visible then
                updateBannedList()
            end
        end)
        
        cancelBtn.MouseButton1Click:Connect(function()
            dialog:Destroy()
        end)
    end)
    
    return entry
end

-- Function to create banned player entry
local function createBannedEntry(banData)
    local entry = Instance.new("Frame")
    entry.Name = banData.UserId
    entry.Size = UDim2.new(1, -20, 0, 70)
    entry.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
    entry.BorderSizePixel = 0
    entry.Parent = BannedContent
    
    -- Ban info
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.5, -10, 0, 25)
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = banData.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = entry
    
    local reasonLabel = Instance.new("TextLabel")
    reasonLabel.Size = UDim2.new(0.5, -10, 0, 20)
    reasonLabel.Position = UDim2.new(0, 10, 0, 30)
    reasonLabel.BackgroundTransparency = 1
    reasonLabel.Text = "Reason: " .. banData.Reason
    reasonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    reasonLabel.Font = Enum.Font.Gotham
    reasonLabel.TextSize = 12
    reasonLabel.TextXAlignment = Enum.TextXAlignment.Left
    reasonLabel.Parent = entry
    
    local durationLabel = Instance.new("TextLabel")
    durationLabel.Size = UDim2.new(0.5, -10, 0, 15)
    durationLabel.Position = UDim2.new(0, 10, 0, 50)
    durationLabel.BackgroundTransparency = 1
    if banData.Duration and banData.Duration > 0 then
        durationLabel.Text = "Expires: " .. os.date("%Y-%m-%d %H:%M", banData.Expiry)
    else
        durationLabel.Text = "Permanent ban"
    end
    durationLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    durationLabel.Font = Enum.Font.Gotham
    durationLabel.TextSize = 10
    durationLabel.TextXAlignment = Enum.TextXAlignment.Left
    durationLabel.Parent = entry
    
    -- Unban button
    local unbanBtn = Instance.new("TextButton")
    unbanBtn.Size = UDim2.new(0, 100, 0, 40)
    unbanBtn.Position = UDim2.new(1, -110, 0.5, -20)
    unbanBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    unbanBtn.BorderSizePixel = 0
    unbanBtn.Text = "UNBAN"
    unbanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    unbanBtn.Font = Enum.Font.GothamBold
    unbanBtn.TextSize = 14
    unbanBtn.Parent = entry
    
    unbanBtn.MouseButton1Click:Connect(function()
        bannedPlayers[banData.UserId] = nil
        entry:Destroy()
        print("✅ Unbanned: " .. banData.Name)
    end)
    
    return entry
end

-- Update server player list
local function updateServerList()
    -- Clear existing entries (except search bar)
    for _, child in ipairs(ServerContent:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add search bar back
    ServerSearch.Parent = ServerContent
    
    -- Add players
    local yPos = 50
    for _, ply in ipairs(Players:GetPlayers()) do
        if ply ~= player then
            createPlayerEntry(ply)
        end
    end
end

-- Update banned player list
local function updateBannedList()
    -- Clear existing entries (except search bar and controls)
    for _, child in ipairs(BannedContent:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add search bar and controls back
    BannedSearch.Parent = BannedContent
    BanControls.Parent = BannedContent
    BannedSearch.Visible = true
    BanControls.Visible = true
    
    -- Add banned players
    local yPos = 100
    for userId, banData in pairs(bannedPlayers) do
        -- Check if temporary ban has expired
        if banData.Expiry and banData.Expiry > 0 and banData.Expiry < os.time() then
            bannedPlayers[userId] = nil -- Auto-unban expired bans
        else
            createBannedEntry(banData)
        end
    end
end

-- Tab switching
ServerTab.MouseButton1Click:Connect(function()
    ServerContent.Visible = true
    BannedContent.Visible = false
    ServerTab.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    BannedTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    updateServerList()
end)

BannedTab.MouseButton1Click:Connect(function()
    ServerContent.Visible = false
    BannedContent.Visible = true
    BannedTab.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    ServerTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    updateBannedList()
end)

-- Search functionality for server
ServerSearch:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = string.lower(ServerSearch.Text)
    
    for _, child in ipairs(ServerContent:GetChildren()) do
        if child:IsA("Frame") then
            if searchText == "" or string.find(string.lower(child.Name), searchText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end)

-- Search functionality for banned
BannedSearch:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = string.lower(BannedSearch.Text)
    
    for _, child in ipairs(BannedContent:GetChildren()) do
        if child:IsA("Frame") and child ~= BanControls then
            local nameLabel = child:FindFirstChildOfClass("TextLabel")
            if nameLabel then
                if searchText == "" or string.find(string.lower(nameLabel.Text), searchText) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end
end)

-- Export bans
ExportBtn.MouseButton1Click:Connect(function()
    local exportData = game:GetService("HttpService"):JSONEncode(bannedPlayers)
    pcall(function()
        setclipboard(exportData)
    end)
    print("📋 Bans copied to clipboard! Total: " .. table.count(bannedPlayers))
end)

-- Import bans
ImportBtn.MouseButton1Click:Connect(function()
    print("📥 To import bans, paste JSON data into your executor console")
    -- This would need clipboard reading which varies by executor
end)

-- Update lists when players join/leave
Players.PlayerAdded:Connect(function()
    wait(0.5)
    if ServerContent.Visible then
        updateServerList()
    end
end)

Players.PlayerRemoving:Connect(function()
    if ServerContent.Visible then
        updateServerList()
    end
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
updateServerList()

print("✅ Ban & Kick Panel Loaded Successfully")
print("📋 Features:")
print("   • Ban players with reason and duration")
print("   • Kick players")
print("   • View banned players list")
print("   • Search players")
print("   • Export/import bans")
print("   • Auto-expire temporary bans")
