-- [[ سكريبت أيهم الأسطوري - الجزء الأول: نظام الواجهة المتكامل ]]
_G.AihamMenuLoaded = true
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- تدمير النسخة القديمة إذا وجدت
if PlayerGui:FindFirstChild("AihamLegendaryMenu") then PlayerGui.AihamLegendaryMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamLegendaryMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 200, 50)
MainFrame.Active = true
MainFrame.Draggable = true

-- شريط العنوان
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "VR7 TEAM: The Mercy Script [Full Version]"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- القائمة الجانبية (SideMenu)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.ScrollBarThickness = 2
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 400)

-- منطقة المحتوى (ContentArea)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -35)
ContentArea.Position = UDim2.new(0, 140, 0, 35)
ContentArea.BackgroundTransparency = 1

_G.Pages = {}
local MenuButtons = {}
local tabs = {
    {eng = "Home", arb = "الرئيسية"}, {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"}, {eng = "Target", arb = "استهداف"},
    {eng = "Misc", arb = "إعدادات"}
}

-- دالة التبديل بين الصفحات
_G.SelectTab = function(index)
    for i, page in ipairs(_G.Pages) do
        page.Visible = (i == index)
        if MenuButtons[i] then
            MenuButtons[i].BackgroundColor3 = (i == index) and Color3.fromRGB(180, 150, 20) or Color3.fromRGB(40, 40, 40)
        end
    end
end

-- بناء الأزرار والصفحات
for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = tab.eng .. " | " .. tab.arb
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    MenuButtons[i] = btn
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 600)
    page.Visible = false
    _G.Pages[i] = page
    
    btn.MouseButton1Click:Connect(function() _G.SelectTab(i) end)
end

-- زر فتح القائمة العائم
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.Text = "VR7"
ToggleButton.TextColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

print("الجزء الأول مكتمل! بانتظار طلبك للجزء الثاني.")
-- [[ سكريبت أيهم الأسطوري - الجزء الثاني: تصميم عناصر صفحة اللاعب كاملة ]]
if not _G.AihamMenuLoaded then print("يرجى تشغيل الجزء الأول أولاً!") return end

local CharPage = _G.Pages[3] -- صفحة اللاعب رقم 3
CharPage.CanvasSize = UDim2.new(0, 0, 0, 520)

-- دالة مساعدة لإنشاء صف يحتوي على زر وخانة إدخال نصوص (للأرقام)
local function createRowWithInput(text, placeholder, yPos)
    local btn = Instance.new("TextButton", CharPage)
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = UDim2.new(0.03, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15

    local box = Instance.new("TextBox", CharPage)
    box.Size = UDim2.new(0.45, 0, 0, 35)
    box.Position = UDim2.new(0.52, 0, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    return btn, box
end

-- دالة مساعدة لإنشاء الأزرار العادية الموزعة على الأعمدة
local function createNormalBtn(text, xPos, yPos)
    local btn = Instance.new("TextButton", CharPage)
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    return btn
end

-- بناء الأسطر الثلاثة الأولى (أزرار السرعة، النط، وسرعة الطيران مع الخانات)
_G.WSBtn, _G.WSBox = createRowWithInput("السرعه | Ws", "Number [1-99999]", 15)
_G.JumpBtn, _G.JumpBox = createRowWithInput("النط | Jump", "Number [1-99999]", 55)
_G.FlySpeedBtn, _G.FlySpeedBox = createRowWithInput("سرعه الطيران", "Number [1-99999]", 95)

-- توزيع بقية الأزرار على عمودين بشكل منسق واحترافي
_G.FlyBtn = createNormalBtn("سكربت طيران", 0.03, 145)
_G.CheckSaveBtn = createNormalBtn("حفظ الشيك بوينت", 0.52, 145)

_G.NoclipBtn = createNormalBtn("اختراق جدران", 0.03, 190)
_G.CheckTPBtn = createNormalBtn("انتقال للشيك بوينت", 0.52, 190)

-- زر الاختفاء الذي سيشغل طور الشبح المعدل
_G.InvisBtn = createNormalBtn("اختفاء (Ghost Mode)", 0.03, 235)
_G.CheckRemoveBtn = createNormalBtn("ازاله الشيك بوينت", 0.52, 235)

_G.InfJumpBtn = createNormalBtn("قفز لانهائى", 0.03, 280)
_G.TPToolBtn = createNormalBtn("اداة الانتقال", 0.52, 280)

_G.SelectTab(3)
print("الجزء الثاني جاهز بالكامل ومطابق للتصميم! بانتظار طلبك للرقم 3 لتشغيل كل الميزات مع التعديل الأخير للـ Ghost Mode.")
-- [[ سكريبت أيهم الأسطوري - الجزء الثالث: تشغيل الميزات والربط الكامل بدون اختصارات ]]
if not _G.WSBtn then print("تنبيه: يرجى تشغيل الجزء الثاني أولاً!") return end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- متغيرات التحكم بالحالة (كاملة وبدون اختصار)
local flySpeed = 50
local flying = false
local noclip = false
local infJump = false
local ghostMode = false
local savedCheckpoint = nil
local localClone = nil
local renderConnection = nil

-- دالة للحصول على الكاركتر الحالي بأمان
local function getChar()
    return Player.Character or Player.CharacterAdded:Wait()
end

-- ==========================================
-- 1. برمجة زر وخانة السرعة (WalkSpeed)
-- ==========================================
_G.WSBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local targetSpeed = tonumber(_G.WSBox.Text) or 16
        hum.WalkSpeed = targetSpeed
        print("[السرعة]: تم ضبط السرعة على: " .. tostring(targetSpeed))
    end
end)

-- ==========================================
-- 2. برمجة زر وخانة قوة القفز (JumpPower)
-- ==========================================
_G.JumpBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local targetJump = tonumber(_G.JumpBox.Text) or 50
        hum.JumpPower = targetJump
        hum.UseJumpPower = true
        print("[القفز]: تم ضبط القوة على: " .. tostring(targetJump))
    end
end)

