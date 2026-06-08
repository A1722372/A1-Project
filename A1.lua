-- المطور الأسطوري أيهم - سكربت الواجهة الاحترافي
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- 1. إنشاء الواجهة الرئيسية
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "VR7_Mercy_Script"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- لون خلفية داكن
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- إطار ذهبي
mainFrame.BorderSizePixel = 3
Instance.new("UICorner", mainFrame)

-- 2. العنوان الرئيسي
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "VR7 TEAM: The Mercy Script"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.BackgroundTransparency = 1

-- 3. دالة إنشاء الأزرار بالتصميم المطلوب (نظام التفعيل)
local function createButton(name, position, actionFunc)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.4, 0, 0.12, 0)
	btn.Position = position
	btn.BackgroundColor3 = Color3.fromRGB(200, 160, 0) -- ذهبي
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextColor3 = Color3.new(0, 0, 0)
	Instance.new("UICorner", btn)
	
	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		-- تغيير اللون بناءً على الحالة
		btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 160, 0)
		-- تنفيذ الوظيفة
		actionFunc(enabled)
	end)
end

-- 4. الأزرار المطلوبة
-- زر السرعة
createButton("سرعة اللاعب", UDim2.new(0.05, 0, 0.2, 0), function(on)
	humanoid.WalkSpeed = on and 50 or 16
end)

-- زر القفز
createButton("قوة القفز", UDim2.new(0.05, 0, 0.4, 0), function(on)
	humanoid.JumpPower = on and 100 or 50
end)

-- زر الاختفاء
createButton("اختفاء اللاعب", UDim2.new(0.05, 0, 0.6, 0), function(on)
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = on and 1 or 0
		end
	end
end)

-- زر الإخفاء العام للواجهة (للخروج)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
closeBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)
