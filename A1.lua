-- [[ سكريبت أيهم الأسطوري - النسخة V46 المعدلة (إصلاح الأخطاء فقط) ]]

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

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0)
ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
local MenuConfig = {"اعدادات الماب", "اللاعب"}

for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", btn)
    local page = Instance.new("Frame", ContentArea) -- تم تغيير ScrollingFrame لـ Frame لضمان الظهور
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- تبويب الماب (الإصلاح)
local MapPage = AllPages["اعدادات الماب"]
local FBBtn = Instance.new("TextButton", MapPage); FBBtn.Size = UDim2.new(0.9, 0, 0, 40); FBBtn.Position = UDim2.new(0.05, 0, 0, 10); FBBtn.Text = "السطوع"; FBBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); Instance.new("UICorner", FBBtn)
FBBtn.MouseButton1Click:Connect(function() Lighting.Ambient = Color3.new(1,1,1) end)

-- تبويب اللاعب (إضافة الـ ON/OFF)
local PlayerPage = AllPages["اللاعب"]

-- اختراق الجدران (مع خاصية التبديل)
local NoclipBtn = Instance.new("TextButton", PlayerPage); NoclipBtn.Size = UDim2.new(0.9, 0, 0, 40); NoclipBtn.Position = UDim2.new(0.05, 0, 0, 10); NoclipBtn.Text = "اختراق الجدران: OFF"; NoclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", NoclipBtn)
local NoclipOn = false; NoclipBtn.MouseButton1Click:Connect(function() NoclipOn = not NoclipOn; NoclipBtn.Text = NoclipOn and "اختراق الجدران: ON" or "اختراق الجدران: OFF"; NoclipBtn.BackgroundColor3 = NoclipOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)
RunService.Stepped:Connect(function() if NoclipOn and Player.Character then for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end)

-- قفز لا نهائي (مع خاصية التبديل)
local InfJumpBtn = Instance.new("TextButton", PlayerPage); InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 40); InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 60); InfJumpBtn.Text = "قفز لا نهائي: OFF"; InfJumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", InfJumpBtn)
local JumpOn = false; InfJumpBtn.MouseButton1Click:Connect(function() JumpOn = not JumpOn; InfJumpBtn.Text = JumpOn and "قفز لا نهائي: ON" or "قفز لا نهائي: OFF"; InfJumpBtn.BackgroundColor3 = JumpOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)
UIS.JumpRequest:Connect(function() if JumpOn then Player.Character.Humanoid:ChangeState("Jumping") end end)

-- الطيران
local FlyV3Btn = Instance.new("TextButton", PlayerPage); FlyV3Btn.Size = UDim2.new(0.9, 0, 0, 40); FlyV3Btn.Position = UDim2.new(0.05, 0, 0, 110); FlyV3Btn.Text = "تفعيل الطيران (Fly V3)"; FlyV3Btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200); Instance.new("UICorner", FlyV3Btn)
FlyV3Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
    
