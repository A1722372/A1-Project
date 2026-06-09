-- [[ سكريبت أيهم الأسطوري - النسخة V31 - اختبار الظهور ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- التأكد من عدم وجود تكرار
if PlayerGui:FindFirstChild("AihamScript_Main") then
    PlayerGui.AihamScript_Main:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.DisplayOrder = 999999

-- زر نصي للتأكد من الظهور (بدل الصورة مؤقتاً)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "Menu"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true

-- وظيفة زر الإخفاء
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
