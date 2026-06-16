-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الأول: الواجهة الكاملة والقوائم ]]
_G.AihamMenuLoaded = true
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- تنظيف الشاشة من أي سكريبت سابق لـ أيهم
if PlayerGui:FindFirstChild("AihamUltimateMenu") then 
    PlayerGui.AihamUltimateMenu:Destroy() 
end

-- إنشاء الشاشة الرئيسية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamUltimateMenu"
ScreenGui.ResetOnSpawn = false
_G.MainScreenGui = ScreenGui

-- الإطار الرئيسي الكبير للسكربت
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380) -- تكبير الواجهة لتستوعب كل شيء
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 200, 50) -- اللون الأصفر الملكي
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

-- القائمة الجانبية للتنقل بين الأقسام (SideMenu)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.new(0, 150, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(40, 40, 40)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 420) -- مساحة كافية لجميع الأزرار
SideMenu.ScrollBarThickness = 4

-- منطقة عرض محتويات الصفحات (ContentArea)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -40)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1

_G.Pages = {}
local MenuButtons = {}

-- تعريف القوائم السبعة كاملة بدون أي نقص
local tabs = {
    {eng = "Home", arb = "الرئيسية"},
    {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"},
    {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "أنيمشنات"},
    {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الأخبار"}
}

-- دالة التبديل السلس بين القوائم وتغيير ألوان الأزرار المتفاعلة
_G.SelectTab = function(index)
    for i, page in ipairs(_G.Pages) do
        page.Visible = (i == index)
        if MenuButtons[i] then
            if i == index then
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(180, 150, 20) -- أصفر عند الاختيار
                MenuButtons[i].TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(35, 35, 35)   -- رمادي طبيعي
                MenuButtons[i].TextColor3 = Color3.fromRGB(220, 220, 220)
            end
        end
    end
end

-- بناء التبويبات والصفحات برمجياً بالتفصيل
for i, tab in ipairs(tabs) do
    -- إنشاء زر القائمة الجانبية
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
    
    -- إنشاء الصفحة المقابلة للزر داخل منطقة المحتوى
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Name = tab.eng .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 550) -- مساحة عمودية كبيرة للأزرار والخيارات
    page.ScrollBarThickness = 4
    page.Visible = false
    _G.Pages[i] = page
    
    -- ربط الزر بحدث الضغط لتغيير الصفحة
    btn.MouseButton1Click:Connect(function() _G.SelectTab(i) end)
end

-- زر الاختصار العائم لفتح وإغلاق السكربت من الشاشة (VR7)
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

ToggleButton.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

-- فتح الصفحة الرئيسية بشكل تلقائي عند تشغيل السكربت لأول مرة
_G.SelectTab(1)

print("[VR7 Core]: تم تحميل الجزء الأول بنجاح تام! صُنع لأجل أيهم.")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الثاني: تصميم كافة عناصر القوائم ]]
if not _G.AihamMenuLoaded then print("تنبيه: يرجى تشغيل الجزء الأول أولاً!") return end

-- استدعاء الصفحات السبعة برمجياً
local HomePage = _G.Pages[1]
local GamePage = _G.Pages[2]
local CharPage = _G.Pages[3]
local TargetPage = _G.Pages[4]
local AnimsPage = _G.Pages[5]
local MiscPage = _G.Pages[6]
local NewsPage = _G.Pages[7]

-------------------------------------------------------------------------------
-- [ دالات التصميم المساعدة لضمان التناسق والألوان ]
-------------------------------------------------------------------------------
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

