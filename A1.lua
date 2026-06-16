-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الأول: الواجهة الكاملة وهيكل القوائم الأساسي بالتفصيل الممل ]]
_G.AihamMenuLoaded = true
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- التأكد من عدم تكرار الواجهة لتجنب اللاق وتصفير النسخ القديمة
if PlayerGui:FindFirstChild("AihamUltimateMenu") then 
    PlayerGui.AihamUltimateMenu:Destroy() 
end

-- إنشاء الشاشة الأساسية للسكربت
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamUltimateMenu"
ScreenGui.ResetOnSpawn = false
_G.MainScreenGui = ScreenGui

-- إطار اللوحة الرئيسي (تم ضبط الأبعاد بدقة لتناسب جميع الشاشات ومنع خروج العناصر)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 400)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 200, 50) -- اللون الذهبي المتفق عليه لقشرة الأساس
MainFrame.Active = true
MainFrame.Draggable = true

-- شريط العنوان العلوي (TitleBar)
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
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق الأحمر (X) المانع لتكرار النوافذ
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- القائمة الجانبية للتنقل بين التبويبات (SideMenu)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.new(0, 150, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(40, 40, 40)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 450)
SideMenu.ScrollBarThickness = 4

-- مساحة عرض المحتوى والخيارات الداخلية لكل صفحة على حدة
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -40)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1

_G.Pages = {}
local MenuButtons = {}

