-- سكريبت أيهم الأسطوري V12 - المحدث (مع التمرير وزر الإخفاء)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

-- تنظيف النسخ القديمة
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"

-- 1. زر الإخفاء (الأيقونة في الجانب)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "MENU"
ToggleButton.Active = true
ToggleButton.Draggable = true

-- 2. الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false 

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- 3. القائمة الجانبية (مع التمرير)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- سعة التمرير
SideMenu.ScrollBarThickness = 5
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- 4. منطقة المحتوى (مع التمرير لكل صفحة)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.BackgroundTransparency = 1

local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "الأنيميشن", "إضافات", "معلومات"}
local Pages = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 2, 0) -- تفعيل ScrollBar
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- الآن السكربت أصبح جاهزاً لاستقبال الكود الخاص بك في كل صفحة (Pages[1] للماب، Pages[2] للاعب، إلخ..)