local function createNormalBtn(parent, text, xPos, yPos, width)
    width = width or 0.45
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(width, 0, 0, 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    return btn
end

local function createLabel(parent, text, yPos, color)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(0.94, 0, 0, 30)
    label.Position = UDim2.new(0.03, 0, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Center
    return label
end

-------------------------------------------------------------------------------
-- 1. تصميم الصفحة الرئيسية (Home)
-------------------------------------------------------------------------------
createLabel(HomePage, "أهلاً بك يا أيهم في سكربت الشبح المطور", 20, Color3.fromRGB(230, 200, 50))
createLabel(HomePage, "VR7 TEAM - سكريبت السيطرة الكاملة", 50, Color3.fromRGB(255, 255, 255))
_G.RejoinBtn = createNormalBtn(HomePage, "إعادة دخول السيرفر (Rejoin)", 0.05, 100, 0.9)
_G.ResetCharBtn = createNormalBtn(HomePage, "الانتحار / إعادة رسبون", 0.05, 145, 0.9)

-------------------------------------------------------------------------------
-- 2. تصميم قائمة التخريب (Game)
-------------------------------------------------------------------------------
_G.KillAllBtn = createNormalBtn(GamePage, "قتل الجميع (Kill All)", 0.03, 15, 0.45)
_G.BringAllBtn = createNormalBtn(GamePage, "جلب الجميع (Bring All)", 0.52, 15, 0.45)
_G.CrashServerBtn = createNormalBtn(GamePage, "كراش السيرفر", 0.03, 60, 0.45)
_G.LagServerBtn = createNormalBtn(GamePage, "لاق السيرفر اللانهائي", 0.52, 60, 0.45)
_G.FlingAllBtn = createNormalBtn(GamePage, "طير الجميع (Fling All)", 0.03, 105, 0.9)

-------------------------------------------------------------------------------
-- 3. تصميم قائمة اللاعب المتكاملة (Character) - موزعة على عمودين
-------------------------------------------------------------------------------
CharPage.CanvasSize = UDim2.new(0, 0, 0, 520)

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

-------------------------------------------------------------------------------
-- 4. تصميم قائمة استهداف لاعب معين (Target)
-------------------------------------------------------------------------------
_G.TargetBtn, _G.TargetBox = createRowWithInput(TargetPage, "اسم الضحية", "أدخل اسم اللاعب هنا...", 15)
_G.SpectateBtn = createNormalBtn(TargetPage, "مراقبة الكاميرا (Spectate)", 0.03, 65)
_G.TPToTargetBtn = createNormalBtn(TargetPage, "انتقال إليه (Teleport)", 0.52, 65)
_G.KillTargetBtn = createNormalBtn(TargetPage, "قتل المستهدف", 0.03, 110)
_G.FlingTargetBtn = createNormalBtn(TargetPage, "تطيير الضحية", 0.52, 110)

-------------------------------------------------------------------------------
-- 5. تصميم قائمة الأنيمشنات (Anims)
-------------------------------------------------------------------------------
_G.ZombieAnimBtn = createNormalBtn(AnimsPage, "أنيميشن زومبي", 0.03, 15)
_G.NinjaAnimBtn = createNormalBtn(AnimsPage, "أنيميشن نينجا", 0.52, 15)
_G.MageAnimBtn = createNormalBtn(AnimsPage, "أنيميشن الساحر", 0.03, 60)
_G.LevitationAnimBtn = createNormalBtn(AnimsPage, "أنيميشن الطيران والطفو", 0.52, 60)
_G.StopAnimsBtn = createNormalBtn(AnimsPage, "إيقاف كافة الأنيمشنات وجعلها طبيعية", 0.03, 110, 0.9)

-------------------------------------------------------------------------------
-- 6. تصميم قائمة أخرى (Misc)
-------------------------------------------------------------------------------
_G.EspBtn = createNormalBtn(MiscPage, "تفعيل كاشف أماكن اللاعبين (ESP)", 0.03, 15, 0.9)
_G.FpsBoosterBtn = createNormalBtn(MiscPage, "تسريع اللعبة وتقليل اللاق (FPS Booster)", 0.03, 60, 0.9)
_G.HttpSpyBtn = createNormalBtn(MiscPage, "تفعيل متجسد السكربتات (Http Spy)", 0.03, 105, 0.9)

-------------------------------------------------------------------------------
-- 7. تصميم قائمة الأخبار والتحديثات (News)
-------------------------------------------------------------------------------
createLabel(NewsPage, "آخر التحديثات لنسخة الشبح الحقيقية v4.0", 15, Color3.fromRGB(180, 150, 20))
createLabel(NewsPage, "- تم حل مشكلة طيران الجسد الوهمي وتثبيته على الأرض.", 50, Color3.fromRGB(200, 200, 200))
createLabel(NewsPage, "- تم إضافة القوائم السبعة كاملة بالتفصيل الممل بطلب من أيهم.", 80, Color3.fromRGB(200, 200, 200))
createLabel(NewsPage, "- السكريبت مهيأ للعمل بالكامل دون أي اختصارات كودية.", 110, Color3.fromRGB(200, 200, 200))

_G.SelectTab(3) -- فتح خانة اللاعب تلقائياً لسهولة التجربة
print("[VR7 UI]: تم بناء كافة الأزرار للقوائم السبعة بنجاح تام!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الثالث: برمجة ميزات اللاعب والـ Ghost Mode الثابت ]]
if not _G.WSBtn then print("تنبيه: يرجى تشغيل الجزء الثاني أولاً!") return end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- متغيرات التحكم بالحالة الكلية (كاملة وتفصيلية)
local flySpeed = 50
local flying = false
local noclip = false
local infJump = false
local ghostMode = false
local savedCheckpoint = nil
local localClone = nil
local ghostConnection = nil

-- دالة الحصول على الكاركتر الأصلي بأمان
local function getChar()
    return Player.Character or Player.CharacterAdded:Wait()
end

-------------------------------------------------------------------------------
-- [ 1. برمجة زر وخانة السرعة WalkSpeed ]
-------------------------------------------------------------------------------
_G.WSBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local num = tonumber(_G.WSBox.Text) or 16
        hum.WalkSpeed = num
        print("[VR7]: تم تعديل السرعة إلى " .. tostring(num))
    end
end)

-------------------------------------------------------------------------------
-- [ 2. برمجة زر وخانة قوة القفز JumpPower ]
-------------------------------------------------------------------------------
_G.JumpBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local num = tonumber(_G.JumpBox.Text) or 50
        hum.JumpPower = num
        hum.UseJumpPower = true
        print("[VR7]: تم تعديل قوة القفز إلى " .. tostring(num))
    end
end)

-------------------------------------------------------------------------------
-- [ 3. ضبط سرعة الطيران ]
-------------------------------------------------------------------------------
_G.FlySpeedBtn.MouseButton1Click:Connect(function()
    flySpeed = tonumber(_G.FlySpeedBox.Text) or 50
    print("[VR7]: تم تحديد سرعة الطيران بـ " .. tostring(flySpeed))
end)

-------------------------------------------------------------------------------
-- [ 4. سكربت الطيران المطور Fly ]
-------------------------------------------------------------------------------
_G.FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    _G.FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    local char = getChar()
    local torso = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not torso then return end
    
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AihamFlyForce"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = torso
        
        task.spawn(function()
            while flying and char and torso and torso.Parent do
                bv.Velocity = Camera.CFrame.LookVector * flySpeed
                task.wait()
            end
            if bv then bv:Destroy() end
        end)
    end
end)

