-- [[ سكريبت أيهم - النسخة المستقرة 4.0 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

if PlayerGui:FindFirstChild("AihamSuperMenu") then
    PlayerGui.AihamSuperMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- زر الفتح والإغلاق
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 20
ToggleButton.BorderSizePixel = 2
ToggleButton.Parent = ScreenGui

ToggleButton.Active = true
ToggleButton.Draggable = true

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SideMenu = Instance.new("Frame")
SideMenu.Size = UDim2.new(0, 130, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -35)
ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentArea.Parent = MainFrame

-- التبويبات الأربعة الأساسية للنسخة 4.0
local Pages = {}
local menuNames = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ"}

for i, name in ipairs(menuNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 15)
    TabBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 13
    TabBtn.Parent = SideMenu

    local PageFrame = Instance.new("Frame")
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.BackgroundTransparency = 1
    PageFrame.Visible = (i == 1)
    PageFrame.Parent = ContentArea
    Pages[i] = PageFrame

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in ipairs(Pages) do page.Visible = false end
        PageFrame.Visible = true
    end)
end

local function createAbilityButton(parent, text, position, onClick)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 32)
    Btn.Position = position
    Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 13
    Btn.Parent = parent

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        Btn.BackgroundColor3 = active and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        onClick(active, Btn)
    end)
    return Btn
end

-- تبويب 1: الإعدادات
local SettingsPage = Pages[1]
createAbilityButton(SettingsPage, "إضاءة ساطعة (FullBright)", UDim2.new(0.05, 0, 0, 10), function(isActive)
    game.Lighting.Ambient = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
end)

-- تبويب 2: اللاعب
local PlayerPage = Pages[2]
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, 0, 1, 0)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 220)
PlayerScroll.ScrollBarThickness = 5
PlayerScroll.Parent = PlayerPage

local function createCustomValueButton(parent, buttonText, defaultNumber, positionY, onToggle)
    local isBtnActive = false
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.65, 0, 0, 32); Btn.Position = UDim2.new(0.05, 0, 0, positionY); Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200); Btn.Text = buttonText; Btn.TextColor3 = Color3.fromRGB(0, 0, 0); Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 13; Btn.Parent = parent

    local NumInput = Instance.new("TextBox")
    NumInput.Size = UDim2.new(0.2, 0, 0, 32); NumInput.Position = UDim2.new(0.75, 0, 0, positionY); NumInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45); NumInput.TextColor3 = Color3.fromRGB(255, 255, 0); NumInput.Text = tostring(defaultNumber); NumInput.Font = Enum.Font.SourceSansBold; NumInput.TextSize = 15; NumInput.ClearTextOnFocus = false; NumInput.Parent = parent

    Btn.MouseButton1Click:Connect(function()
        isBtnActive = not isBtnActive
        Btn.BackgroundColor3 = isBtnActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        local currentNum = tonumber(NumInput.Text) or defaultNumber
        onToggle(isBtnActive, currentNum)
    end)
end

createCustomValueButton(PlayerScroll, "تفعيل السرعة الفائقة", 60, 10, function(isActive, speedValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = isActive and speedValue or 16 end
end)

createCustomValueButton(PlayerScroll, "تفعيل القفز العالي", 120, 45, function(isActive, jumpValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = isActive and jumpValue or 50 end
end)

-- تبويب 3: الاستهداف
local TargetPage = Pages[3]
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0, 40); NameInput.Position = UDim2.new(0.05, 0, 0, 15); NameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40); NameInput.TextColor3 = Color3.fromRGB(255, 255, 255); NameInput.PlaceholderText = "اكتب أول أحرف من اسم اللاعب..."; NameInput.Text = ""; NameInput.Font = Enum.Font.SourceSans; NameInput.TextSize = 14; NameInput.Parent = TargetPage

local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 45); TeleportBtn.Position = UDim2.new(0.05, 0, 0, 75); TeleportBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0); TeleportBtn.Text = "انتقال للاعب"; TeleportBtn.TextColor3 = Color3.fromRGB(0, 0, 0); TeleportBtn.Font = Enum.Font.SourceSansBold; TeleportBtn.TextSize = 16; TeleportBtn.Parent = TargetPage

TeleportBtn.MouseButton1Click:Connect(function()
    local text = NameInput.Text:lower()
    if text == "" then return end
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #text) == text then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local myChar = Player.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then myChar.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
            end
            break
        end
    end
end)

-- تبويب 4: نقاط الحفظ
local CheckpointPage = Pages[4]
local CPNameInput = Instance.new("TextBox")
CPNameInput.Size = UDim2.new(0.9, 0, 0, 35); CPNameInput.Position = UDim2.new(0.05, 0, 0, 10); CPNameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45); CPNameInput.TextColor3 = Color3.fromRGB(255, 255, 255); CPNameInput.PlaceholderText = "اسم النقطة..."; CPNameInput.Text = ""; CPNameInput.Font = Enum.Font.SourceSans; CPNameInput.TextSize = 14; CPNameInput.Parent = CheckpointPage

local SaveCPBtn = Instance.new("TextButton")
SaveCPBtn.Size = UDim2.new(0.9, 0, 0, 35); SaveCPBtn.Position = UDim2.new(0.05, 0, 0, 50); SaveCPBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); SaveCPBtn.Text = "حفظ النقطة الحالية"; SaveCPBtn.TextColor3 = Color3.fromRGB(255, 255, 255); SaveCPBtn.Font = Enum.Font.SourceSansBold; SaveCPBtn.TextSize = 14; SaveCPBtn.Parent = CheckpointPage
