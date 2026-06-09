-- [[ سكريبت أيهم الأسطوري - النسخة V39 المحدثة لللاعب ]]
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

-- [1] زر التحكم
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

-- [2] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- الصفحات
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
    btn.TextColor3 = Color3.new(1, 1, 1)
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

-- [إعدادات الماب] (تم اختصارها للنسخ)
local MapPage = AllPages["اعدادات الماب"]
local FBEnabled = false; local FBButton = Instance.new("TextButton", MapPage); FBButton.Size = UDim2.new(0.9, 0, 0, 40); FBButton.Position = UDim2.new(0.05, 0, 0, 10); FBButton.Text = "السطوع: مطفأ"; FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", FBButton); FBButton.MouseButton1Click:Connect(function() FBEnabled = not FBEnabled; Lighting.Ambient = FBEnabled and Color3.new(1,1,1) or Color3.new(0,0,0); FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"; FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)

-- [تبويب اللاعب - المحدث]
local PlayerPage = AllPages["اللاعب"]

-- السرعة (On/Off)
local SpeedInput = Instance.new("TextBox", PlayerPage); SpeedInput.Size = UDim2.new(0.5, 0, 0, 40); SpeedInput.Position = UDim2.new(0.05, 0, 0, 10); SpeedInput.PlaceholderText = "السرعة"; Instance.new("UICorner", SpeedInput)
local SpeedBtn = Instance.new("TextButton", PlayerPage); SpeedBtn.Size = UDim2.new(0.35, 0, 0, 40); SpeedBtn.Position = UDim2.new(0.6, 0, 0, 10); SpeedBtn.Text = "تحديد"; SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", SpeedBtn)
local SpeedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function() 
    SpeedEnabled = not SpeedEnabled
    if SpeedEnabled then
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
        SpeedBtn.Text = "شغال"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        Player.Character.Humanoid.WalkSpeed = 16
        SpeedBtn.Text = "تحديد"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- القفز (On/Off)
local JumpInput = Instance.new("TextBox", PlayerPage); JumpInput.Size = UDim2.new(0.5, 0, 0, 40); JumpInput.Position = UDim2.new(0.05, 0, 0, 60); JumpInput.PlaceholderText = "قوة القفز"; Instance.new("UICorner", JumpInput)
local JumpBtn = Instance.new("TextButton", PlayerPage); JumpBtn.Size = UDim2.new(0.35, 0, 0, 40); JumpBtn.Position = UDim2.new(0.6, 0, 0, 60); JumpBtn.Text = "تحديد"; JumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", JumpBtn)
local JumpEnabledInput = false
JumpBtn.MouseButton1Click:Connect(function() 
    JumpEnabledInput = not JumpEnabledInput
    if JumpEnabledInput then
        Player.Character.Humanoid.UseJumpPower = true
        Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50
        JumpBtn.Text = "شغال"
        JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        Player.Character.Humanoid.JumpPower = 50
        JumpBtn.Text = "تحديد"
        JumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- قفز لا نهائي واختراق جدران (كما اتفقنا)
local InfJumpBtn = Instance.new("TextButton", PlayerPage); InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 40); InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 110); InfJumpBtn.Text = "قفز لا نهائي"; InfJumpBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80); Instance.new("UICorner", InfJumpBtn)
local JumpEnabled = false; InfJumpBtn.MouseButton1Click:Connect(function() JumpEnabled = not JumpEnabled; InfJumpBtn.BackgroundColor3 = JumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80) end); UIS.JumpRequest:Connect(function() if JumpEnabled then Player.Character.Humanoid:ChangeState("Jumping") end end)

local NoclipBtn = Instance.new("TextButton", PlayerPage); NoclipBtn.Size = UDim2.new(0.9, 0, 0, 40); NoclipBtn.Position = UDim2.new(0.05, 0, 0, 160); NoclipBtn.Text = "اختراق الجدران"; NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80); Instance.new("UICorner", NoclipBtn); local NoclipEnabled = false; NoclipBtn.MouseButton1Click:Connect(function() NoclipEnabled = not NoclipEnabled; NoclipBtn.BackgroundColor3 = NoclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80) end); RunService.Stepped:Connect(function() if NoclipEnabled and Player.Character then for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
