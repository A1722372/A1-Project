-- السكربت الشامل - أيهم (Ayham)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- منطق الألوان (ذهبي / قوس قزح)
local isRainbow = false
RunService.RenderStepped:Connect(function()
    if isRainbow then mainFrame.BorderColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1) end
end)

-- زر النسر (أيقونة الإظهار)
local eagleBtn = Instance.new("ImageButton", screenGui)
eagleBtn.Size = UDim2.new(0, 60, 0, 60)
eagleBtn.Position = UDim2.new(0, 20, 0, 20)
eagleBtn.Image = "rbxassetid://6034289354" -- ضع الـ ID الخاص بصورتك هنا
eagleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
eagleBtn.Visible = false
eagleBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; eagleBtn.Visible = false end)

-- التبويبات
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

-- محتوى القائمة الرئيسية
local lbl = Instance.new("TextLabel", homePage)
lbl.Size = UDim2.new(1, 0, 0, 50)
lbl.Text = "أيهم فقط"
lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
lbl.BackgroundTransparency = 1

local colorBtn = Instance.new("TextButton", homePage)
colorBtn.Size = UDim2.new(0.8, 0, 0, 40)
colorBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
colorBtn.Text = "تبديل الألوان (ذهبي/قوس قزح)"
colorBtn.MouseButton1Click:Connect(function() 
    isRainbow = not isRainbow
    if not isRainbow then mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) end
end)

local hideBtn = Instance.new("TextButton", homePage)
hideBtn.Size = UDim2.new(0.8, 0, 0, 40)
hideBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
hideBtn.Text = "إخفاء القائمة"
hideBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; eagleBtn.Visible = true end)

-- تبويب الاستهداف
local input = Instance.new("TextBox", targetPage)
input.Size = UDim2.new(0.8, 0, 0, 40); input.Position = UDim2.new(0.1, 0, 0.2, 0)
input.PlaceholderText = "أول 3 حروف..."
local tpBtn = Instance.new("TextButton", targetPage)
tpBtn.Size = UDim2.new(0.8, 0, 0, 40); tpBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
tpBtn.Text = "انتقال (Teleport)"
tpBtn.MouseButton1Click:Connect(function()
    local search = string.lower(input.Text)
    for _, p in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #search) == search then
            localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
        end
    end
end)
