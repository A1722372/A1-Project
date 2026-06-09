-- [[ سكريبت أيهم الأسطوري V12 - المظهر العسكري الملكي المطور (أسود وذهبي) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- تنظيف أي نسخ قديمة لضمان عمل السكريبت بنجاح
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(184, 134, 11)

local savedLocations = {}
local rainbowConnection

local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    if mode == "Red" then MainStroke.Color = Color3.fromRGB(200, 0, 0)
    elseif mode == "Yellow" then MainStroke.Color = Color3.fromRGB(184, 134, 11)
    elseif mode == "Blue" then MainStroke.Color = Color3.fromRGB(0, 90, 180)
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainStroke.Color = Color3.fromHSV(hue, 0.8, 0.8)
        end)
    end
end

-- زر الفتح والإغلاق
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(184, 134, 11)
ToggleButton.TextSize = 24
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleButton).Color = Color3.fromRGB(184, 134, 11)
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- القوائم
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.BackgroundColor3 = Color3.fromRGB(17, 18, 20)
Title.TextColor3 = Color3.fromRGB(212, 175, 55)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(19, 20, 22)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -40)
ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.88, 0, 0, 34)
    btn.Position = UDim2.new(0.06, 0, 0, (i-1) * 40 + 12)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    local btnStroke = Instance.new("UIStroke", btn)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    Pages[i] = page

    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- === شريحة 1: اعدادات الماب ===
local MapPage = Pages[1]
local cBtn1 = Instance.new("TextButton", MapPage)
cBtn1.Size = UDim2.new(0.4, 0, 0, 30) cBtn1.Position = UDim2.new(0.05, 0, 0, 10)
cBtn1.Text = "قوس قزح" cBtn1.MouseButton1Click:Connect(function() setBorderColor("Rainbow") end)

-- === شريحة 2: اللاعب (سرعة) ===
local PlayerPage = Pages[2]
local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 30) SpeedBtn.Position = UDim2.new(0.05, 0, 0, 10)
SpeedBtn.Text = "تفعيل السرعة"
SpeedBtn.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 65
    end
end)

-- === شريحة 3: الاستهداف ===
local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 35) NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.PlaceholderText = "اكتب اسم اللاعب..."

-- === شريحة 4: نقاط الحفظ ===
local CheckpointPage = Pages[4]
local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.5, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.PlaceholderText = "اسم الموقع"

local SaveBtn = Instance.new("TextButton", CheckpointPage)
SaveBtn.Size = UDim2.new(0.3, 0, 0, 32) SaveBtn.Position = UDim2.new(0.6, 0, 0, 10)
SaveBtn.Text = "حفظ"
SaveBtn.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocations[CPInput.Text] = Player.Character.HumanoidRootPart.CFrame
    end
end)
