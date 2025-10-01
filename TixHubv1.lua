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

	-- ScreenGui utama
	local screenGui = PlayerGui:FindFirstChild("DibzLib")
	if not screenGui then
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = "DibzLib"
		screenGui.Parent = PlayerGui
	end

	-- Main Frame
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
	header.BackgroundColor3 = DibzLib.Themes.Background
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
	statusLabel.Position = UDim2.new(0, 75, 0, 0)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = "["..version.."]"
	statusLabel.TextColor3 = DibzLib.Themes.Accent1
	statusLabel.Font = Enum.Font.Code
	statusLabel.TextSize = 18
	statusLabel.Parent = header
	
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 15)
	padding.Parent = header
	

	-- Close Button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0,30,0,24)
	closeBtn.Position = UDim2.new(1,-40,0,6)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
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

	-- Minimize Button
	local minBtn = Instance.new("TextButton")
	minBtn.Size = UDim2.new(0,30,0,24)
	minBtn.Position = UDim2.new(1,-75,0,6)
	minBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
	minBtn.BackgroundTransparency = 1
	minBtn.Text = "-"
	minBtn.TextColor3 = Color3.fromRGB(255,255,255)
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 18
	minBtn.Parent = header
	local minCorner = Instance.new("UICorner")
	minCorner.CornerRadius = UDim.new(0,6)
	minCorner.Parent = minBtn
	minBtn.MouseButton1Click:Connect(function()
		mainFrame.Visible = false
	end)

	-- RightShift toggle
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.RightShift then
			mainFrame.Visible = not mainFrame.Visible
		end
	end)

	-- Left Menu
	local leftMenu = Instance.new("Frame")
	leftMenu.Size = UDim2.new(0,150,1,-36)
	leftMenu.Position = UDim2.new(0,0,0,36)
	leftMenu.BackgroundColor3 = DibzLib.Themes.Background
	leftMenu.BackgroundTransparency = 1
	local leftCorner = Instance.new("UICorner")
	leftCorner.CornerRadius = UDim.new(0,0)
	leftCorner.Parent = leftMenu
	leftMenu.Parent = mainFrame

	-- Right Content
	local rightContent = Instance.new("Frame")
	rightContent.Size = UDim2.new(1,-150,1,-36)
	rightContent.Position = UDim2.new(0,150,0,36)
	rightContent.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	rightContent.BackgroundTransparency = 0.9
	local rightCorner = Instance.new("UICorner")
	rightCorner.CornerRadius = UDim.new(0,5)
	rightCorner.Parent = rightContent
	rightContent.Parent = mainFrame

	local leftMenuLayout = Instance.new("UIListLayout")
	leftMenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
	leftMenuLayout.Padding = UDim.new(0,4)
	leftMenuLayout.Parent = leftMenu

	Window.Sections = {}
	Window.LeftMenu = leftMenu
	Window.RightContent = rightContent

	-- Create Section
	function Window:CreateSection(name, iconId)
		local Section = {}
		Section.Name = name

		-- Frame konten
		Section.Frame = Instance.new("ScrollingFrame")
		Section.Frame.Size = UDim2.new(1,0,1,0)
		Section.Frame.Position = UDim2.new(0,0,0,0)
		Section.Frame.BackgroundTransparency = 1
		Section.Frame.Visible = false
		Section.Frame.CanvasSize = UDim2.new(0,0,0,0)
		Section.Frame.ScrollBarThickness = 8
		Section.Frame.Parent = rightContent

		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0,5)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.Parent = Section.Frame

		local paddingSec = Instance.new("UIPadding")
		paddingSec.PaddingTop = UDim.new(0,4)
		paddingSec.PaddingBottom = UDim.new(0,4)
		paddingSec.PaddingLeft = UDim.new(0,4)
		paddingSec.PaddingRight = UDim.new(0,4)
		paddingSec.Parent = Section.Frame

		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Section.Frame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
		end)

		-- Tambahkan Frame sebagai wadah untuk tombol dan leftbar
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 0, 35)
		container.BackgroundTransparency = 1
		container.Parent = leftMenu
		container.LayoutOrder = #Window.Sections + 1

		-- Tombol utama 
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -10, 1, 0) 
		btn.Position = UDim2.new(0, 5, 0, 0) 
		btn.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
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

		-- LeftBar highlight
		local leftBar = Instance.new("Frame")
		leftBar.Size = UDim2.new(0, 3, 1, 0) 
		leftBar.Position = UDim2.new(0, 5, 0, 0) 
		leftBar.BackgroundColor3 = DibzLib.Themes.Accent1
		leftBar.Visible = false
		leftBar.Parent = container
		local barCorner = Instance.new("UICorner")
		barCorner.CornerRadius = UDim.new(0,30)
		barCorner.Parent = leftBar

		Section.LeftBar = leftBar

		btn.MouseButton1Click:Connect(function()
			for _, sec in pairs(Window.Sections) do
				if sec.Icon then sec.Icon.ImageColor3 = DibzLib.Themes.Text end
				if sec.Frame then sec.Frame.Visible = false end
				if sec.LeftBar then sec.LeftBar.Visible = false end
				
				
			end

			Section.Frame.Visible = true
			Section.LeftBar.Visible = true
			
			icon.ImageColor3 = DibzLib.Themes.Accent1
		end)

		table.insert(Window.Sections, Section)

		-- Jika ini adalah section pertama, aktifkan secara default
		if #Window.Sections == 1 then
			Section.Frame.Visible = true
			Section.LeftBar.Visible = true
		end

		-- Functions: Button
		function Section:CreateButton(text, callback)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1,0,0,36)
			btn.BackgroundColor3 = DibzLib.Themes.Accent1
			btn.TextColor3 = DibzLib.Themes.Text
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 16
			btn.Text = text
			btn.Parent = Section.Frame
			btn.MouseButton1Click:Connect(callback)
			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0,6)
			btnCorner.Parent = btn
			return btn
		end

		-- Functions: Toggle
		function Section:CreateToggle(text, default, callback)
			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(1,0,0,36)
			toggle.BackgroundColor3 = DibzLib.Themes.Accent1
			toggle.TextColor3 = DibzLib.Themes.Text
			toggle.Font = Enum.Font.Gotham
			toggle.TextSize = 16
			local state = default or false
			toggle.Text = text.." ["..(state and "ON" or "OFF").."]"
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.Text = text.." ["..(state and "ON" or "OFF").."]"
				if callback then callback(state) end
			end)
			toggle.Parent = Section.Frame
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0,6)
			corner.Parent = toggle
			return toggle
		end

		-- Functions: Switch
		function Section:CreateSwitch(text, default, callback)
			local state = default or false
			local switchFrame = Instance.new("Frame")
			switchFrame.Size = UDim2.new(1,-10,0,35)
			switchFrame.Position = UDim2.new(2,5,2,10)
			switchFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
			switchFrame.BackgroundTransparency = 0.9
			switchFrame.Parent = Section.Frame
			local switchCorner = Instance.new("UICorner")
			switchCorner.CornerRadius = UDim.new(0,6)
			switchCorner.Parent = switchFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.7,0,1,0)
			label.Position = UDim2.new(0,10,0,0)
			label.BackgroundTransparency = 1
			label.Text = text
			label.TextColor3 = DibzLib.Themes.Text
			label.Font = Enum.Font.Gotham
			label.TextSize = 16
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = switchFrame

			local toggleBg = Instance.new("Frame")
			toggleBg.Size = UDim2.new(0,50,0,24)
			toggleBg.Position = UDim2.new(1,-70,0.5,-12)
			toggleBg.BackgroundColor3 = state and Color3.fromRGB(93, 61, 225) or Color3.fromRGB(100,100,100)
			toggleBg.BackgroundTransparency = 0.15
			toggleBg.BorderSizePixel = 0
			toggleBg.ClipsDescendants = true
			toggleBg.Parent = switchFrame
			local bgCorner = Instance.new("UICorner")
			bgCorner.CornerRadius = UDim.new(0,12)
			bgCorner.Parent = toggleBg

			local toggleCircle = Instance.new("Frame")
			toggleCircle.Size = UDim2.new(0,20,0,20)
			toggleCircle.Position = UDim2.new(state and 1 or 0, state and -20 or 0, 0, 2)
			toggleCircle.BackgroundColor3 = Color3.fromRGB(255,255,255)
			toggleCircle.BorderSizePixel = 0
			toggleCircle.Parent = toggleBg
			local circleCorner = Instance.new("UICorner")
			circleCorner.CornerRadius = UDim.new(0,10)
			circleCorner.Parent = toggleCircle

			local function UpdateSwitch()
				state = not state
				toggleBg.BackgroundColor3 = state and Color3.fromRGB(93,61,225) or Color3.fromRGB(100,100,100)
				toggleCircle:TweenPosition(UDim2.new(state and 1 or 0, state and -20 or 0,0,2),"Out","Quad",0.2,true)
				if callback then callback(state) end
			end

			toggleBg.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then UpdateSwitch() end
			end)
			label.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then UpdateSwitch() end
			end)

			return switchFrame
		end

		-- Functions: Dropdown
		function Section:CreateDropdown(name, options)
			local dropdown = {}

			local mainBtn = Instance.new("TextButton")
			mainBtn.Size = UDim2.new(1,-10,0,35)
			mainBtn.Position = UDim2.new(0,-10,0,0)
			mainBtn.BackgroundColor3 = DibzLib.Themes.Accent1
			mainBtn.Text = name.." ▼"
			mainBtn.TextColor3 = DibzLib.Themes.Text
			mainBtn.Font = Enum.Font.Gotham
			mainBtn.TextSize = 16
			mainBtn.Parent = Section.Frame
			mainBtn.Active = true
			mainBtn.Selectable = true
			mainBtn.Modal = true
			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0,6)
			btnCorner.Parent = mainBtn

			local dropdownFrame = Instance.new("Frame")
			dropdownFrame.Size = UDim2.new(1,0,0,0)
			dropdownFrame.ClipsDescendants = true
			dropdownFrame.BackgroundTransparency = 1
			dropdownFrame.Parent = Section.Frame

			local layout = Instance.new("UIListLayout")
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0,4)
			layout.Parent = dropdownFrame

			local itemHeight = 36
			local totalHeight = #options * (itemHeight + layout.Padding.Offset)

			dropdown.IsOpen = false
			mainBtn.MouseButton1Click:Connect(function()
				dropdown.IsOpen = not dropdown.IsOpen
				local targetSize = UDim2.new(1,0,0, dropdown.IsOpen and totalHeight or 0)
				dropdownFrame:TweenSize(targetSize, "Out", "Quad", 0.2, true)
			end)

			dropdown.Switches = {}
			dropdown.Buttons = {}
			
			for i, option in ipairs(options) do
				local itemFrame = Instance.new("Frame")
				itemFrame.Size = UDim2.new(1, 0, 0, itemHeight)
				itemFrame.BackgroundTransparency = 1
				itemFrame.Parent = dropdownFrame
				
				local itemControl
				
				if option.Type == "Button" then
					itemControl = Instance.new("TextButton")
					itemControl.Size = UDim2.new(1, -10, 1, -4)
					itemControl.Position = UDim2.new(0,5,0,2)
					itemControl.BackgroundColor3 = Color3.fromRGB(255,255,255)
					itemControl.BackgroundTransparency = 0.9
					itemControl.Text = option.Name
					itemControl.TextColor3 = DibzLib.Themes.Text
					itemControl.Font = Enum.Font.GothamBold
					itemControl.TextSize = 16
					itemControl.TextXAlignment = Enum.TextXAlignment.Center
					itemControl.Parent = itemFrame
					itemControl.Active = true
					itemControl.Selectable = true
					itemControl.Modal = true
					local btnCorner = Instance.new("UICorner")
					btnCorner.CornerRadius = UDim.new(0,6)
					btnCorner.Parent = itemControl
					
					-- logic
					itemControl.MouseButton1Click:Connect(function()
						if option.Callback then option.Callback() end
					end)
					
					table.insert(dropdown.Buttons, itemControl)
					
				elseif option.Type == "Switch" or not option.Type then
					
					local label = Instance.new("TextLabel")
					label.Size = UDim2.new(0.7,0,1,0)
					label.Position = UDim2.new(0,10,0,0)
					label.BackgroundTransparency = 1
					label.Text = option.Name
					label.TextColor3 = DibzLib.Themes.Text
					label.Font = Enum.Font.Gotham
					label.TextSize = 16
					label.TextXAlignment = Enum.TextXAlignment.Left
					label.Parent = itemFrame
					label.Active = true

					local toggleBg = Instance.new("Frame")
					toggleBg.Size = UDim2.new(0,50,0,24)
					toggleBg.Position = UDim2.new(1,-60,0.5,-12)
					toggleBg.BackgroundColor3 = option.Default and DibzLib.Themes.Accent1 or Color3.fromRGB(100,100,100)
					toggleBg.BackgroundTransparency = 0.15
					toggleBg.BorderSizePixel = 0
					toggleBg.ClipsDescendants = true
					toggleBg.Parent = itemFrame
					toggleBg.Active = true
					local bgCorner = Instance.new("UICorner")
					bgCorner.CornerRadius = UDim.new(0,12)
					bgCorner.Parent = toggleBg

					local toggleCircle = Instance.new("Frame")
					toggleCircle.Size = UDim2.new(0,20,0,20)
					toggleCircle.Position = UDim2.new(option.Default and 1 or 0, option.Default and -20 or 0,0,2)
					toggleCircle.BackgroundColor3 = Color3.fromRGB(255,255,255)
					toggleCircle.BorderSizePixel = 0
					toggleCircle.Parent = toggleBg
					local circleCorner = Instance.new("UICorner")
					circleCorner.CornerRadius = UDim.new(0,10)
					circleCorner.Parent = toggleCircle
					
					local state = option.Default or false
					local function updatePos()
						toggleCircle:TweenPosition(UDim2.new(state and 1 or 0, state and -20 or 0,0,2),"Out","Quad",0.2,true)
					end
					updatePos()

					local function toggle()
						state = not state
						toggleBg.BackgroundColor3 = state and DibzLib.Themes.Accent1 or Color3.fromRGB(100,100,100)
						updatePos()
						if option.Callback then option.Callback(state) end
					end
					toggleBg.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
					end)
					label.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
					end)

					table.insert(dropdown.Switches,itemFrame)
				end
			end

			return dropdown
		end

		return Section
	end
	
	do
		local isDragging = false
		local dragStartPos = Vector2.new(0,0)
		local originalPosition = mainFrame.Position
		local dragConnection
		
		local function dragFunction(input)
			local delta = input.Position - dragStartPos
			
			local x_scale = originalPosition.X.Scale
			local y_scale = originalPosition.Y.Scale
			local x_offset = originalPosition.X.Offset
			local y_offset = originalPosition.Y.Offset
			
			mainFrame.Position = UDim2.new (x_scale, x_offset + delta.X, y_scale, y_offset + delta.Y)
		end
		
		header.InputBegan:Connect(function(input, gameProcessed)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isDragging = true
			
			dragStartPos = input.Position
			originalPosition = mainFrame.Position
			
			header.Active = true
			dragConnection = UserInputService.InputChanged:Connect(function(input)
				if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					dragFunction(input)
				end
			end)
		end
	end)
		
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				isDragging = false
				header.Active = false
				
				if dragConnection then
					dragConnection:Disconnect()
					dragConnection = nil
				end
			end
		end)
	end

	return Window
end

-- LocalScript
local Window = DibzLib:CreateWindow("Tix Hub", "Owner")

local chargeRod = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
local fishStart = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RF/RequestFishingMinigameStarted"]
local Exclamation = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RE/ReplicateTextEffect"]
local fishEnd = game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_net@0.2.0"].net["RE/FishingCompleted"]

local autoFishEnabled = false

local Section1 = Window:CreateSection("Fishing", "rbxassetid://110079979376727")
local Dropdown1 = Section1:CreateDropdown("Auto Fishing", {
	{
		Name = "Enable Auto Fish (Perfect Cast)",
		Type = "Switch",
		Default = false,
		Callback = function(state)
			autoFishEnabled = state
			
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
	},
	{
		Name = "Enable Fish Radar",
		Type = "Switch",
		Callback = function(state)
			print("Enable Fish Radar", state)
		end,
	}
})

Section1:CreateSwitch("Test", false, function(state)
	print("Just Test", state)
end)


local Section2 = Window:CreateSection("Teleport", "rbxassetid://74776071011315")