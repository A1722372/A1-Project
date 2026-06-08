-- المطور الأسطوري أيهم - التصميم الأصلي
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- 1. إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.BorderSizePixel = 2
Instance.new("UICorner", mainFrame)

-- 2. زر الإخفاء (X)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(0.92, 0, 0.02, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- 3. دالة إنشاء الأزرار بالتصميم الأصلي (ذهبي)
local function createButton(name, position, actionFunc)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.4, 0, 0.16, 0)
	btn.Position = position
	btn.BackgroundColor3 = Color3.fromRGB(200, 160, 0) -- اللون الذهبي الأصلي
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	Instance.new("UICorner", btn)
	
	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		-- اللون الأخضر عند التفعيل، والذهبي عند الإلغاء
		btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 160, 0)
		actionFunc(enabled)
	end)
end

-- 4. إضافة الأزرار في أماكنها الأصلية
createButton("سرعة اللاعب", UDim2.new(0.05, 0, 0.15, 0), function(on)
	humanoid.WalkSpeed = on and 50 or 16
end)

createButton("قوة القفز", UDim2.new(0.05, 0, 0.35, 0), function(on)
	humanoid.JumpPower = on and 100 or 50
end)

createButton("اختفاء اللاعب", UDim2.new(0.05, 0, 0.55, 0), function(on)
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = on and 1 or 0
		end
	end
end)