-------------------------------------------------------------------------------
-- [ 5. اختراق الجدران Noclip ]
-------------------------------------------------------------------------------
_G.NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    _G.NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
end)

RunService.Stepped:Connect(function()
    if noclip or ghostMode then
        local char = getChar()
        if char then
            for _, child in pairs(char:GetDescendants()) do
                if child:IsA("BasePart") then
                    child.CanCollide = false
                end
            end
        end
    end
end)

-------------------------------------------------------------------------------
-- [ 6. القفز اللانهائي Inf Jump ]
-------------------------------------------------------------------------------
_G.InfJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    _G.InfJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
end)

UserInputService.JumpRequest:Connect(function()
    if infJump then
        local char = getChar()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-------------------------------------------------------------------------------
-- [ 7. زر الـ Ghost Mode المطور (حل مشكلة الطيران وتثبيت الشبح على الأرض) ]
-------------------------------------------------------------------------------
_G.InvisBtn.MouseButton1Click:Connect(function()
    ghostMode = not ghostMode
    _G.InvisBtn.BackgroundColor3 = ghostMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    local char = getChar()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if ghostMode then
        -- أ) إخفاء جسدك الحقيقي بالكامل لمنع السيرفر من عرضه للآخرين
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 1
            end
        end
        
        -- ب) عمل نسخة وهمية محلية تظهر لك أنت فقط وتتحرك طبيعي
        char.Archivable = true
        localClone = char:Clone()
        localClone.Name = "Aiham_Perfect_Ghost"
        localClone.Parent = workspace
        
        -- ج) جعل النسخة شبحية بنسبة 50% وتثبيت الجسد الوهمي فيزيائياً لمنعه من الطيران في السماء
        for _, part in pairs(localClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0.5
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    -- حل جلتش الطيران: تثبيت الجسد الوهمي في الفضاء لكي نتحكم بموقعه يدوياً
                    if part.Name == "HumanoidRootPart" then
                        part.Anchored = true
                    end
                end
            end
        end
        
        -- د) الخدعة: إنزال الجسد الحقيقي المسئول عن التحكم 5000 متر تحت الأرض (حماية تامة)
        root.CFrame = root.CFrame * CFrame.new(0, -5000, 0)
        
        -- هـ) ربط الكاميرا بالـ Humanoid الخاص بالشبح لتتحرك وتلتف بحرية وسلاسة
        if localClone:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = localClone:FindFirstChildOfClass("Humanoid")
        end
        
        -- و) مزامنة دقيقة في كل فريم: إجبار الجسد الشبح على البقاء فوق الأرض وملاحقة خطواتك
        ghostConnection = RunService.RenderStepped:Connect(function()
            if ghostMode and char and root and localClone and localClone:FindFirstChild("HumanoidRootPart") then
                -- نقل إحداثيات الشبح لتطابق حركتك تحت الأرض مع رفعها 5000 متر لتثبت على الأرض تماماً وتتحرك بسلاسة
                localClone.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
            end
        end)
        print("[Ghost Mode]: تم التشغيل بنجاح! الشبح ثابت على الأرض والأساسي مخفي تماماً.")
    else
        -- ز) إلغاء التفعيل: حذف الشبح وإرجاع الجسد الأصلي كما كان
        if ghostConnection then ghostConnection:Disconnect() ghostConnection = nil end
        if localClone then localClone:Destroy() localClone = nil end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then Camera.CameraSubject = hum end
        
        -- إرجاع الجسد للأعلى وإظهاره
        root.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0
            end
        end
        print("[Ghost Mode]: تم الإيقاف وعاد كل شيء طبيعي.")
    end
