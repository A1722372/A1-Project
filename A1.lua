-- ==========================================
-- صنع من قبل: أيهم (Made by Ayham)
-- واجهة VR7 المتقدمة - النسخة المصلحة بالكامل
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- 1. إنشاء الشاشة الرئيسية للواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AyhamVR7Premium"
screenGui.Parent = game:GetService("CoreGui")

-- اللوحة الخلفية الكبيرة للسكربت (أبعاد وتصميم VR7)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 560, 0, 340)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(218, 165, 32) -- إطار ذهبي
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- الشريط العلوي (Title Bar)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextAlignment = Enum.TextAlignment.Left
titleLabel.Text = "AYHAM TEAM: The Mercy Script"
titleLabel.Parent = topBar

-- زر التصغير (-)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
closeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Text = "-"
closeBtn.Parent = topBar

-- لوحة التبويبات الجانبية على اليسار
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(0, 150, 1, -40)
tabsFrame.Position = UDim2.new(0, 0, 0, 40)
tabsFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = mainFrame

-- لوحة المحتويات الرئيسية على اليمين
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -150, 1, -40)
contentFrame.Position = UDim2.new(0, 150, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- مخزن صفحات التبويبات
local pages = {}
local activePage = nil

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = contentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = page
    
    return page
end

local tabCount = 0
local function registerTab(tabName)
    tabCount = tabCount + 1
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 35)
    tabBtn.Position = UDim2.new(0, 5, 0, 10 + (tabCount - 1) * 42)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.TextSize = 13
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.Text = tabName
    tabBtn.Parent = tabsFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 4)
    uiCorner.Parent = tabBtn
    
    local page = createPage()
    pages[tabName] = {button = tabBtn, page = page}
    
    tabBtn.MouseButton1Click:Connect(function()
        if activePage then
            activePage.page.Visible = false
            activePage.button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            activePage.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        tabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        activePage = pages[tabName]
    end)
    
    return page
end

-- دالة إنشاء أزرار الميزات (تتحول للذهبي عند التفعيل)
local function createFeatureButton(parentPage, text, callback)
    local isEnabled = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    btn.Text = text
    btn.Parent = parentPage
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- ذهبي عند التفعيل
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        callback(isEnabled)
    end)
    return btn
end

-- ==========================================
-- إنشاء صفحات التبويبات الثلاثة
-- ==========================================
local pageHome = registerTab("القائمة الرئيسية | Home")
local pageTarget = registerTab("استهداف | Target")
local pageAnims = registerTab("انميشنات | Anims")

-- تفعيل الصفحة الأولى تلقائياً عند الفتح
pages["القائمة الرئيسية | Home"].page.Visible = true
pages["القائمة الرئيسية | Home"].button.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
pages["القائمة الرئيسية | Home"].button.TextColor3 = Color3.fromRGB(0, 0, 0)
activePage = pages["القائمة الرئيسية | Home"]

-- ==========================================
-- برمجة ميزات [القائمة الرئيسية | Home]
-- ==========================================

createFeatureButton(pageHome, "الانتقال الى النزال الجوي (الدروب)", function(enabled)
    _G.AutoDrop = enabled
    if enabled then
        task.spawn(function()
            while _G.AutoDrop do
                task.wait(0.5)
                local targetDrop = workspace:FindFirstChild("SupplyDrop") or workspace:FindFirstChild("Drop")
                if not targetDrop then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v.Name == "SupplyDrop" or (v:IsA("BasePart") and string.find(v.Name:lower(), "supply")) then
                            targetDrop = v
                            break
                        end
                    end
                end
                if targetDrop and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character.HumanoidRootPart.CFrame = targetDrop.CFrame + Vector3.new(0, 4, 0)
                end
            end
        end)
    end
end)

-- ==========================================
-- برمجة ميزات [استهداف | Target]
-- ==========================================

local playerDropdown = Instance.new("TextBox")
playerDropdown.Size = UDim2.new(1, 0, 0, 35)
playerDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDropdown.Font = Enum.Font.SourceSans
playerDropdown.TextSize = 14
playerDropdown.Text = "اكتب اسم اللاعب هنا واضغط انتر..."
playerDropdown.Parent = pageTarget

local selectedPlayerName = ""
playerDropdown.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        selectedPlayerName = playerDropdown.Text
    end
end)

createFeatureButton(pageTarget, "انتقال إلى اللاعب المختار", function(enabled)
    if enabled and selectedPlayerName ~= "" then
        local p = Players:FindFirstChild(selectedPlayerName)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
            end
        end
    end
end)

local cam = workspace.CurrentCamera
createFeatureButton(pageTarget, "مراقبة شاشة اللاعب (Spectate)", function(enabled)
    if enabled and selectedPlayerName ~= "" then
        local p = Players:FindFirstChild(selectedPlayerName)
        if p and p.Character and p.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = p.Character.Humanoid
        end
    else
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = localPlayer.Character.Humanoid
        end
    end
end)

-- ==========================================
-- برمجة ميزات [انميشنات | Anims] (رقصات R6)
-- ==========================================

local function playR6Animation(animId)
    local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animId
        local track = humanoid:LoadAnimation(anim)
        track:Play()
    end
end

-- تم إصلاح هذا السطر هنا بنجاح ليعمل دون مشاكل
createFeatureButton(pageAnims, "تشغيل رقصة R6: التلويح", function(enabled)
    if enabled then playR6Animation("128062452") end
end)

createFeatureButton(pageAnims, "تشغيل رقصة R6: التشجيع", function(enabled)
    if enabled then playR6Animation("128062755") end
end)

-- ==========================================
-- أنظمة الخلفية التلقائية (التصغير والتذكير الديني)
-- ==========================================

local isMinimized = false
closeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 560, 0, 40)
        tabsFrame.Visible = false
        contentFrame.Visible = false
        closeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 560, 0, 340)
        tabsFrame.Visible = true
        contentFrame.Visible = true
        closeBtn.Text = "-"
    end
end)

task.spawn(function()
    while true do
        task.wait(1500) -- تذكير كل 25 دقيقة تلقائياً
        local notifyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        local notifyFrame = Instance.new("Frame", notifyGui)
        notifyFrame.Size = UDim2.new(0, 350, 0, 60)
        notifyFrame.Position = UDim2.new(0.5, -175, 0.1, 0)
        notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        notifyFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
        notifyFrame.BorderSizePixel = 2
        
        local notifyLabel = Instance.new("TextLabel", notifyFrame)
        notifyLabel.Size = UDim2.new(1, 0, 1, 0)
        notifyLabel.BackgroundTransparency = 1
        notifyLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        notifyLabel.Font = Enum.Font.SourceSansBold
        notifyLabel.TextSize = 18
        notifyLabel.Text = "✨ تذكير: صلِّ على محمد وال محمد ﷺ ✨"
        
        task.wait(7)
        notifyGui:Destroy()
    end
end)
