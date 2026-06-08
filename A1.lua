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
mainFrame.Position = UDim2.new(0.5, -250, 0.5,
