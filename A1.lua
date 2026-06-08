-- سكربت أيهم (Ayham) المطور - نسخة أيقونة النسر
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- الإطار الرئيسي للقائمة
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- زر النسر (أيقونة التصغير والإظهار)
local eagleBtn = Instance.new("ImageButton", screenGui)
eagleBtn.Size = UDim2.new(0, 60, 0, 60)
eagleBtn.Position = UDim2.new(0, 20, 0, 20) -- في الزاوية فوق
eagleBtn.Image = "rbxassetid://6034289354" -- أيقونة نسر/صقر جاهزة
eagleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
eagleBtn.BorderSizePixel = 2
eagleBtn.BorderColor3 = Color3.fromRGB(255, 215, 0)
eagleBtn.Visible = false -- مخفي في البداية

-- منطق التبديل بين القائمة والنسر
local function toggleMenu(show)
    mainFrame.Visible = show
    eagleBtn.Visible = not show
end

-- زر إخفاء القائمة (داخل القائمة)
local hideBtn = Instance.new("TextButton", mainFrame)
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(0.95, 0, 0, 0)
hideBtn.Text = "X"
hideBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideBtn.MouseButton1Click:Connect(function() toggleMenu(false) end)

-- عند الضغط على النسر يفتح القائمة
eagleBtn.MouseButton1Click:Connect(function() toggleMenu(true) end)

-- باقي الكود (التبويبات ونفس الوظائف السابقة)
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(0, 150, 1, 0)
tabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -150, 1, 0)
contentFrame.Position = UDim2.new(0, 150, 0, 0)
contentFrame.BackgroundTransparency = 1

local function createTab(name, pos)
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, pos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local page = Instance.new("Frame", contentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    
    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(contentFrame:GetChildren()) do child.Visible = false end
        page.Visible = true
    end)
    return page
end

local homePage = createTab("القائمة الرئيسية", 0)
local targetPage = createTab("استهداف", 55)
local animsPage = createTab("انميشنات", 110)

-- محتوى "أيهم فقط"
local lbl = Instance.new("TextLabel", homePage)
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.Text = "أيهم فقط"
lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
lbl.BackgroundTransparency = 1