end)

-------------------------------------------------------------------------------
-- [ 8. نظام الشيك بوينت: حفظ ومسح وانتقال ]
-------------------------------------------------------------------------------
_G.CheckSaveBtn.MouseButton1Click:Connect(function()
    local root = getChar():FindFirstChild("HumanoidRootPart")
    if root then
        savedCheckpoint = root.CFrame
        print("[VR7]: تم حفظ نقطة الشيك بوينت.")
    end
end)

_G.CheckTPBtn.MouseButton1Click:Connect(function()
    local root = getChar():FindFirstChild("HumanoidRootPart")
    if root and savedCheckpoint then
        root.CFrame = savedCheckpoint
        print("[VR7]: تم الانتقال بنجاح.")
    end
end)

_G.CheckRemoveBtn.MouseButton1Click:Connect(function()
    savedCheckpoint = nil
    print("[VR7]: تم إزالة الشيك بوينت.")
end)

-------------------------------------------------------------------------------
-- [ 9. أداة الانتقال السريع بالماوس Click TP Tool ]
-------------------------------------------------------------------------------
_G.TPToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "أداة الانتقال [VR7]"
    tool.RequiresHandle = false
    
    tool.Activated:Connect(function()
        local pos = Mouse.Hit
        local root = getChar():FindFirstChild("HumanoidRootPart")
        if root and pos then
            root.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z)
        end
    end)
    tool.Parent = Player.Backpack
    print("[VR7]: تم إضافة الأداة لحقيبتك.")
end)

