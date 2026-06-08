-- نظام التبويبات (Tab System) المحترف - أيهم (Ayham)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- القائمة الجانبية (التبويبات)
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(0, 150, 1, 0)
tabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- منطقة المحتوى (اليمين)
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -150, 1, 0)
contentFrame.Position = UDim2.new(0, 150, 0, 0)
contentFrame.BackgroundTransparency = 1

-- دالة إنشاء التبويب
local function createTab(name, pos)
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, pos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local page = Instance.new("Frame", contentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false -- مخفية في البداية
    
    btn.MouseButton1Click:Connect(function()
        -- إخفاء الكل وإظهار الصفحة المطلوبة فقط
        for _, child in pairs(contentFrame:GetChildren()) do child.Visible = false end
        page.Visible = true
    end)
    return page
end

-- إنشاء التبويبات
local homePage = createTab("القائمة الرئيسية", 0)
local targetPage = createTab("استهداف", 55)
local animsPage = createTab("انميشنات", 110)

-- إضافة نص ترحيبي في الصفحة الرئيسية
local lbl = Instance.new("TextLabel", homePage)
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.Text = "أهلاً بك يا أيهم في واجهة VR7 المخصصة!"
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.BackgroundTransparency = 1