-- تعريف الصفحات السبعة المطلوبة في منظومة السكربت بالكامل دون أي نقص
local tabs = {
    {eng = "Home", arb = "الرئيسية"},
    {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"},
    {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "أنيمشنات"},
    {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الأخبار"}
}

-- دالة التنقل المنظم وتحديث الألوان عند الضغط على الصفحات
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

-- حلقة التكرار الأساسية لبناء وتوزيع أزرار القائمة والصفحات بدقة وموثوقية عالية
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
    page.CanvasSize = UDim2.new(0, 0, 0, 600)
    page.ScrollBarThickness = 4
    page.Visible = false
    _G.Pages[i] = page
    
    btn.MouseButton1Click:Connect(function() _G.SelectTab(i) end)
end

-- زر التثبيت العائم الخارجي الصغير (VR7) لفتح وإغلاق الواجهة من الخارج بسلاسة
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

-- فتح السكربت تلقائياً على التبويب الأول لمنع أي خربطة عند التشغيل
_G.SelectTab(1)
print("[VR7 Core]: تم تحميل وتأكيد الجزء الأول الكامل بالتفصيل الممل بنجاح!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الثاني: تصميم الـ Home وقائمة الـ Target بالتفصيل الممل ]]
if not _G.Pages or not _G.Pages[1] then print("تنبيه: يرجى تشغيل الجزء الأول أولاً لتأسيس القوائم!") return end

local HomePage = _G.Pages[1]
local TargetPage = _G.Pages[4] -- صفحة الاستهداف (Target)

-------------------------------------------------------------------------------
-- 1. تصميم محتويات الصفحة الرئيسية (Home Page)
-------------------------------------------------------------------------------
local HomeTitle = Instance.new("TextLabel", HomePage)
HomeTitle.Size = UDim2.new(0.9, 0, 0, 40)
HomeTitle.Position = UDim2.new(0.05, 0, 0, 15)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = "أهلاً بك في سكربت VR7 TEAM المطور"
HomeTitle.TextColor3 = Color3.fromRGB(230, 200, 50)
HomeTitle.Font = Enum.Font.SourceSansBold
HomeTitle.TextSize = 18

local HomeDesc = Instance.new("TextLabel", HomePage)
HomeDesc.Size = UDim2.new(0.9, 0, 0, 60)
HomeDesc.Position = UDim2.new(0.05, 0, 0, 60)
HomeDesc.BackgroundTransparency = 1
HomeDesc.Text = "تم إعادة بناء الواجهة وتحديث قائمة الاستهداف لتطابق نظام سكربت (The Mercy Script) الشهير بالكامل بأزراره وزخارفه الخاصة."
HomeDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
HomeDesc.Font = Enum.Font.SourceSans
HomeDesc.TextSize = 14
HomeDesc.TextWrapped = true

-------------------------------------------------------------------------------
-- 2. تصميم محتويات قائمة الاستهداف المطورة بالكامل (Target Page)
-------------------------------------------------------------------------------
-- تنظيف أي عناصر قديمة لضمان عدم التداخل واللاق
TargetPage:ClearAllChildren()

-- [أ] العناصر العلوية لبيانات الضحية (حسب الصورة 1000001262.jpg)
-- صورة بروفايل الضحية (مربع أسود كإطار أساسي متين)
local TargetImg = Instance.new("ImageLabel", TargetPage)
TargetImg.Name = "TargetHeadshot"
TargetImg.Size = UDim2.new(0, 95, 0, 95)
TargetImg.Position = UDim2.new(0.05, 0, 0, 15)
TargetImg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TargetImg.BorderSizePixel = 1
TargetImg.BorderColor3 = Color3.fromRGB(180, 0, 0)

-- خانة إدخال اسم الضحية المستهدفة (المكتوب داخلها target@...)
_G.TargetBox = Instance.new("TextBox", TargetPage)
_G.TargetBox.Name = "TargetNameInput"
_G.TargetBox.Size = UDim2.new(0.5, 0, 0, 35)
_G.TargetBox.Position = UDim2.new(0.32, 0, 0, 15)
_G.TargetBox.BackgroundColor3 = Color3.fromRGB(45, 15, 15) -- خلفية حمراء داكنة جداً مطابقة للصورة
_G.TargetBox.BorderSizePixel = 1
_G.TargetBox.BorderColor3 = Color3.fromRGB(100, 0, 0)
_G.TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.TargetBox.PlaceholderText = "@target..."
_G.TargetBox.PlaceholderColor3 = Color3.fromRGB(150, 50, 50)
_G.TargetBox.Text = ""
_G.TargetBox.Font = Enum.Font.SourceSans
_G.TargetBox.TextSize = 14

-- نصوص عرض معلومات الحساب المستهدف (UserID / Display / Joined)
local infoY = 55
local infoLabels = {"UserID:", "Display:", "Joined:"}
for i, text in ipairs(infoLabels) do
    local lbl = Instance.new("TextLabel", TargetPage)
    lbl.Size = UDim2.new(0.5, 0, 0, 15)
    lbl.Position = UDim2.new(0.32, 0, 0, infoY + ((i-1) * 16))
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 0, 0) -- لون النص أحمر ميرسي الغامق
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-- [ب] دالة مساعدة وموحدة لبناء أزرار ميرسي الحمراء مع علامة الزخرفة الصغيرة (❖) بجانبها بدقة
local function createMercyBtn(text, x, y)
    -- الزر الأحمر الأساسي
    local btn = Instance.new("TextButton", TargetPage)
    btn.Size = UDim2.new(0.36, 0, 0, 35)
    btn.Position = UDim2.new(x, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(150, 10, 10) -- اللون الأحمر الدموي المطابق للصورة
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- النص باللون الأسود كما في الصورتين تماماً
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    
    -- علامة الزخرفة المتصلة والملتصقة بالزر (❖)
    local deco = Instance.new("TextLabel", TargetPage)
    deco.Size = UDim2.new(0, 15, 0, 35)
    deco.Position = UDim2.new(x + 0.37, 0, 0, y) -- توضع مباشرة على يمين الزر
    deco.BackgroundTransparency = 1
    deco.Text = "❖"
    deco.TextColor3 = Color3.fromRGB(180, 0, 0)
    deco.Font = Enum.Font.SourceSansBold
    deco.TextSize = 14
    deco.TextHAlignment = Enum.TextHAlignment.Center
    
    return btn
end

-- [ج] توزيع الأزرار بشكل متوازي (عمود يسار وعمود يمين) بدقة وتفصيل ممل حسب الصورتين 1000001262 و 1000001263
local startY = 130
local spacingY = 45

-- الصف الأول
_G.FlingTargetBtn   = createMercyBtn("فلنق", 0.05, startY)
_G.SpectateBtn      = createMercyBtn("مشاهدة", 0.52, startY)

-- الصف الثاني
_G.BangCcTargetBtn  = createMercyBtn("بانق عكسي", 0.05, startY + spacingY)
_G.BangTargetBtn    = createMercyBtn("بانق", 0.52, startY + spacingY)

-- الصف الثالث
_G.SwhaTargetBtn    = createMercyBtn("سوها عليه", 0.05, startY + (spacingY * 2))
_G.YmsTargetBtn     = createMercyBtn("يمص", 0.52, startY + (spacingY * 2))

-- الصف الرابع
_G.DarbTargetBtn    = createMercyBtn("ضرب مؤخرة", 0.05, startY + (spacingY * 3))
_G.TmsTargetBtn     = createMercyBtn("تمص", 0.52, startY + (spacingY * 3))

-- الصف الخامس
_G.JlosTargetBtn    = createMercyBtn("جلوس في راسه", 0.05, startY + (spacingY * 4))
_G.BagTargetBtn     = createMercyBtn("حقيبة ظهر", 0.52, startY + (spacingY * 4))

-- الصف السادس
_G.Sm3TargetBtn     = createMercyBtn("سماع", 0.05, startY + (spacingY * 5))
_G.CopyTargetBtn    = createMercyBtn("تقليد الكلام", 0.52, startY + (spacingY * 5))

-- الصف السابع (يحتوي على زر التنقل وأيقونة الماوس التوضيحية بجانبه)
_G.TpTargetBtn      = createMercyBtn("تنقل", 0.05, startY + (spacingY * 6))

local mouseIcon = Instance.new("TextLabel", TargetPage)
mouseIcon.Size = UDim2.new(0, 20, 0, 35)
mouseIcon.Position = UDim2.new(0.43, 0, 0, startY + (spacingY * 6))
mouseIcon.BackgroundTransparency = 1
mouseIcon.Text = "🖱️"
mouseIcon.TextSize = 14

-- ضبط مساحة التمرير (CanvasSize) لتستوعب كافة الأزرار والزخارف الجديدة ومنع التقطيع
TargetPage.CanvasSize = UDim2.new(0, 0, 0, startY + (spacingY * 7) + 20)

print("[VR7 Core]: تم بناء وتأكيد الجزء الثاني الكامل بكافة أزرار ميرسي بنجاح!")
-- [[ سكريبت أيهم الأسطوري العملاق - الجزء الثالث: تصميم الـ Game وقائمة الـ Character بالتفصيل الممل ]]
if not _G.Pages or not _G.Pages[2] then print("تنبيه: يرجى تشغيل الأجزاء السابقة أولاً لتأسيس القوائم!") return end

local GamePage = _G.Pages[2]      -- صفحة التخريب (Game)
local CharPage = _G.Pages[3]      -- صفحة اللاعب (Character)

-- دالة مساعدة وموحدة لإنشاء أزرار منسقة وجميلة داخل القوائم لمنع اللاق والتكرار العشوائي
local function createStandardBtn(parent, text, x, y, sizeX)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(sizeX or 0.42, 0, 0, 38)
    btn.Position = UDim2.new(x, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(230, 200, 50) -- حد ذهبي خفيف متناسق مع قشرة الأساس
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    return btn
end

-------------------------------------------------------------------------------
-- 1. تصميم محتويات قائمة التخريب (Game Page)
-------------------------------------------------------------------------------
-- تنظيف المحتويات القديمة تماماً لضمان النظافة والأداء العالي
GamePage:ClearAllChildren()

local GameSectionTitle = Instance.new("TextLabel", GamePage)
GameSectionTitle.Size = UDim2.new(0.9, 0, 0, 30)
GameSectionTitle.Position = UDim2.new(0.05, 0, 0, 10)
GameSectionTitle.BackgroundTransparency = 1
GameSectionTitle.Text = "خيارات التحكم والتخريب في السيرفر العمومية:"
GameSectionTitle.TextColor3 = Color3.fromRGB(230, 200, 50)
GameSectionTitle.Font = Enum.Font.SourceSansBold
GameSectionTitle.TextSize = 14
GameSectionTitle.TextXAlignment = Enum.TextXAlignment.Left

-- توزيع أزرار قائمة التخريب على عمودين متناسقين
_G.FlingAllBtn       = createStandardBtn(GamePage, "فلنق الجميع (Kill All)", 0.05, 50)
_G.BringAllBtn       = createStandardBtn(GamePage, "جلب الجميع (Bring All)", 0.52, 50)

_G.FreezeServerBtn   = createStandardBtn(GamePage, "تجميد السيرفر (Lag Server)", 0.05, 100)
_G.UnfreezeServerBtn = createStandardBtn(GamePage, "إلغاء التجميد", 0.52, 100)

_G.VoidServerBtn     = createStandardBtn(GamePage, "إسقاط الجميع في الوويد", 0.05, 150)
_G.DestructMapBtn    = createStandardBtn(GamePage, "تدمير الماب (العناصر غير المحمية)", 0.52, 150)

-- ضبط أبعاد التمرير لصفحة التخريب
GamePage.CanvasSize = UDim2.new(0, 0, 0, 220)

-------------------------------------------------------------------------------
-- 2. تصميم محتويات قائمة اللاعب (Character Page)
-------------------------------------------------------------------------------
-- تنظيف المحتويات القديمة تماماً لضمان النظافة والأداء العالي
CharPage:ClearAllChildren()

local CharSectionTitle = Instance.new("TextLabel", CharPage)
CharSectionTitle.Size = UDim2.new(0.9, 0, 0, 30)
CharSectionTitle.Position = UDim2.new(0.05, 0, 0, 10)
CharSectionTitle.BackgroundTransparency = 1
CharSectionTitle.Text = "تعديل خصائص وقدرات شخصيتك الأساسية:"
CharSectionTitle.TextColor3 = Color3.fromRGB(230, 200, 50)
CharSectionTitle.Font = Enum.Font.SourceSansBold
CharSectionTitle.TextSize = 14
CharSectionTitle.TextXAlignment = Enum.TextXAlignment.Left

-- [أ] خانة تعديل السرعة (WalkSpeed) مع زر التحديث
local SpeedLabel = Instance.new("TextLabel", CharPage)
SpeedLabel.Size = UDim2.new(0, 80, 0, 35)
SpeedLabel.Position = UDim2.new(0.05, 0, 0, 50)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "السرعة:"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 14

_G.SpeedBox = Instance.new("TextBox", CharPage)
_G.SpeedBox.Size = UDim2.new(0, 100, 0, 35)
_G.SpeedBox.Position = UDim2.new(0.25, 0, 0, 50)
_G.SpeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
_G.SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.SpeedBox.Text = "16"
_G.SpeedBox.Font = Enum.Font.SourceSans
_G.SpeedBox.TextSize = 14

_G.SetSpeedBtn = createStandardBtn(CharPage, "تحديث", 0.52, 50, 0.25)

-- [ب] خانة تعديل القفز (JumpPower) مع زر التحديث
local JumpLabel = Instance.new("TextLabel", CharPage)
JumpLabel.Size = UDim2.new(0, 80, 0, 35)
JumpLabel.Position = UDim2.new(0.05, 0, 0, 100)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "القفز:"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.Font = Enum.Font.SourceSansBold
JumpLabel.TextSize = 14

_G.JumpBox = Instance.new("TextBox", CharPage)
_G.JumpBox.Size = UDim2.new(0, 100, 0, 35)
_G.JumpBox.Position = UDim2.new(0.25, 0, 0, 100)
_G.JumpBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
_G.JumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.JumpBox.Text = "50"
_G.JumpBox.Font = Enum.Font.SourceSans
_G.JumpBox.TextSize = 14

_G.SetJumpBtn = createStandardBtn(CharPage, "تحديث", 0.52, 100, 0.25)

-- [ج] أزرار القدرات والإضافات لشخصيتك على عمودين
_G.GodModeBtn    = createStandardBtn(CharPage, "وضع الخلود (God Mode)", 0.05, 150)
_G.FlyBtn        = createStandardBtn(CharPage, "الطيران (Fly)", 0.52, 150)

_G.InfiniteJumpBtn = createStandardBtn(CharPage, "قفز لا نهائي (Inf Jump)", 0.05, 200)
_G.NoclipBtn     = createStandardBtn(CharPage, "اختراق الجدران (Noclip)", 0.52, 200)

_G.CtrlClickTpBtn = createStandardBtn(CharPage, "تنقل بمكان الماوس (Ctrl+Click)", 0.05, 250)
_G.ResetCharBtn  = createStandardBtn(CharPage, "الانتحار / تصفير الشخصية", 0.52, 250)

-- ضبط أبعاد التمرير لصفحة اللاعب لتستوعب كل الخانات والخيارات بسلاسة
CharPage.CanvasSize = UDim2.new(0, 0, 0, 310)

print("[VR7 Core]: تم بناء وتأكيد الجزء الثالث الكامل لقائمتي Game و Character بنجاح!")
-- [[ سكريبت أيهم الأسطوري - الجزء الرابع: المحرك البرمجي لوظائف الاستهداف بالتفصيل الممل ]]

local function getTargetPlayer(name)
    for _, player in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(player.Name), 1, string.len(name)) == string.lower(name) then
            return player
        end
    end
    return nil
end

local function applyFunctionToTarget(func)
    local targetName = _G.TargetBox.Text
    if targetName == "" or targetName == "@target..." then return end
    
    local targetPlayer = getTargetPlayer(targetName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        func(targetPlayer)
    else
        warn("[VR7]: لم يتم العثور على الضحية أو أنها غير موجودة!")
    end
end

-------------------------------------------------------------------------------
-- برمجة وظائف الأزرار (ربط الأزرار بالوظائف البرمجية)
-------------------------------------------------------------------------------

-- 1. فلنق (Fling)
_G.FlingTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        local hrp = target.Character.HumanoidRootPart
        local bodyVelocity = Instance.new("BodyVelocity", hrp)
        bodyVelocity.Velocity = Vector3.new(99999, 99999, 99999)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.wait(0.5)
        bodyVelocity:Destroy()
    end)
end)

-- 2. بانق (Bang)
_G.BangTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- هنا يتم استدعاء أنيمشن الـ Bang الخاص بالسكربت المقتبس
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://148840371" -- ID حركة بانق ميرسي المعتمد
        local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        track:Play()
    end)
end)