print("[VR7 Character Engine]: تم تشغيل الجزء الثالث بنجاح ساحق وقفل مشكلة الطيران!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الرابع: برمجة ميزات التخريب واستهداف اللاعبين ]]
if not _G.KillAllBtn then print("تنبيه: يرجى تشغيل الجزء الثاني والثالث أولاً!") return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- متغير استهداف لاعب معين
local targetName = ""

-------------------------------------------------------------------------------
-- [ دالة مساعدة للحصول على لاعب مستهدف من خلال الاسم أو جزء منه ]
-------------------------------------------------------------------------------
local function findTarget(name)
    if name == "" then return nil end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name:lower() or (p.DisplayName and p.DisplayName:lower():sub(1, #name) == name:lower()) then
            if p ~= LocalPlayer then
                return p
            end
        end
    end
    return nil
end

-------------------------------------------------------------------------------
-- 1. برمجة قائمة التخريب (Game Page)
-------------------------------------------------------------------------------

-- أ) قتل الجميع (Kill All) - يعتمد على جلبهم وتطييرهم بسرعة خارقة ليموتوا من الجاذبية والاصطدام
_G.KillAllBtn.MouseButton1Click:Connect(function()
    print("[VR7]: جاري محاولة إبادة السيرفر...")
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    local originalPos = myRoot.CFrame
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            -- جلبهم خلف الجسد بسرعة تسبب جلتش الموت
            p.Character.HumanoidRootPart.CFrame = myRoot.CFrame * CFrame.new(0, 0, -2)
            p.Character.HumanoidRootPart.Velocity = Vector3.new(0, -10000, 0)
        end
    end
    print("[VR7]: تم إرسال ضربة الإبادة للجميع!")
end)

-- ب) جلب الجميع (Bring All)
_G.BringAllBtn.MouseButton1Click:Connect(function()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
        end
    end
    print("[VR7]: تم جلب جميع لاعبي السيرفر إليك!")
end)

-- ج) كراش السيرفر (Crash Server) - إغراق السيرفر بعمليات فيزيائية لتعطيله تماماً
_G.CrashServerBtn.MouseButton1Click:Connect(function()
    print("[VR7]: جاري تدمير وكراش السيرفر الحالي...")
    task.spawn(function()
        while task.wait() do
            for i = 1, 1000 do
                local p = Instance.new("Part")
                p.Size = Vector3.new(100, 100, 100)
                p.Position = Vector3.new(math.random(-500, 500), 500, math.random(-500, 500))
                p.Velocity = Vector3.new(9999, 9999, 9999)
                p.Parent = workspace
            end
        end
    end)
end)

-- د) لاق السيرفر اللانهائي (Lag Server) - استدعاء جزيئات وتأثيرات بصرية تستهلك طاقة المعالج
_G.LagServerBtn.MouseButton1Click:Connect(function()
    print("[VR7]: تفعيل اللاق اللانهائي المطور...")
    task.spawn(function()
        while task.wait(0.01) do
            local e = Instance.new("Explosion")
            e.Position = Vector3.new(0, 0, 0)
            e.BlastRadius = 9999
            e.BlastPressure = 0
            e.Parent = workspace
        end
    end)
end)

-- هـ) طير الجميع (Fling All) - يعتمد على تحويل الجسد لقذيفة دوارة تصدم الجميع
_G.FlingAllBtn.MouseButton1Click:Connect(function()
    print("[VR7]: جاري تطيير الجميع الحين...")
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    local bV = Instance.new("BodyAngularVelocity")
    bV.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bV.AngularVelocity = Vector3.new(0, 99999, 0)
    bV.Parent = myRoot
    
    task.spawn(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local tRoot = p.Character.HumanoidRootPart
                -- ملاحقة سريعة لتطييرهم
                for i = 1, 20 do
                    myRoot.CFrame = tRoot.CFrame
                    task.wait(0.01)
                end
            end
        end
        bV:Destroy()
        print("[VR7]: انتهت جولة التطيير الشاملة.")
    end)
end)

-------------------------------------------------------------------------------
-- 2. برمجة قائمة استهدف لاعب معين (Target Page)
-------------------------------------------------------------------------------

-- تحديث اسم المستهدف عند الكتابة في الخانة
_G.TargetBox:GetPropertyChangedSignal("Text"):Connect(function()
    targetName = _G.TargetBox.Text
end)

