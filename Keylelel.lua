--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local timeoutData = {}

local function createKeySystemGui()
    local player = game.Players.LocalPlayer
    local playerId = player.UserId

    if not timeoutData[playerId] then
        timeoutData[playerId] = {attempts = 0, timeout = 0, lastFailedTime = 0, currentTimeoutLevel = 1}
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.Name = "Kitty Cats Doors Key"

    local frame = Instance.new("Frame")
    frame.Parent = screenGui
    frame.Size = UDim2.new(0, 400, 0, 200)
    frame.Position = UDim2.new(0.5, -200, 0.5, -100)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    frame.BorderColor3 = Color3.fromRGB(0, 0, 255)
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 20, 0, 5)
    title.Text = "Kitty Cats Doors Key"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.BackgroundTransparency = 1

    local description = Instance.new("TextLabel")
    description.Parent = frame
    description.Size = UDim2.new(1, -40, 0, 20)
    description.Position = UDim2.new(0, 20, 0, 35)
    description.Text = "UI made by SimpleScripter"
    description.TextColor3 = Color3.fromRGB(255, 255, 255)
    description.TextSize = 14
    description.BackgroundTransparency = 1

    local closeButton = Instance.new("TextButton")
    closeButton.Parent = frame
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(0, 5, 0, 5)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local keyBox = Instance.new("TextBox")
    keyBox.Parent = frame
    keyBox.Size = UDim2.new(0, 250, 0, 30)
    keyBox.Position = UDim2.new(0, 20, 0, 70)
    keyBox.PlaceholderText = "Enter key here"
    keyBox.Text = ""
    keyBox.TextSize = 14

    local checkButton = Instance.new("TextButton")
    checkButton.Parent = frame
    checkButton.Size = UDim2.new(0, 100, 0, 30)
    checkButton.Position = UDim2.new(0, 280, 0, 70)
    checkButton.Text = "Check Key"
    checkButton.TextSize = 14
    checkButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    checkButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

    -- Copy Key Button
    local copyButton = Instance.new("TextButton")
    copyButton.Parent = frame
    copyButton.Size = UDim2.new(0, 100, 0, 30)
    copyButton.Position = UDim2.new(0, 280, 0, 110)
    copyButton.Text = "Copy Dc"
    copyButton.TextSize = 14
    copyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    copyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

    -- Notification Label
    local notificationLabel = Instance.new("TextLabel")
    notificationLabel.Parent = frame
    notificationLabel.Size = UDim2.new(1, -40, 0, 30)
    notificationLabel.Position = UDim2.new(0, 20, 0, 150)
    notificationLabel.Text = "More Content Soon"
    notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationLabel.TextSize = 14
    notificationLabel.BackgroundTransparency = 1

    local timeoutLabel = Instance.new("TextLabel")
    timeoutLabel.Parent = frame
    timeoutLabel.Size = UDim2.new(1, -40, 0, 20)
    timeoutLabel.Position = UDim2.new(0, 20, 0, 180)
    timeoutLabel.Text = ""
    timeoutLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeoutLabel.TextSize = 12
    timeoutLabel.BackgroundTransparency = 1

    local secretKey = "kit"
    local timeoutIntervals = {120, 180, 240, 300, 600}

    local function updateTimeout()
        local currentTime = tick()
        if timeoutData[playerId].timeout > 0 and currentTime - timeoutData[playerId].lastFailedTime < timeoutData[playerId].timeout then
            timeoutLabel.Text = "Timed out: " .. math.ceil(timeoutData[playerId].timeout - (currentTime - timeoutData[playerId].lastFailedTime)) .. " seconds"
        else
            timeoutLabel.Text = ""
            timeoutData[playerId].timeout = 0
        end
    end

    
    copyButton.MouseButton1Click:Connect(function()
        local link = "https://discord.gg/QBRPjFwYVp"  
        setclipboard(link)
        notificationLabel.Text = "Copied link to clipboard"
        
        
        wait(2)
        notificationLabel.Text = ""
    end)

    checkButton.MouseButton1Click:Connect(function()
        local currentTime = tick()
        
        if timeoutData[playerId].attempts >= 10 then
            notificationLabel.Text = "You have been permanently timed out."
            return
        end

        if timeoutData[playerId].timeout > 0 and currentTime - timeoutData[playerId].lastFailedTime < timeoutData[playerId].timeout then
            notificationLabel.Text = "You are still timed out. Please wait."
            updateTimeout()
            return
        end

        if keyBox.Text == secretKey then
            notificationLabel.Text = "Key is correct, enjoy " .. player.Name .. "!"
            timeoutData[playerId].attempts = 0
            timeoutData[playerId].timeout = 0
            timeoutData[playerId].lastFailedTime = 0
            timeoutData[playerId].currentTimeoutLevel = 1
            timeoutLabel.Text = ""

            -- Load your custom script here
            local customScript = Instance.new("Script")
            customScript.Source = [[
                --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/CatEnddroid/Kitty-Cats-Doors-Beta/refs/heads/main/hub.lua"))()
            
            customScript.Parent = frame
        else
            notificationLabel.Text = "Incorrect key. Please try again."
            timeoutData[playerId].attempts = timeoutData[playerId].attempts + 1

            if timeoutData[playerId].attempts >= 10 then
                notificationLabel.Text = "You have been permanently timed out."
                timeoutData[playerId].timeout = math.huge
            elseif timeoutData[playerId].attempts % 3 == 0 then
                local level = math.min(timeoutData[playerId].currentTimeoutLevel, #timeoutIntervals)
                timeoutData[playerId].timeout = timeoutIntervals[level]
                timeoutData[playerId].lastFailedTime = currentTime
                timeoutData[playerId].currentTimeoutLevel = timeoutData[playerId].currentTimeoutLevel + 1
                notificationLabel.Text = "Too many incorrect attempts. Please wait."
                updateTimeout()
            end
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(updateTimeout)
end

local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(createKeySystemGui)
createKeySystemGui()
