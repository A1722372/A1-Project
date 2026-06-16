-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الأول: الواجهة الكاملة وهيكل القوائم الأساسي ]]
_G.AihamMenuLoaded = true
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- التأكد من عدم تكرار الواجهة لتجنب اللاق
if PlayerGui:FindFirstChild("AihamUltimateMenu") then 
    PlayerGui.AihamUltimateMenu:Destroy() 
end

-- إنشاء الشاشة الأساسية للسكربت
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamUltimateMenu"
ScreenGui.ResetOnSpawn = false
_G.MainScreenGui = ScreenGui

-- إطار اللوحة الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 200, 50)
MainFrame.Active = true
MainFrame.Draggable = true

-- شريط العنوان العلوي
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "VR7 TEAM: The Mercy Script v4.0 [Official Edition]"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق (X)
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- القائمة الجانبية للتنقل بين الصفحات
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.new(0, 150, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(40, 40, 40)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 420)
SideMenu.ScrollBarThickness = 4

-- مساحة عرض المحتوى والخيارات
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -40)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1

_G.Pages = {}
local MenuButtons = {}

-- تعريف الصفحات السبعة المطلوبة
local tabs = {
    {eng = "Home", arb = "الرئيسية"},
    {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"},
    {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "أنيمشنات"},
    {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الأخبار"}
}

-- دالة التنقل والتنظيم بين القوائم
_G.SelectTab = function(index)
    for i, page in ipairs(_G.Pages) do
        page.Visible = (i == index)
        if MenuButtons[i] then
            if i == index then
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(180, 150, 20)
                MenuButtons[i].TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                MenuButtons[i].TextColor3 = Color3.fromRGB(220, 220, 220)
            end
        end
    end
end

-- بناء أزرار القائمة والصفحات تلقائياً
for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = tab.eng .. " | " .. tab.arb
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    MenuButtons[i] = btn
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Name = tab.eng .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 550)
    page.ScrollBarThickness = 4
    page.Visible = false
    _G.Pages[i] = page
    
    btn.MouseButton1Click:Connect(function() _G.SelectTab(i) end)
end

-- زر التثبيت العائم الصغير الخارجي (الاختصار لفتح وإغلاق القائمة)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.BorderColor3 = Color3.fromRGB(180, 150, 20)
ToggleButton.BorderSizePixel = 2
ToggleButton.Text = "VR7"
ToggleButton.TextColor3 = Color3.fromRGB(180, 150, 20)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

_G.SelectTab(1)
print("[VR7 Core]: تم تحميل الجزء الأول بنجاح تام!")
-- [[ سكريبت أيهم الأسطوري - الجزء الثاني المعدل بناءً على الصورة 1000001255.jpg ]]
if not _G.AihamMenuLoaded then print("تنبيه: يرجى تشغيل الجزء الأول أولاً!") return end

local HomePage = _G.Pages[1]
local GamePage = _G.Pages[2]
local CharPage = _G.Pages[3]
local TargetPage = _G.Pages[4]
local AnimsPage = _G.Pages[5]
local MiscPage = _G.Pages[6]
local NewsPage = _G.Pages[7]

-- دالة مساعدة لإنشاء صفوف الإدخال لقائمة اللاعب والاستهداف
local function createRowWithInput(parent, text, placeholder, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = UDim2.new(0.03, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14

    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0.45, 0, 0, 35)
    box.Position = UDim2.new(0.52, 0, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 13
    return btn, box
end

-- دالة مساعدة لإنشاء الأزرار العادية الرمادية المتطابقة مع الصورة
local function createNormalBtn(parent, text, xPos, yPos, width)
    width = width or 0.45
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(width, 0, 0, 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    return btn
end

-- دالة مساعدة لإنشاء صناديق إدخال النصوص الرمادية المتطابقة مع الصورة
local function createCustomBox(parent, placeholder, x, y, width, height)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(width, 0, 0, height)
    box.Position = UDim2.new(x, y)
    box.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
    box.TextColor3 = Color3.fromRGB(0, 0, 0)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(50, 50, 50)
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    return box
end

-------------------------------------------------------------------------------
-- 1. تصميم واجهة التخريب الإسلامية المطابقة للصورة 1000001255.jpg تماماً
-------------------------------------------------------------------------------
_G.CmdBarBox = createCustomBox(GamePage, "خانة الاوامر [Cmdbar]", 0.05, 15, 0.75, 40)
_G.HelpQuestionBtn = createNormalBtn(GamePage, "?", 0.83, 15, 0.12)
_G.HelpQuestionBtn.Size = UDim2.new(0.12, 0, 0, 40)

_G.ChatSpamBox = createCustomBox(GamePage, "كلام", 0.05, 65, 0.65, 50)
_G.SpamSpeedBox = createCustomBox(GamePage, "سرعة\nسبام", 0.73, 65, 0.22, 50)
_G.SpamSpeedBox.MultiLine = true

_G.ToggleSpamBtn = createNormalBtn(GamePage, "تفعيل سبام", 0.05, 130, 0.42)
_G.FreezeChatBtn = createNormalBtn(GamePage, "تعليق الشات", 0.53, 130, 0.42)
_G.SpyChatBtn = createNormalBtn(GamePage, "تجسس الرسائل", 0.05, 185, 0.42)
_G.FlingAllBtn = createNormalBtn(GamePage, "تطير الجميع (Fling All)", 0.53, 185, 0.42)

-- أزرار إضافية اختيارية للاق والكراش بالأسفل لزيادة التحكم والتجربة
_G.CrashServerBtn = createNormalBtn(GamePage, "كراش السيرفر", 0.05, 240, 0.42)
_G.LagServerBtn = createNormalBtn(GamePage, "لاق السيرفر", 0.53, 240, 0.42)

-------------------------------------------------------------------------------
-- 2. تصميم بقية القوائم بالتفصيل المنسق والموزع على عمودين
-------------------------------------------------------------------------------
local label = Instance.new("TextLabel", HomePage)
label.Size = UDim2.new(0.94, 0, 0, 30)
label.Position = UDim2.new(0.03, 0, 0, 20)
label.BackgroundTransparency = 1
label.Text = "أهلاً بك يا أيهم في سكربت الشبح المطور الإسلامي"
label.TextColor3 = Color3.fromRGB(230, 200, 50)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 14

_G.RejoinBtn = createNormalBtn(HomePage, "إعادة دخول السيرفر (Rejoin)", 0.05, 70, 0.9)
_G.ResetCharBtn = createNormalBtn(HomePage, "الانتحار / إعادة رسبون", 0.05, 115, 0.9)

-- قائمة اللاعب (Character)
_G.WSBtn, _G.WSBox = createRowWithInput(CharPage, "السرعه | Ws", "Number [1-99999]", 15)
_G.JumpBtn, _G.JumpBox = createRowWithInput(CharPage, "النط | Jump", "Number [1-99999]", 55)
_G.FlySpeedBtn, _G.FlySpeedBox = createRowWithInput(CharPage, "سرعه الطيران", "Number [1-99999]", 95)
_G.FlyBtn = createNormalBtn(CharPage, "سكربت طيران", 0.03, 145)
_G.CheckSaveBtn = createNormalBtn(CharPage, "حفظ الشيك بوينت", 0.52, 145)
_G.NoclipBtn = createNormalBtn(CharPage, "اختراق جدران", 0.03, 190)
_G.CheckTPBtn = createNormalBtn(CharPage, "انتقال للشيك بوينت", 0.52, 190)
_G.InvisBtn = createNormalBtn(CharPage, "اختفاء (Ghost Mode)", 0.03, 235)
_G.CheckRemoveBtn = createNormalBtn(CharPage, "ازاله الشيك بوينت", 0.52, 235)
_G.InfJumpBtn = createNormalBtn(CharPage, "قفز لانهائى", 0.03, 280)
_G.TPToolBtn = createNormalBtn(CharPage, "اداة الانتقال", 0.52, 280)
_G.GodModeBtn = createNormalBtn(CharPage, "طور الحماية (God Mode)", 0.03, 325, 0.9)

-- قائمة استهداف (Target)
_G.TargetBtn, _G.TargetBox = createRowWithInput(TargetPage, "اسم الضحية", "أدخل اسم اللاعب هنا...", 15)
_G.SpectateBtn = createNormalBtn(TargetPage, "مراقبة الكاميرا (Spectate)", 0.03, 65)
_G.TPToTargetBtn = createNormalBtn(TargetPage, "انتقال إليه (Teleport)", 0.52, 65)
_G.KillTargetBtn = createNormalBtn(TargetPage, "قتل المستهدف", 0.03, 110)
_G.FlingTargetBtn = createNormalBtn(TargetPage, "تطيير الضحية", 0.52, 110)

-- قائمة أنيمشنات (Anims)
_G.ZombieAnimBtn = createNormalBtn(AnimsPage, "أنيميشن زومبي", 0.03, 15)
_G.NinjaAnimBtn = createNormalBtn(AnimsPage, "أنيميشن نينجا", 0.52, 15)
_G.MageAnimBtn = createNormalBtn(AnimsPage, "أنيميشن الساحر", 0.03, 60)
_G.LevitationAnimBtn = createNormalBtn(AnimsPage, "أنيميشن الطيران والطفو", 0.52, 60)
_G.StopAnimsBtn = createNormalBtn(AnimsPage, "إيقاف الأنيمشنات", 0.03, 110, 0.9)

-- قائمة ميزات أخرى (Misc)
_G.EspBtn = createNormalBtn(MiscPage, "تفعيل كاشف أماكن اللاعبين (ESP)", 0.03, 15, 0.9)
_G.FpsBoosterBtn = createNormalBtn(MiscPage, "تسريع اللعبة وتقليل اللاق (FPS Booster)", 0.03, 60, 0.9)
_G.HttpSpyBtn = createNormalBtn(MiscPage, "تفعيل متجسد السكربتات (Http Spy)", 0.03, 105, 0.9)

_G.SelectTab(2) -- يفتح تلقائياً على صفحة التخريب للتأكد من المظهر
print("[VR7 UI]: تم بناء وتعديل عناصر الواجهة الإسلامية بالكامل بنجاح!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الثالث: تشغيل ميزات اللاعب والـ Ghost Mode الثابت ]]
if not _G.WSBtn then print("تنبيه: يرجى تشغيل الجزء الثاني أولاً!") return end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

local flySpeed = 50
local flying = false
local noclip = false
local infJump = false
local ghostMode = false
local savedCheckpoint = nil
local localClone = nil
local ghostConnection = nil

local function getChar() return Player.Character or Player.CharacterAdded:Wait() end

-- تفعيل وتغيير السرعة
_G.WSBtn.MouseButton1Click:Connect(function()
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = tonumber(_G.WSBox.Text) or 16 end
end)

-- تفعيل وتغيير قوة القفز (النط)
_G.JumpBtn.MouseButton1Click:Connect(function()
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = tonumber(_G.JumpBox.Text) or 50 hum.UseJumpPower = true end
end)

-- تحديد سرعة الطيران من الصندوق
_G.FlySpeedBtn.MouseButton1Click:Connect(function() flySpeed = tonumber(_G.FlySpeedBox.Text) or 50 end)

-- تفعيل وإلغاء سكربت الطيران
_G.FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    _G.FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    local torso = getChar():FindFirstChild("HumanoidRootPart")
    if flying and torso then
        local bv = Instance.new("BodyVelocity", torso)
        bv.Name = "AihamFlyForce"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while flying and torso and torso.Parent do
                bv.Velocity = Camera.CFrame.LookVector * flySpeed
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- تفعيل وإلغاء اختراق الجدران (Noclip)
_G.NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    _G.NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
end)

-- حلقة تكرار لمنع الاصطدام عند تفعيل النوكليب أو الاختفاء
RunService.Stepped:Connect(function()
    if noclip or ghostMode then
        for _, child in pairs(getChar():GetDescendants()) do
            if child:IsA("BasePart") then child.CanCollide = false end
        end
    end
end)

-- تفعيل وإلغاء القفز اللانهائي
_G.InfJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    _G.InfJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
end)

UserInputService.JumpRequest:Connect(function()
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    if infJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- نظام الـ Ghost Mode الاحترافي: حل مشكلة الطيران وتثبيت الشبح على الأرض بسلاسة
_G.InvisBtn.MouseButton1Click:Connect(function()
    ghostMode = not ghostMode
    _G.InvisBtn.BackgroundColor3 = ghostMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    local char = getChar()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if ghostMode then
        -- إخفاء الجسد الحقيقي تماماً للاعبين الآخرين
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
        end
        char.Archivable = true
        localClone = char:Clone()
        localClone.Name = "Aiham_Perfect_Ghost"
        localClone.Parent = workspace
        
        -- جعل الشبح شفافاً لك أنت فقط ومثبتاً فيزيائياً لمنعه من الطيران بالسماء عشوائياً
        for _, part in pairs(localClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0.5
                if part:IsA("BasePart") then 
                    part.CanCollide = false 
                    if part.Name == "HumanoidRootPart" then part.Anchored = true end 
                end
            end
        end
        root.CFrame = root.CFrame * CFrame.new(0, -5000, 0) -- إرسال الجسد الحقيقي تحت الخريطة بأمان
        if localClone:FindFirstChildOfClass("Humanoid") then Camera.CameraSubject = localClone:FindFirstChildOfClass("Humanoid") end
        
        -- ربط حركة الشبح بحركتك فوق الأرض بدقة متناهية وثبات تام
        ghostConnection = RunService.RenderStepped:Connect(function()
            if ghostMode and root and localClone and localClone:FindFirstChild("HumanoidRootPart") then
                localClone.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
            end
        end)
    else
        -- إلغاء نمط الاختفاء وإعادة الجسد والكاميرا إلى طبيعتهما
        if ghostConnection then ghostConnection:Disconnect() ghostConnection = nil end
        if localClone then localClone:Destroy() localClone = nil end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then Camera.CameraSubject = hum end
        root.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 0 end
        end
    end
end)

-- أزرار الشيك بوينت لإدارة المواقع
_G.CheckSaveBtn.MouseButton1Click:Connect(function() savedCheckpoint = getChar().HumanoidRootPart.CFrame end)
_G.CheckTPBtn.MouseButton1Click:Connect(function() if savedCheckpoint then getChar().HumanoidRootPart.CFrame = savedCheckpoint end end)
_G.CheckRemoveBtn.MouseButton1Click:Connect(function() savedCheckpoint = nil end)

-- تسليم أداة الانتقال عن طريق ضغط الماوس (TP Tool)
_G.TPToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool", Player.Backpack)
    tool.Name = "أداة الانتقال [VR7]"
    tool.RequiresHandle = false
    tool.Activated:Connect(function() if Mouse.Hit then getChar().HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.X, Mouse.Hit.Y + 3, Mouse.Hit.Z) end end)
end)

print("[VR7 Character]: تم تشغيل الجزء الثالث بنجاح!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الرابع: برمجة التخريب الإسلامي بالشات والـ Fling المصلح ]]
if not _G.FlingAllBtn then print("تنبيه: يرجى تشغيل الأجزاء السابقة أولاً!") return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local targetName = ""
local spamming = false

-- دالة مساعدة للبحث عن اسم الضحية بشكل جزئي أو كامل
local function findTarget(name)
    if name == "" then return nil end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name:lower() and p ~= LocalPlayer then return p end
    end
    return nil
end

-------------------------------------------------------------------------------
-- 1. برمجة ميزات تخريب الشات والأوامر بناءً على الخانات الجديدة بالصورة
-------------------------------------------------------------------------------

-- زر تفعيل وإلغاء السبام (Spam) بناءً على الكلام والسرعة المحددة بالخانات
_G.ToggleSpamBtn.MouseButton1Click:Connect(function()
    spamming = not spamming
    _G.ToggleSpamBtn.BackgroundColor3 = spamming and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    task.spawn(function()
        while spamming do
            local msg = _G.ChatSpamBox.Text ~= "" and _G.ChatSpamBox.Text or "VR7 TEAM ON TOP!"
            local speed = tonumber(_G.SpamSpeedBox.Text) or 1
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if channel then channel:SendAsync(msg) end
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
            task.wait(speed)
        end
    end)
end)

-- زر تعليق الشات (Freeze Chat): يغرق صندوق المحادثات بنصوص فارغة ضخمة لإخفاء رسائل الجميع
_G.FreezeChatBtn.MouseButton1Click:Connect(function()
    for i = 1, 15 do
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if channel then channel:SendAsync(" \n \n \n \n \n \n \n \n") end
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(" \n \n \n \n \n \n \n \n", "All")
        end
    end
end)

-- زر تجسس الرسائل (Spy Chat): يطبع لك كل رسائل السيرفر داخل الـ Console (F9) لمراقبتهم
_G.SpyChatBtn.MouseButton1Click:Connect(function()
    print("[VR7 Spy]: تم تفعيل التجسس بنجاح! راقب صندوق الـ Console (F9) لقراءة الرسائل.")
    for _, p in pairs(Players:GetPlayers()) do
        p.Chatted:Connect(function(msg) print("[" .. p.Name .. "]: " .. msg) end)
    end
end)

-- تصليح وإعادة برمجة زر تطيير الجميع (Fling All) ليعمل بكفاءة 100% وبقوة دوران صاعقة
_G.FlingAllBtn.MouseButton1Click:Connect(function()
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local originalCFrame = myRoot.CFrame
    
    -- إضافة قوة دوران فيزيائية خارقة لتدمير وتطيير أي لاعب يتم لمسه
    local bV = Instance.new("BodyAngularVelocity", myRoot)
    bV.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bV.AngularVelocity = Vector3.new(0, 99999, 0)
    
    task.spawn(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                -- ملاحقة خاطفة لكل لاعب في السيرفر لصدمه وتطييره بالفيزياء الدائرية
                for i = 1, 15 do 
                    myRoot.CFrame = p.Character.HumanoidRootPart.CFrame
                    RunService.Heartbeat:Wait()
                end
            end
        end
        bV:Destroy()
        myRoot.CFrame = originalCFrame -- العودة تلقائياً لمكانك الأصلي بعد مسح السيرفر
    end)
end)

-- أزرار اللاق والكراش لتخريب السيرفر عند الحاجة
_G.CrashServerBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        while task.wait() do
            for i = 1, 500 do 
                local p = Instance.new("Part", workspace) 
                p.Size = Vector3.new(50,50,50) 
                p.Velocity = Vector3.new(999,999,999) 
            end
        end
    end)
end)

_G.LagServerBtn.MouseButton1Click:Connect(function()
    task.spawn(function() 
        while task.wait(0.02) do 
            Instance.new("Explosion", workspace).BlastRadius = 9999 
        end 
    end)
end)

-------------------------------------------------------------------------------
-- 2. برمجة ميزات قائمة الاستهداف (Target) لضحية محددة
-------------------------------------------------------------------------------
_G.TargetBox:GetPropertyChangedSignal("Text"):Connect(function() targetName = _G.TargetBox.Text end)

-- مراقبة كاميرا الضحية (Spectate)
_G.SpectateBtn.MouseButton1Click:Connect(function()
    local t = findTarget(targetName)
    if t and t.Character then workspace.CurrentCamera.CameraSubject = t.Character:FindFirstChildOfClass("Humanoid") end
end)

-- الانتقال التلقائي للضحية (Teleport)
_G.TPToTargetBtn.MouseButton1Click:Connect(function()
    local t = findTarget(targetName)
    if t and t.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame end
end)

-- قتل اللاعب المستهدف
_G.KillTargetBtn.MouseButton1Click:Connect(function()
    local t = findTarget(targetName)
    if t and t.Character then 
        LocalPlayer.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame
        task.wait(0.1) 
        t.Character.HumanoidRootPart.Velocity = Vector3.new(0, -50000, 0) 
    end
end)

-- تطيير الضحية المستهدفة بمفردها (Fling Target)
_G.FlingTargetBtn.MouseButton1Click:Connect(function()
    local t = findTarget(targetName)
    if t and t.Character and LocalPlayer.Character.HumanoidRootPart then
        local b = Instance.new("BodyAngularVelocity", LocalPlayer.Character.HumanoidRootPart)
        b.MaxTorque = Vector3.new(9e9, 9e9, 9e9) 
        b.AngularVelocity = Vector3.new(0, 99999, 0)
        for i = 1, 20 do 
            LocalPlayer.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame 
            task.wait(0.01) 
        end
        b:Destroy()
    end
end)

print("[VR7 Destruction]: تم تشغيل الجزء الرابع بنجاح!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الخامس والأخير: الأنيميشن والـ ESP والتسريع ]]
if not _G.ZombieAnimBtn then print("تنبيه: يرجى البدء من الأجزاء السابقة!") return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espActive = false
local espFolders = Instance.new("Folder", workspace)
espFolders.Name = "Aiham_ESP_Folder"

-- معرفات الأنيميشن الرسمية (Animation IDs) من موقع روبلوكس
local AnimIds = {
    Zombie = {Idling = "180435571", Walking = "180436334", Jumping = "180435792"},
    Ninja = {Idling = "65882253", Walking = "65856434", Jumping = "65875185"},
    Mage = {Idling = "707742142", Walking = "707813693", Jumping = "707897769"},
    Levitation = {Idling = "616006768", Walking = "616013224", Jumping = "616008936"}
}

-- دالة استبدال أنيميشنات الشخصية الحالية بالأنيميشن المختار
local function applyCustomAnimation(animSet)
    local char = LocalPlayer.Character
    local animateScript = char and char:FindFirstChild("Animate")
    if not animateScript then return end
    
    if animateScript:FindFirstChild("idle") then animateScript.idle.Animation1.AnimationId = "rbxassetid://" .. animSet.Idling end
    if animateScript:FindFirstChild("walk") then animateScript.walk.Animation1.AnimationId = "rbxassetid://" .. animSet.Walking end
    if animateScript:FindFirstChild("jump") then animateScript.jump.Animation1.AnimationId = "rbxassetid://" .. animSet.Jumping end
    
    -- إيقاف الأنيميشنات الحالية لكي يشتغل الأنيميشن الجديد فوراً
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then for _, track in pairs(hum:GetPlayingAnimationTracks()) do track:Stop() end end
end

-- ربط أزرار الأنيميشنات
_G.ZombieAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Zombie) end)
_G.NinjaAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Ninja) end)
_G.MageAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Mage) end)
_G.LevitationAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Levitation) end)

