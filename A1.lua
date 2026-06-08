-- المطور الأسطوري أيهم - تصميم واجهة احترافي
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

-- إطار الإخفاء
local hideBtnContainer = Instance.new("Frame", screenGui)
hideBtnContainer.Size = UDim2.new(0, 40, 0, 40)
hideBtnContainer.Position = UDim2.new(0, 55, 0, 100)
hideBtnContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", hideBtnContainer)

local hideBtn = Instance.new("TextButton", hideBtnContainer)
hideBtn.Size = UDim2.new(1, 0, 1, 0)
hideBtn.BackgroundTransparency = 1
hideBtn.Text = "X"
hideBtn.TextColor3 = Color3.new(1, 1, 1)

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.BorderSizePixel = 2
Instance.new("UICorner", mainFrame)

hideBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- القائمة الجانبية
local btnNames = {"قائمة ألعاب", "القفز", "التحية", "الأسلحة", "الجلوس"}
local sideMenu = Instance.new("Frame", mainFrame)
sideMenu.Size = UDim2.new(0.35, 0, 0.85, 0)
sideMenu.Position = UDim2.new(0.02, 0, 0.12, 0)
sideMenu.BackgroundTransparency = 1

local infoFrame = Instance.new("Frame", mainFrame)
infoFrame.Size = UDim2.new(0.6, 0, 0.85, 0)
infoFrame.Position = UDim2.new(0.38, 0, 0.12, 0)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", infoFrame)

-- الوظائف البرمجية (داخل منطقة المعلومات)
local function createGameButtons()
	infoFrame:ClearAllChildren()
	
	-- زر السرعة
	local speedBtn = Instance.new("TextButton", infoFrame)
	speedBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
	speedBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
	speedBtn.Text = "زيادة السرعة"
	speedBtn.MouseButton1Click:Connect(function()
		humanoid.WalkSpeed = 50
	end)
	
	-- زر القفز
	local jumpBtn = Instance.new("TextButton", infoFrame)
	jumpBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
	jumpBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
	jumpBtn.Text = "زيادة القفز"
	jumpBtn.MouseButton1Click:Connect(function()
		humanoid.JumpPower = 100
	end)
	
	-- زر الاختفاء
	local invisibleBtn = Instance.new("TextButton", infoFrame)
	invisibleBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
	invisibleBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
	invisibleBtn.Text = "اختفاء اللاعب"
	invisibleBtn.MouseButton1Click:Connect(function()
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Decal") then
				part.Transparency = 1
			end
		end
	end)
end

-- إنشاء الأزرار الجانبية
for i = 1, 5 do
	local btn = Instance.new("TextButton", sideMenu)
	btn.Size = UDim2.new(1, 0, 0.16, 0)
	btn.Position = UDim2.new(0, 0, (i-1) * 0.2, 0)
	btn.BackgroundColor3 = Color3.fromRGB(200, 160, 0)
	btn.Text = btnNames[i]
	btn.Font = Enum.Font.SourceSansBold
	Instance.new("UICorner", btn)
	
	-- عند الضغط على "قائمة ألعاب" يفتح الأزرار الثلاثة
	if i == 1 then
		btn.MouseButton1Click:Connect(createGameButtons)
	end
end
