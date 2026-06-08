-- [[ سكريبت أيهم الأسطوري - النسخة المحدثة بالتصميم الأصفر وقوس قزح ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي بنفس أبعاد وتصميم صورتك
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- ميزة ألوان قوس قزح (RGB) على إطار القائمة
RunService.RenderStepped:Connect(function()
    local hue = (tick() % 5) / 5
    MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
end)

-- زر الفتح والإغلاق الأصفر الصغير (●)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BorderSizePixel = 2
ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- العنوان العلوي
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- القائمة الجانبية للأزرار الصفراء
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- منطقة المحتوى
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -40)
ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1

-- إنشاء الشرائح الخمسة باللون الأصفر تماماً كالصورة 1000000873_2.jpg
local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "انميشن"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 42)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 46 + 10)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(230, 180, 0) -- اللون الأصفر المطابق
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 4
    page.Visible = (i == 1)
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- دالة عامة لإضافة أزرار الخيارات داخل الشرائح
local function addOption(parent, text, yPos, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, yPos)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Text = text
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    
    local active = false
    b.MouseButton1Click:Connect(function()
        active = not active
        b.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 45)
        callback(active, b)
    end)
end

-- === [ شريحة 1: اعدادات الماب ] ===
addOption(Pages[1], "إضاءة كاملة (FullBright)", 15, function(active)
    game.Lighting.Ambient = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
end)

-- === [ شريحة 2: اللاعب ] ===
addOption(Pages[2], "تفعيل السرعة العالية", 15, function(active)
    Player.Character.Humanoid.WalkSpeed = active and 65 or 16
end)
addOption(Pages[2], "تفعيل القفز العالي", 60, function(active)
    Player.Character.Humanoid.JumpPower = active and 120 or 50
end)

-- === [ شريحة 3: الاستهداف (انتقال وتجسس) ] ===
local TargetPage = Pages[3]

local NameInput = Instance.new("TextBox", TargetPage)
NameInput.Size = UDim2.new(0.9, 0, 0, 35)
NameInput.Position = UDim2.new(0.05, 0, 0, 15)
NameInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.PlaceholderText = "اكتب اسم اللاعب هنا..."
NameInput.Text = ""

-- زر الانتقال
local TeleportBtn = Instance.new("TextButton", TargetPage)
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 35)
TeleportBtn.Position = UDim2.new(0.05, 0, 0, 60)
TeleportBtn.Text = "انتقال سريع للاعب"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

TeleportBtn.MouseButton1Click:Connect(function()
    local targetName = NameInput.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #targetName) == targetName and p.Character then
            Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            break
        end
    end
end)

-- زر التجسس (Spy) المشابه لأيام زمان
addOption(TargetPage, "تفعيل التجسس (كاميرا اللاعب)", 105, function(active, btn)
    local targetName = NameInput.Text:lower()
    local found = false
    if active then
        for _, p in ipairs(PlayersService:GetPlayers()) do
            if p.Name:lower():sub(1, #targetName) == targetName and p.Character then
                workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
                found = true
                break
            end
        end
        if not found then 
            workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
    else
        workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
    end
end)

-- === [ شريحة 4: نقاط الحفظ ] ===
local CheckpointPage = Pages[4]
local savedLocation = nil

addOption(CheckpointPage, "حفظ المكان الحالي", 15, function(active, btn)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocation = Player.Character.HumanoidRootPart.CFrame
        btn.Text = "تم الحفظ!"
        task.wait(1)
        btn.Text = "حفظ المكان الحالي"
    end
end)

addOption(CheckpointPage, "العودة للمكان المحفوظ", 60, function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and savedLocation then
        Player.Character.HumanoidRootPart.CFrame = savedLocation
    end
end)

-- === [ شريحة 5: انميشن ] ===
local AnimPage = Pages[5]
local function playAnim(id)
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then local a = Instance.new("Animation"); a.AnimationId = "rbxassetid://"..id; h:LoadAnimation(a):Play() end
end

addOption(AnimPage, "تشغيل رقصة 1", 15, function() playAnim(507750864) end)
addOption(AnimPage, "تحية عسكرية", 60, function() playAnim(507744230) end)