-- ==========================================
-- 3. برمجة خانة سرعة الطيران
-- ==========================================
_G.FlySpeedBtn.MouseButton1Click:Connect(function()
    flySpeed = tonumber(_G.FlySpeedBox.Text) or 50
    print("[الطيران]: تم تعديل السرعة إلى: " .. tostring(flySpeed))
end)

-- ==========================================
-- 4. برمجة زر سكربت الطيران (Fly)
-- ==========================================
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

-- ==========================================
-- 5. برمجة زر اختراق الجدران (Noclip)
-- ==========================================
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

-- ==========================================
-- 6. القفز اللانهائي (Inf Jump)
-- ==========================================
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

-- ==========================================
-- 7. زر الاختفاء الاحترافي (Ghost Mode 100% زي الصور)
-- ==========================================
_G.InvisBtn.MouseButton1Click:Connect(function()
    ghostMode = not ghostMode
    _G.InvisBtn.BackgroundColor3 = ghostMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    local char = getChar()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if ghostMode then
        -- أ) إخفاء الكاركتر الأصلي بالكامل عن بقية السيرفر والناس
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 1
            end
        end
        
        -- ب) إنشاء النسخة الشفافة بالكامل محلياً (تظهر لك أنت فقط)
        char.Archivable = true
        localClone = char:Clone()
        localClone.Name = "Aiham_Ghost_Clone"
        localClone.Parent = workspace
        
        -- ج) جعل النسخة شفافة بنسبة 50% ولا تصطدم بالجدران (زي الصورة)
        for _, part in pairs(localClone:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0.5
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        -- د) نقل الجسد الحقيقي تحت الأرض (في الأمان ومخفي عن السيرفر)
        root.CFrame = root.CFrame * CFrame.new(0, -5000, 0)
        
        -- هـ) تحويل تتبع الكاميرا للجسد الوهمي الشفاف عشان الكاميرا ما تعلق
        if localClone:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = localClone:FindFirstChildOfClass("Humanoid")
        end
        
        -- و) ربط ومزامنة الحركة: الجسد الوهمي يتحرك فوق والأساسي تحت الأرض
        renderConnection = RunService.RenderStepped:Connect(function()
            if ghostMode and char and root and localClone and localClone:FindFirstChild("HumanoidRootPart") then
                -- الجسد الوهمي يتبع إحداثيات تحكمك باللاعب الحقيقي (مع رفعه 5000 للأعلى)
                localClone.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
            end
        end)
        print("[طور الشبح]: تم التفعيل! الجسد الحقيقي تحت الأرض والوهمي الشفاف فوق.")
    else
        -- ز) إلغاء التفعيل: تنظيف وإعادة كل شيء لطبيعته
        if renderConnection then renderConnection:Disconnect() renderConnection = nil end
        if localClone then localClone:Destroy() localClone = nil end
        
        -- إرجاع الكاميرا للاعب الحقيقي
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then Camera.CameraSubject = hum end
        
        -- إعادة الجسد الحقيقي للمكتب الأصلي فوق الأرض وإظهاره للجميع
        root.CFrame = root.CFrame * CFrame.new(0, 5000, 0)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0
            end
        end
        print("[طور الشبح]: تم الإلغاء وعاد اللاعب طبيعياً.")
    end
end)

-- ==========================================
-- 8. حفظ الشيك بوينت (Save Checkpoint)
-- ==========================================
_G.CheckSaveBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        savedCheckpoint = root.CFrame
        print("[الشيك بوينت]: تم حفظ الموقع الحالي بنجاح!")
    end
end)

-- ==========================================
-- 9. الانتقال للشيك بوينت (Teleport Checkpoint)
-- ==========================================
_G.CheckTPBtn.MouseButton1Click:Connect(function()
    if savedCheckpoint then
        local char = getChar()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = savedCheckpoint
            print("[الشيك بوينت]: تم الانتقال للموقع المحفوظ.")
        end
    else
        print("[الشيك بوينت]: لا يوجد موقع محفوظ للإنتقال إليه!")
    end
end)

-- ==========================================
-- 10. إزالة الشيك بوينت (Remove Checkpoint)
-- ==========================================
_G.CheckRemoveBtn.MouseButton1Click:Connect(function()
    savedCheckpoint = nil
    print("[الشيك بوينت]: تم مسح الموقع المحفوظ من الذاكرة.")
end)

-- ==========================================
-- 11. أداة الانتقال عن طريق الماوس (Click TP Tool)
-- ==========================================
_G.TPToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "أداة الانتقال [VR7]"
    tool.RequiresHandle = false
    
    tool.Activated:Connect(function()
        local pos = Mouse.Hit
        local char = getChar()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and pos then
            root.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z)
        end
    end)
    
    tool.Parent = Player.Backpack
    print("[الأداة]: تم إعطاؤك أداة الانتقال بنجاح في الحقيبة.")
end)

print("--------------------------------------------------")
print("--- تم تشغيل الجزء الثالث بالكامل وبنجاح ساحق بنسبة 100% ---")
print("--------------------------------------------------")