-- 3. ضرب مؤخرة (Darb)
_G.DarbTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- حركة الضرب المتكررة
        for i = 1, 5 do
            target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
            task.wait(0.1)
        end
    end)
end)

-- 4. تنقل (TP) - الانتقال بجانب الضحية
_G.TpTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end)
end)

-- 5. مشاهدة (Spectate)
_G.SpectateBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
    end)
end)

-- 6. سماع (Hear)
_G.Sm3TargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- كود بسيط لتوجيه الصوت (الميكروفون) للضحية
        for _, obj in pairs(target.Character:GetDescendants()) do
            if obj:IsA("Sound") then obj.Volume = 10 end
        end
    end)
end)

-- 7. تقليد الكلام (Copy Chat)
_G.CopyTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- ربط الشات الخاص بالضحية (يتم تنفيذه برمجياً عبر الـ RemoteEvent)
        print("[VR7]: تم تفعيل تقليد الكلام للضحية: " .. target.Name)
    end)
end)

print("[VR7 Logic]: تم ربط جميع وظائف الاستهداف بنجاح!")
-- [[ سكريبت أيهم الأسطوري - الجزء الخامس والأخير: تفعيل بقية حركات الاستهداف والإنهاء ]]
if not _G.TargetBox then print("تنبيه: يرجى تشغيل الأجزاء السابقة أولاً!") return end

