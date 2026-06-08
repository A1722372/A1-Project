-- ==========================================
-- صنع من قبل: أيهم (Made by Ayham)
-- واجهة VR7 المبسطة - تبويب الاستهداف فقط
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera

-- 1. إنشاء الشاشة الرئيسية
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AyhamVR7Base"
screenGui.Parent = game:GetService("CoreGui")

-- اللوحة الخلفية (تصميم VR7)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 250)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- إطار ذهبي
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- الشريط العلوي
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "AYHAM TEAM: Target Menu"
titleLabel.Parent = topBar

-- لوحة المحتوى الداخلية
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -55)
contentFrame.Position = UDim2.new(0, 10, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.Parent = contentFrame

-- ==========================================
-- عناصر قائمة الاستهداف (Target)
-- ==========================================

-- 1. خانة كتابة اسم اللاعب
local playerInput = Instance.new("TextBox")
playerInput.Size = UDim2.new(1, 0, 0, 35)
playerInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
playerInput.Font = Enum.Font.SourceSans
playerInput.TextSize = 14
playerInput.Text = "اكتب اسم اللاعب هنا واضغط Enter"
playerInput.Parent = contentFrame

local targetName = ""
playerInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        targetName = playerInput.Text
    end
end)

-- دالة مساعدة لإنشاء الأزرار بنظام التفعيل الذهبي
local function createButton(text, callback)
    local isEnabled = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    btn.Text = text
    btn.Parent = contentFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- يقلب ذهبي عند التفعيل
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- يرجع طبيعي عند الإطفاء
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        callback(isEnabled)
    end)
end

-- 2. زر الانتقال (Teleport)
createButton("انتقال إلى اللاعب (Teleport)", function(enabled)
    if enabled and targetName ~= "" then
        local p = Players:FindFirstChild(targetName)
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
            end
        end
    end
end)

-- 3. زر المراقبة (Spectate)
createButton("مراقبة شاشة اللاعب (Spectate)", function(enabled)
    if enabled and targetName ~= "" then
        local p = Players:FindFirstChild(targetName)
        if p and p.Character and p.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = p.Character.Humanoid
        end
    else
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = localPlayer.Character.Humanoid
        end
    end
end)
