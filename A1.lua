-- [[ سكريبت أيهم الأسطوري - النسخة V45 الكاملة والنهائية ]]

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
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
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
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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

-- تبويب الماب
local MapPage = AllPages["اعدادات الماب"]
local FBBtn = Instance.new("TextButton", MapPage); FBBtn.Size = UDim2.new(0.9, 0, 0, 40); FBBtn.Position = UDim2.new(0.05, 0, 0, 10); FBBtn.Text = "السطوع"; FBBtn.TextColor3 = Color3.fromRGB(255,255,255); FBBtn.BackgroundColor3 = Color3.fromRGB(50,50,50); Instance.new("UICorner", FBBtn)
FBBtn.MouseButton1Click:Connect(function() Lighting.Ambient = Color3.new(1,1,1) end)

-- تبويب اللاعب
local PlayerPage = AllPages["اللاعب"]
local SpeedInput = Instance.new("TextBox", PlayerPage); SpeedInput.Size = UDim2.new(0.9, 0, 0, 40); SpeedInput.Position = UDim2.new(0.05, 0, 0, 10); SpeedInput.PlaceholderText = "قيمة السرعة"; SpeedInput.TextColor3 = Color3.fromRGB(0,0,0); Instance.new("UICorner", SpeedInput)
local SpeedBtn = Instance.new("TextButton", PlayerPage); SpeedBtn.Size = UDim2.new(0.9, 0, 0, 40); SpeedBtn.Position = UDim2.new(0.05, 0, 0, 60); SpeedBtn.Text = "تفعيل السرعة"; SpeedBtn.TextColor3 = Color3.fromRGB(255,255,255); SpeedBtn.BackgroundColor3 = Color3.fromRGB(0,150,0); Instance.new("UICorner", SpeedBtn)
local SpeedEnabled = false; SpeedBtn.MouseButton1Click:Connect(function() SpeedEnabled = not SpeedEnabled end)
RunService.Heartbeat:Connect(function() if SpeedEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 end end)

local JumpInput = Instance.new("TextBox", PlayerPage); JumpInput.Size = UDim2.new(0.9, 0, 0, 40); JumpInput.Position = UDim2.new(0.05, 0, 0, 110); JumpInput.PlaceholderText = "قوة القفز"; JumpInput.TextColor3 = Color3.fromRGB(0,0,0); Instance.new("UICorner", JumpInput)
local JumpBtn = Instance.new("TextButton", PlayerPage); JumpBtn.Size = UDim2.new(0.9, 0, 0, 40); JumpBtn.Position = UDim2.new(0.05, 0, 0, 160); JumpBtn.Text = "تفعيل القفز"; JumpBtn.TextColor3 = Color3.fromRGB(255,255,255); JumpBtn.BackgroundColor3 = Color3.fromRGB(0,150,0); Instance.new("UICorner", JumpBtn)
local JumpEnabled = false; JumpBtn.MouseButton1Click:Connect(function() JumpEnabled = not JumpEnabled end)
RunService.Heartbeat:Connect(function() if JumpEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.UseJumpPower = true; Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 end end)

local NoclipBtn = Instance.new("TextButton", PlayerPage); NoclipBtn.Size = UDim2.new(0.9, 0, 0, 40); NoclipBtn.Position = UDim2.new(0.05, 0, 0, 210); NoclipBtn.Text = "اختراق الجدران"; NoclipBtn.TextColor3 = Color3.fromRGB(255,255,255); NoclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50); Instance.new("UICorner", NoclipBtn)
local NoclipEnabled = false; NoclipBtn.MouseButton1Click:Connect(function() NoclipEnabled = not NoclipEnabled end); RunService.Stepped:Connect(function() if NoclipEnabled and Player.Character then for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end)

local FlyV3Btn = Instance.new("TextButton", PlayerPage); FlyV3Btn.Size = UDim2.new(0.9, 0, 0, 40); FlyV3Btn.Position = UDim2.new(0.05, 0, 0, 260); FlyV3Btn.Text = "تفعيل الطيران (Fly V3)"; FlyV3Btn.TextColor3 = Color3.fromRGB(255,255,255); FlyV3Btn.BackgroundColor3 = Color3.fromRGB(0,100,200); Instance.new("UICorner", FlyV3Btn)
FlyV3Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
    