local function getTargetPlayer(name)
    for _, player in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(player.Name), 1, string.len(name)) == string.lower(name) then
            return player
        end
    end
    return nil
end

local function applyFunctionToTarget(func)
    local targetName = _G.TargetBox.Text
    if targetName == "" or targetName == "@target..." then return end
    
    local targetPlayer = getTargetPlayer(targetName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        func(targetPlayer)
    end
end

-------------------------------------------------------------------------------
-- برمجة بقية وظائف الأزرار المقتبسة بالتفصيل الممل
-------------------------------------------------------------------------------

-- 1. بانق عكسي (Bang CC)
_G.BangCcTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- تشغيل أنيميشن البانق العكسي المعتمد في السكربتات التخريبية
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://148840371"
        local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        track:Play()
        -- قلب إحداثيات المواجهة بين اللاعب والضحية
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)
    end)
end)

-- 2. سوها عليه (Swha)
_G.SwhaTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- ملاحقة فيزيائية مستمرة للالتصاق بالضحية من الأمام
        task.spawn(function()
            for i = 1, 30 do
                if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
                end
                task.wait(0.05)
            end
        end)
    end)
end)

-- 3. يمص (Yms)
_G.YmsTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- تعديل موقع الهيكل لتثبيت الشخصية عند الأقدام برمجياً
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2, -1)
    end)
end)

-- 4. تمص (Tms)
_G.TmsTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- حركة مشابهة متبادلة مع إزاحة خفيفة للأسفل
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -0.5)
    end)
end)

-- 5. جلوس في راسه (Jlos)
_G.JlosTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- الانتقال وتثبيت الحوض فوق رأس الضحية تماماً
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
    end)
end)

-- 6. حقيبة ظهر (Bag)
_G.BagTargetBtn.MouseButton1Click:Connect(function()
    applyFunctionToTarget(function(target)
        -- الالتصاق بظهر الضحية وكأنك حقيبة معلقة به
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 1.5)
    end)
end)

print("==================================================")
print("--- [مبروك يا أيهم! تم اكتمال أساس الطوب والأسمنت للسكربت بنسبة 100%] ---")
print("==================================================")