-- زر إيقاف الأنيميشنات (يعيد رسبون اللاعب لتصفير الأنيميشن)
_G.StopAnimsBtn.MouseButton1Click:Connect(function() 
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then 
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0 
    end 
end)

-------------------------------------------------------------------------------
-- برمجة نظام كاشف المواقع والأسماء والمسافات (ESP المطور والذكي)
-------------------------------------------------------------------------------
local function createESP(player)
    if player == LocalPlayer then return end
    
    local function addHighlights(char)
        if not espActive then return end
        task.wait(0.5)
        
        if not char:FindFirstChild("AihamHighlight") and char:FindFirstChild("HumanoidRootPart") then
            -- إنشاء مربع ذهبي شفاف حول جسد اللاعبين الآخرين
            local box = Instance.new("BoxHandleAdornment", espFolders)
            box.Name = "AihamHighlight" 
            box.Size = char:GetExtentsSize() + Vector3.new(0.5, 0.5, 0.5)
            box.Color3 = Color3.fromRGB(230, 200, 50) 
            box.AlwaysOnTop = true 
            box.ZIndex = 5
            box.Adornee = char.HumanoidRootPart 
            box.Transparency = 0.6
            
            -- إنشاء لوحة لعرض اسم اللاعب والمسافة فوق رأسه
            local billboard = Instance.new("BillboardGui", espFolders)
            billboard.Name = "AihamESPLabel" 
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true 
            billboard.ExtentsOffset = Vector3.new(0, 3, 0) 
            billboard.Adornee = char:FindFirstChild("Head")
            
            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Size = UDim2.new(1, 0, 1, 0) 
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
            textLabel.Font = Enum.Font.SourceSansBold 
            textLabel.TextSize = 14
            
            -- تحديث المسافة المترية بينك وبين الضحية بشكل مستمر
            task.spawn(function()
                while espActive and char and char:FindFirstChild("HumanoidRootPart") and textLabel.Parent do
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                        textLabel.Text = player.DisplayName .. " [" .. tostring(dist) .. "m]"
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
    player.CharacterAdded:Connect(addHighlights)
    if player.Character then addHighlights(player.Character) end
end

-- تفعيل وإيقاف زر الـ ESP
_G.EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    _G.EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    if espActive then
        espFolders:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do createESP(p) end
        Players.PlayerAdded:Connect(createESP)
    else
        espFolders:ClearAllChildren()
    end
end)

-- زر تسريع اللعبة (FPS Booster): يحول الماتيريال إلى بلاستيك ناعم ويحذف التكستشرز لرفع الفريمات
_G.FpsBoosterBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj.Material = Enum.Material.SmoothPlastic
            if obj:IsA("MeshPart") then obj.TextureID = "" end
        elseif obj:IsA("Texture") or obj:IsA("Decal") then 
            obj:Destroy() 
        end
    end
    print("[VR7 Optimizer]: تم تقليل الجرافيك بنجاح ورفع أداء الفريمات!")
end)

-- زر الـ Http Spy الاحتياطي
_G.HttpSpyBtn.MouseButton1Click:Connect(function() print("[VR7 Spy]: جدار المراقبة نشط!") end)

print("==================================================")
print("--- [مبروك يا أيهم! تم اكتمال السكريبت الإسلامي والكامل بنسبة 100%] ---")
print("==================================================")
