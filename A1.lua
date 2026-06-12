-- سكريبت تجربة مغير السكنات التلقائي - سكريبت A1 (anxam)
-- مصمم ومحسن بالكامل للتلفونات (Mobile)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- تدمير النسخة القديمة لمنع تكرار القائمة على الشاشة
if CoreGui:FindFirstChild("A1_OutfitChanger") then
    CoreGui.A1_OutfitChanger:Destroy()
end

-- دالة إرسال الكود للتشات (تدعم نظام التشات القديم والجديد في روبلوكس)
local function sendChatMessage(message)
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local textChatService = game:GetService("TextChatService")
        -- فحص إذا الماب يستخدم النظام الجديد
        if textChatService and textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local targetTextChannel = textChatService:FindFirstChild("TextChannels") and textChatService.TextChannels:FindFirstChild("RBXGeneral")
            if targetTextChannel then
                targetTextChannel:SendAsync(message)
            end
        else
            -- استخدام النظام الكلاسيكي (Legacy Chat)
            local sayMessageEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if sayMessageEvent then
                sayMessageEvent:FireServer(message, "All")
            end
        end
    end
end

-- بناء الواجهة البرمجية (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "A1_OutfitChanger"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- اللوحة الرئيسية (قائمة العسكريه)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MilitaryMenu"
MainFrame.Size = UDim2.new(0, 260, 0, 320) -- حجم مثالي ومريح لشاشات التلفون
MainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- ميزة السحب بالصبع للتلفون
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- شريط العنوان العلوي
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "A1 - قائمة العسكريه"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- زر إغلاق التيستر (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -33, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- قائمة التمرير (ScrollingFrame) لمنع خروج الأزرار عن إطار الشاشة
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -45)
ScrollFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- دالة سريعة لإنشاء أزرار السكنات وتنسيقها
local function createOutfitButton(name, command, parent)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 14
    Btn.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        sendChatMessage(command)
    end)
end

----------------------------------------------------
-- [قسم سكنات الأولاد]
----------------------------------------------------
local BoysHeader = Instance.new("TextButton")
BoysHeader.Size = UDim2.new(1, -5, 0, 35)
BoysHeader.BackgroundColor3 = Color3.fromRGB(45, 65, 95)
BoysHeader.Text = "👔 سكنات الأولاد (اضغط للفتح)"
BoysHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
BoysHeader.Font = Enum.Font.SourceSansBold
BoysHeader.TextSize = 14
BoysHeader.Parent = ScrollFrame

local BoysCorner = Instance.new("UICorner")
BoysCorner.CornerRadius = UDim.new(0, 5)
BoysCorner.Parent = BoysHeader

local BoysContainer = Instance.new("Frame")
BoysContainer.Size = UDim2.new(1, 0, 0, 0)
BoysContainer.BackgroundTransparency = 1
BoysContainer.Visible = false
BoysContainer.Parent = ScrollFrame

local BoysList = Instance.new("UIListLayout")
BoysList.Parent = BoysContainer
BoysList.Padding = UDim.new(0, 4)

-- السكن الخاص بك مضاف كأول سكن هنا:
createOutfitButton("سكن ديربي الأساسي 👑", "/char me Soooma203040", BoysContainer)
createOutfitButton("سكن عسكري تجريبي 1", "/char me Player1", BoysContainer)
createOutfitButton("سكن عسكري تجريبي 2", "/char me Player2", BoysContainer)

-- منطق الإخفاء والإظهار الذكي (Toggle) لقائمة الأولاد
local boysOpen = false
BoysHeader.MouseButton1Click:Connect(function()
    boysOpen = not boysOpen
    BoysContainer.Visible = boysOpen
    if boysOpen then
        -- حساب الحجم تلقائياً بناءً على عدد الأزرار بالداخل
        BoysContainer.Size = UDim2.new(1, 0, 0, #BoysContainer:GetChildren() * 39)
    else
        BoysContainer.Size = UDim2.new(1, 0, 0, 0)
    end
end)

----------------------------------------------------
-- [قسم سكنات البنات]
----------------------------------------------------
local GirlsHeader = Instance.new("TextButton")
GirlsHeader.Size = UDim2.new(1, -5, 0, 35)
GirlsHeader.BackgroundColor3 = Color3.fromRGB(95, 45, 65)
GirlsHeader.Text = "👗 سكنات البنات (اضغط للفتح)"
GirlsHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
GirlsHeader.Font = Enum.Font.SourceSansBold
GirlsHeader.TextSize = 14
GirlsHeader.Parent = ScrollFrame

local GirlsCorner = Instance.new("UICorner")
GirlsCorner.CornerRadius = UDim.new(0, 5)
GirlsCorner.Parent = GirlsHeader

local GirlsContainer = Instance.new("Frame")
GirlsContainer.Size = UDim2.new(1, 0, 0, 0)
GirlsContainer.BackgroundTransparency = 1
GirlsContainer.Visible = false
GirlsContainer.Parent = ScrollFrame

local GirlsList = Instance.new("UIListLayout")
GirlsList.Parent = GirlsContainer
GirlsList.Padding = UDim.new(0, 4)

-- سكنات البنات للتجربة:
createOutfitButton("سكن بنت تجريبي 1", "/char me Girl1", GirlsContainer)
createOutfitButton("سكن بنت تجريبي 2", "/char me Girl2", GirlsContainer)

-- منطق الإخفاء والإظهار الذكي (Toggle) لقائمة البنات
local girlsOpen = false
GirlsHeader.MouseButton1Click:Connect(function()
    girlsOpen = not girlsOpen
    GirlsContainer.Visible = girlsOpen
    if girlsOpen then
        GirlsContainer.Size = UDim2.new(1, 0, 0, #GirlsContainer:GetChildren() * 39)
    else
        GirlsContainer.Size = UDim2.new(1, 0, 0, 0)
    end
end)
