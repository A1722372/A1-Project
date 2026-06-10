-- [[ سكريبت أيهم الأسطوري - النسخة المستقرة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- نظام تغيير الألوان
local ColorModes = {Color3.fromRGB(20, 20, 20), Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 0), "Rainbow"}
local CurrentMode = 1
local IsRainbow = false

local function ApplyColor(color)
    if color == "Rainbow" then
        IsRainbow = true
    else
        IsRainbow = false
        MainFrame.BackgroundColor3 = color
        ToggleBtn.BackgroundColor3 = color
    end
end

RunService.RenderStepped:Connect(function()
    if IsRainbow then
        local rc = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        MainFrame.BackgroundColor3 = rc
        ToggleBtn.BackgroundColor3 = rc
    end
end)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0)
ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- استعادة كافة الوظائف الأصلية
local MapPage = AllPages["اعدادات الماب"]
local ColorBtn = Instance.new("TextButton", MapPage); ColorBtn.Size = UDim2.new(0.9, 0, 0, 40); ColorBtn.Position = UDim2.new(0.05, 0, 0, 10); ColorBtn.Text = "تغيير اللون"; ColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ColorBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", ColorBtn)
ColorBtn.MouseButton1Click:Connect(function() CurrentMode = (CurrentMode % #ColorModes) + 1; ApplyColor(ColorModes[CurrentMode]) end)

local FBButton = Instance.new("TextButton", MapPage); FBButton.Size = UDim2.new(0.9, 0, 0, 40); FBButton.Position = UDim2.new(0.05, 0, 0, 60); FBButton.Text = "السطوع"; FBButton.TextColor3 = Color3.fromRGB(255, 255, 255); FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", FBButton)
FBButton.MouseButton1Click:Connect(function() Lighting.Ambient = (Lighting.Ambient == Color3.new(0,0,0)) and Color3.new(1,1,1) or Color3.new(0,0,0) end)

-- وظائف اللاعب
local PlayerPage = AllPages["اللاعب"]
local FlyV3Btn = Instance.new("TextButton", PlayerPage); FlyV3Btn.Size = UDim2.new(0.9, 0, 0, 40); FlyV3Btn.Position = UDim2.new(0.05, 0, 0, 10); FlyV3Btn.Text = "طيران"; FlyV3Btn.TextColor3 = Color3.fromRGB(255, 255, 255); FlyV3Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", FlyV3Btn)
FlyV3Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

-- وظائف الاستهداف
local TargetPage = AllPages["الاستهداف"]
local TInput = Instance.new("TextBox", TargetPage); TInput.Size = UDim2.new(0.9, 0, 0, 40); TInput.Position = UDim2.new(0.05, 0, 0, 10); TInput.PlaceholderText = "اسم اللاعب"; TInput.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", TInput)

-- وظائف التأثيرات (نار تظهر للجميع)
local EffectPage = AllPages["التأثيرات"]
local function CreateFire(color)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(char.HumanoidRootPart:GetChildren()) do if v.Name == "CustomFire" then v:Destroy() end end
        local f = Instance.new("Fire")
        f.Name = "CustomFire"
        f.Color = color
        f.SecondaryColor = color
        f.Size = 10
        f.Parent = char.HumanoidRootPart
    end
end
local Effects = {{"نار خضراء", Color3.fromRGB(0, 255, 0)}, {"نار حمراء", Color3.fromRGB(255, 0, 0)}}
for i, effectData in ipairs(Effects) do
    local b = Instance.new("TextButton", EffectPage); b.Size = UDim2.new(0.9, 0, 0, 40); b.Position = UDim2.new(0.05, 0, 0, 10 + (i-1) * 45); b.Text = effectData[1]; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() CreateFire(effectData[2]) end)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
