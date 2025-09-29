--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

loadstring([==[
-- DibzLib (modul full dimasukkan di sini)
local UserInputService = game:GetService("UserInputService")
local DibzLib = {}

DibzLib.Themes = {
    Accent1 = Color3.fromRGB(93, 61, 255),
    Accent2 = Color3.fromRGB(218, 218, 218),
    Background = Color3.fromRGB(0, 0, 0),
    Text = Color3.fromRGB(255, 255, 255)
}

function DibzLib:CreateWindow(title, version)
    local Window = {}
    local Player = game.Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    local screenGui = PlayerGui:FindFirstChild("DibzLib")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "DibzLib"
        screenGui.Parent = PlayerGui
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.Parent = screenGui
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1,0,0,36)
    header.BackgroundTransparency = 1
    header.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 150, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = DibzLib.Themes.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextSize = 20
    titleLabel.Parent = header

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 60, 1, 0)
    statusLabel.Position = UDim2.new(0, 90, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "["..version.."]"
    statusLabel.TextColor3 = DibzLib.Themes.Accent1
    statusLabel.Font = Enum.Font.Code
    statusLabel.TextSize = 18
    statusLabel.Parent = header

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0,30,0,24)
    closeBtn.Position = UDim2.new(1,-40,0,6)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.Parent = header
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0,6)
    closeCorner.Parent = closeBtn
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame:Destroy()
    end)

    -- RightShift toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    local leftMenu = Instance.new("Frame")
    leftMenu.Size = UDim2.new(0,150,1,-36)
    leftMenu.Position = UDim2.new(0,0,0,36)
    leftMenu.BackgroundTransparency = 1
    leftMenu.Parent = mainFrame

    local rightContent = Instance.new("Frame")
    rightContent.Size = UDim2.new(1,-150,1,-36)
    rightContent.Position = UDim2.new(0,150,0,36)
    rightContent.BackgroundTransparency = 0.9
    rightContent.BackgroundColor3 = Color3.fromRGB(200,200,200)
    rightContent.Parent = mainFrame

    local leftMenuLayout = Instance.new("UIListLayout")
    leftMenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
    leftMenuLayout.Padding = UDim.new(0,4)
    leftMenuLayout.Parent = leftMenu

    Window.Sections = {}
    Window.LeftMenu = leftMenu
    Window.RightContent = rightContent

    function Window:CreateSection(name, iconId)
        local Section = {}
        Section.Frame = Instance.new("ScrollingFrame")
        Section.Frame.Size = UDim2.new(1,0,1,0)
        Section.Frame.Position = UDim2.new(0,0,0,0)
        Section.Frame.BackgroundTransparency = 1
        Section.Frame.Visible = false
        Section.Frame.Parent = rightContent
        Section.Name = name

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,5)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Parent = Section.Frame

        local container = Instance.new("Frame")
        container.Size = UDim2.new(1,0,0,35)
        container.BackgroundTransparency = 1
        container.Parent = leftMenu
        container.LayoutOrder = #Window.Sections + 1

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-10,1,0)
        btn.Position = UDim2.new(0,5,0,0)
        btn.BackgroundColor3 = Color3.fromRGB(95,95,95)
        btn.BackgroundTransparency = 0.7
        btn.TextColor3 = DibzLib.Themes.Text
        btn.Text = ""
        btn.Parent = container
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,6)
        btnCorner.Parent = btn

        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0,20,0,20)
        icon.Position = UDim2.new(0,10,0.5,-10)
        icon.BackgroundTransparency = 1
        icon.Image = iconId
        icon.ImageColor3 = DibzLib.Themes.Text
        icon.ScaleType = Enum.ScaleType.Fit
        icon.Parent = btn

        Section.Icon = icon

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1,-40,1,0)
        textLabel.Position = UDim2.new(0,35,0,0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = name
        textLabel.TextColor3 = DibzLib.Themes.Text
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 16
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = btn

        local leftBar = Instance.new("Frame")
        leftBar.Size = UDim2.new(0,3,1,0)
        leftBar.Position = UDim2.new(0,5,0,0)
        leftBar.BackgroundColor3 = DibzLib.Themes.Accent1
        leftBar.Visible = false
        leftBar.Parent = container
        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(0,30)
        barCorner.Parent = leftBar
        Section.LeftBar = leftBar

        btn.MouseButton1Click:Connect(function()
            for _, sec in pairs(Window.Sections) do
                if sec.Frame then sec.Frame.Visible = false end
                if sec.LeftBar then sec.LeftBar.Visible = false end
                if sec.Icon then sec.Icon.ImageColor3 = DibzLib.Themes.Text end
            end
            Section.Frame.Visible = true
            Section.LeftBar.Visible = true
            icon.ImageColor3 = DibzLib.Themes.Accent1
        end)

        table.insert(Window.Sections, Section)

        function Section:CreateDropdown(name, options)
            local dropdown = {}
            local mainBtn = Instance.new("TextButton")
            mainBtn.Size = UDim2.new(1,-10,0,35)
            mainBtn.Position = UDim2.new(0,0,0,0)
            mainBtn.BackgroundColor3 = DibzLib.Themes.Accent1
            mainBtn.TextColor3 = DibzLib.Themes.Text
            mainBtn.Font = Enum.Font.Gotham
            mainBtn.TextSize = 16
            mainBtn.Text = name.." ▼"
            mainBtn.Parent = Section.Frame
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0,6)
            btnCorner.Parent = mainBtn

            dropdown.IsOpen = false
            mainBtn.MouseButton1Click:Connect(function()
                dropdown.IsOpen = not dropdown.IsOpen
            end)

            for i, option in ipairs(options) do
                if option.Type == "Switch" then
                    local toggleBtn = Instance.new("TextButton")
                    toggleBtn.Size = UDim2.new(1,0,0,36)
                    toggleBtn.Text = option.Name.." [OFF]"
                    toggleBtn.BackgroundColor3 = DibzLib.Themes.Accent1
                    toggleBtn.TextColor3 = DibzLib.Themes.Text
                    toggleBtn.Parent = Section.Frame
                    toggleBtn.MouseButton1Click:Connect(function()
                        local state = toggleBtn.Text:find("OFF") == nil
                        state = not state
                        toggleBtn.Text = option.Name.." ["..(state and "ON" or "OFF").."]"
                        if option.Callback then option.Callback(state) end
                    end)
                end
            end
            return dropdown
        end

        return Section
    end

    return Window
end

-- End of DibzLib Module

-- Main Script
local Window = DibzLib:CreateWindow("Dibz Hub", "Owner")

local chargeRod = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
local fishStart = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RF/RequestFishingMinigameStarted"]
local fishEnd = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RE/FishingCompleted"]

local Section1 = Window:CreateSection("Fishing", "rbxassetid://110079979376727")
local Dropdown1 = Section1:CreateDropdown("Auto Fishing", {
    {
        Name = "Enable Auto Fish (Perfect Cast)",
        Type = "Switch",
        Default = false,
        Callback = function(state)
            local autoFishEnabled = state
            if state then
                spawn(function()
                    while autoFishEnabled do
                        chargeRod:InvokeServer(os.clock())
                        task.wait(0.5)
                        chargeRod:InvokeServer(os.clock())
                        local args = {-0.5718746185302734, 0.9662137511959348}
                        fishStart:InvokeServer(unpack(args))
                        task.wait(2.56)
                        fishEnd:FireServer()
                    end
                end)
            end
        end,
    }
})

]==])();