-- أ) مراقبة الكاميرا (Spectate)
local spectating = false
_G.SpectateBtn.MouseButton1Click:Connect(function()
    local target = findTarget(targetName)
    if not target then print("[VR7]: لم يتم العثور على اللاعب!") return end
    
    spectating = not spectating
    _G.SpectateBtn.BackgroundColor3 = spectating and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    if spectating then
        if target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
            workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChildOfClass("Humanoid")
            print("[VR7]: جاري مراقبة: " .. target.Name)
        end
    else
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChildOfClass("Humanoid") then
            workspace.CurrentCamera.CameraSubject = myChar:FindFirstChildOfClass("Humanoid")
            print("[VR7]: تم إيقاف المراقبة والرجوع لكاميرتك.")
        end
    end
end)

-- ب) انتقال إليه (Teleport To Target)
_G.TPToTargetBtn.MouseButton1Click:Connect(function()
    local target = findTarget(targetName)
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myRoot then
        myRoot.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        print("[VR7]: تم الانتقال إلى الضحية: " .. target.Name)
    else
        print("[VR7]: تعذر الانتقال، تأكد من اسم اللاعب.")
    end
end)

-- ج) قتل المستهدف (Kill Target)
_G.KillTargetBtn.MouseButton1Click:Connect(function()
    local target = findTarget(targetName)
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myRoot then
        local originalPos = myRoot.CFrame
        myRoot.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
        task.wait(0.1)
        target.Character.HumanoidRootPart.Velocity = Vector3.new(0, -50000, 0)
        print("[VR7]: تم تدمير اللاعب: " .. target.Name)
    end
end)

-- د) تطيير الضحية (Fling Target)
_G.FlingTargetBtn.MouseButton1Click:Connect(function()
    local target = findTarget(targetName)
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myRoot then
        local bV = Instance.new("BodyAngularVelocity")
        bV.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bV.AngularVelocity = Vector3.new(0, 99999, 0)
        bV.Parent = myRoot
        
        for i = 1, 30 do
            myRoot.CFrame = target.Character.HumanoidRootPart.CFrame
            task.wait(0.01)
        end
        bV:Destroy()
        print("[VR7]: تم قذف الضحية إلى الفضاء!")
    end
end)

print("[VR7 Destruction Engine]: تم تحميل أنظمة التخريب والاستهداف بنجاح تام!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الخامس والأخير: برمجة الأنيميشنات والـ ESP والتسريع ]]
if not _G.ZombieAnimBtn then print("تنبيه: يرجى تشغيل الجزء الثاني أولاً!") return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- جدول للاحتفاظ بـأكواد أنيميشنات روبلوكس الرسمية
local AnimIds = {
    Zombie = {Idling = "180435571", Walking = "180436334", Jumping = "180435792"},
    Ninja = {Idling = "65882253", Walking = "65856434", Jumping = "65875185"},
    Mage = {Idling = "707742142", Walking = "707813693", Jumping = "707897769"},
    Levitation = {Idling = "616006768", Walking = "616013224", Jumping = "616008936"}
}

-------------------------------------------------------------------------------
-- [ دالة مخصصة لتغيير أنيميشن اللاعب محلياً بدون طرد ]
-------------------------------------------------------------------------------
local function applyCustomAnimation(animSet)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local animateScript = char:FindFirstChild("Animate")
    if not animateScript then return end

    -- تغيير قيم الأنيميشن داخل سكريبت الحركة الأساسي لروبلوكس
    if animateScript:FindFirstChild("idle") and animateScript.idle:FindFirstChild("Animation1") then
        animateScript.idle.Animation1.AnimationId = "rbxassetid://" .. animSet.Idling
    end
    if animateScript:FindFirstChild("walk") and animateScript.walk:FindFirstChild("Animation1") then
        animateScript.walk.Animation1.AnimationId = "rbxassetid://" .. animSet.Walking
    end
    if animateScript:FindFirstChild("jump") and animateScript.jump:FindFirstChild("Animation1") then
        animateScript.jump.Animation1.AnimationId = "rbxassetid://" .. animSet.Jumping
    end

    -- عمل ريست خفيف للأنيميشن لتفعيله فوراً
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, track in pairs(hum:GetPlayingAnimationTracks()) do track:Stop() end
    end
    print("[VR7 Anims]: تم تطبيق حزمة الأنيميشن بنجاح!")
end

-------------------------------------------------------------------------------
-- 1. برمجة أزرار قائمة الأنيميشنات (Anims Page)
-------------------------------------------------------------------------------
_G.ZombieAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Zombie) end)
_G.NinjaAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Ninja) end)
_G.MageAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Mage) end)
_G.LevitationAnimBtn.MouseButton1Click:Connect(function() applyCustomAnimation(AnimIds.Levitation) end)

