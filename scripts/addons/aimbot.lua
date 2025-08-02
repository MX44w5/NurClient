

-- Instances

local nuraim = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Text = Instance.new("TextLabel")

-- Properties

nuraim.Name = "nuraim"
nuraim.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
nuraim.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = nuraim
Frame.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Frame.BorderColor3 = Color3.new(0.313726, 0.313726, 0.313726)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.310026377, 0, 0.292358816, 0)
Frame.Size = UDim2.new(0, 395, 0, 32)

Text.Name = "Text"
Text.Parent = Frame
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(0, 395, 0, 32)
Text.Font = Enum.Font.SourceSans
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14

-- Scripts

local function ZJUO_fake_script() -- Text.LocalScript 
	local script = Instance.new('LocalScript', Text)

	local name = game.Players.LocalPlayer.Name
	local text = script.Parent
	
	
	text.Text = "NurClient | " ..name
end
coroutine.wrap(ZJUO_fake_script)()
local function QWJR_fake_script() -- Frame.Dragify 
	local script = Instance.new('LocalScript', Frame)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(QWJR_fake_script)()
local function ZDQIRRQ_fake_script() -- nuraim.AimbotToggleLocal 
	local script = Instance.new('LocalScript', nuraim)

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera
	
	local aimbotEnabled = false
	
	-- Настройки
	local AIM_KEY = Enum.KeyCode.Q -- Клавиша для переключения
	local GAMEPAD_BUTTON = Enum.KeyCode.DPadDown -- Кнопка джойстика для переключения
	
	-- Функция поиска ближайшего врага
	local function getClosestTarget()
	    local closest = nil
	    local shortest = math.huge
	    local myCharacter = LocalPlayer.Character
	    if not myCharacter or not myCharacter:FindFirstChild("Head") then return nil end
	    local myHead = myCharacter.Head.Position
	
	    local players = Players:GetPlayers()
	    for i, player in players do
	        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
	            local targetHead = player.Character.Head.Position
	            local distance = (myHead - targetHead).Magnitude
	            if distance < shortest then
	                shortest = distance
	                closest = player.Character.Head
	            end
	        end
	    end
	    return closest
	end
	
	-- Переключатель aimbot
	local function toggleAimbot()
	    aimbotEnabled = not aimbotEnabled
	    if aimbotEnabled then
	        print("Aimbot: ON")
	    else
	        print("Aimbot: OFF")
	    end
	end
	
	-- Обработка ввода с клавиатуры и джойстика
	UserInputService.InputBegan:Connect(function(input, processed)
	    if processed then return end
	    if input.KeyCode == AIM_KEY or input.KeyCode == GAMEPAD_BUTTON then
	        toggleAimbot()
	    end
	end)
	
	-- Основной цикл aimbot
	RunService.RenderStepped:Connect(function()
	    if not aimbotEnabled then return end
	    local target = getClosestTarget()
	    if target then
	        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
	    end
	end)
	
	
end
coroutine.wrap(ZDQIRRQ_fake_script)()
