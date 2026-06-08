-- تعريف الخدمات الأساسية
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إنشاء الواجهة (ScreenGui)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true -- سحب الواجهة

-- القوائم الخمس (مصفوفة لتسهيل التبديل)
local Tabs = {"الترحيب", "الاستهداف", "اللاعب", "الأنيميشن", "إضافات"}

-- [هنا تضع وظائف الأزرار التي كتبناها سابقاً]
-- مثال: وظيفة الإخفاء
local hidden = false
local function toggleHidden()
    hidden = not hidden
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = hidden and root.CFrame + Vector3.new(0, -500, 0) or root.CFrame + Vector3.new(0, 500, 0)
    end
end

-- زر التفعيل الصغير (الذي طلبت أن يكون في الزاوية)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.Text = "Menu"
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- ملاحظة للتنظيم: 
-- قم بإنشاء Frame لكل قائمة من القوائم الخمس وقم بتبديل خاصية Visible لها