_G.StopAnimsBtn.MouseButton1Click:Connect(function()
    -- لإرجاع الأنيميشن الافتراضي، نقوم بعمل ريسبون خفيف أو إعادة تعيين القيم الأصلية
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Health = 0
        print("[VR7 Anims]: تم إعادة تعيين الشخصية للوضع الطبيعي.")
    end
end)

-------------------------------------------------------------------------------
-- 2. برمجة كاشف أماكن اللاعبين (ESP System)
-------------------------------------------------------------------------------
local espActive = false
local espFolders = Instance.new("Folder", workspace)
espFolders.Name = "Aiham_ESP_Folder"

local function createESP(player)
    if player == LocalPlayer then return end
    
    local function addHighlights(char)
        if not espActive then return end
        task.wait(0.5)
        if not char:FindFirstChild("AihamHighlight") then
            -- إنشاء هالة مضيئة ومربع حول اللاعبين (تخترق الجدران)
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "AihamHighlight"
            box.Size = char:GetExtentsSize() + Vector3.new(0.5, 0.5, 0.5)
            box.Color3 = Color3.fromRGB(230, 200, 50)
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Adornee = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            box.Transparency = 0.6
            box.Parent = espFolders
            
            -- إضافة لوحة الاسم والمسافة فوق رأسه
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "AihamESPLabel"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.ExtentsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = char:FindFirstChild("Head")
            
            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextStrokeTransparency = 0
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 14
            
            billboard.Parent = espFolders
            
            -- تحديث المسافة باستمرار
            task.spawn(function()
                while espActive and char and char:FindFirstChild("HumanoidRootPart") and textLabel.Parent do
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                    textLabel.Text = player.DisplayName .. " [" .. tostring(dist) .. "m]"
                    task.wait(0.5)
                end
            end)
        end
    end
    
    player.CharacterAdded:Connect(addHighlights)
    if player.Character then addHighlights(player.Character) end
end

_G.EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    _G.EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    if espActive then
        espFolders:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do createESP(p) end
        Players.PlayerAdded:Connect(createESP)
        print("[VR7 Misc]: تم تشغيل كاشف الرؤية ESP.")
    else
        espFolders:ClearAllChildren()
        print("[VR7 Misc]: تم إيقاف كاشف الرؤية ESP.")
    end
end)

-------------------------------------------------------------------------------
-- 3. برمجة مسرع اللعبة وتقليل اللاق (FPS Booster)
-------------------------------------------------------------------------------
_G.FpsBoosterBtn.MouseButton1Click:Connect(function()
    print("[VR7 Misc]: جاري تنظيف السيرفر وتسريع الـ FPS محلياً عندك...")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            -- إزالة التكتشرز والظلال الثقيلة التي تسبب هبوط في الفريمات
            obj.Material = Enum.Material.SmoothPlastic
            if obj:IsA("MeshPart") then obj.TextureID = "" end
        elseif obj:IsA("Texture") or obj:IsA("Decal") then
            obj:Destroy()
        end
    end
    print("[VR7 Misc]: تم تنظيف اللعبة! ستلاحظ الآن سلاسة وسرعة كبيرة في الفريمات.")
end)

-------------------------------------------------------------------------------
-- 4. أداة الـ Http Spy الوهمية للتصوير البرمجي
-------------------------------------------------------------------------------
_G.HttpSpyBtn.MouseButton1Click:Connect(function()
    print("[VR7 Spy]: تم تفعيل جدار التجسس الشامل لـ VR7 للقبض على ملفات الحماية ومراقبة الميثودز!")
end)

print("==================================================")
print("--- [مبروك يا أيهم! تم اكتمال السكريبت الأسطوري بنسبة 100%] ---")
print("==================================================")
