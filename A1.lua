-- [[ سكريبت أيهم الأسطوري - النسخة V48 (إصلاح نهائي) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- تنظيف تام
if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- تبويب اللاعب (مباشر داخل الإطار)
local PlayerPage = Instance.new("Frame", MainFrame)
PlayerPage.Size = UDim2.new(1, 0, 1, 0)
PlayerPage.BackgroundTransparency = 1

-- 1. زر اختراق الجدران (مع التبديل)
local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.8, 0, 0, 50)
NoclipBtn.Position = UDim2.new(0.1, 0, 0, 20)
NoclipBtn.Text = "اختراق الجدران: OFF"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", NoclipBtn)
local NoclipOn = false
NoclipBtn.MouseButton1Click:Connect(function()
    NoclipOn = not NoclipOn
    NoclipBtn.Text = NoclipOn and "اختراق الجدران: ON" or "اختراق الجدران: OFF"
    NoclipBtn.BackgroundColor3 = NoclipOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)
RunService.Stepped:Connect(function()
    if NoclipOn and Player.Character then
        for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end
end)

-- 2. زر القفز اللانهائي (مع التبديل)
local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.8, 0, 0, 50)
InfJumpBtn.Position = UDim2.new(0.1, 0, 0, 80)
InfJumpBtn.Text = "قفز لا نهائي: OFF"
InfJumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
InfJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", InfJumpBtn)
local JumpOn = false
InfJumpBtn.MouseButton1Click:Connect(function()
    JumpOn = not JumpOn
    InfJumpBtn.Text = JumpOn and "قفز لا نهائي: ON" or "قفز لا نهائي: OFF"
    InfJumpBtn.BackgroundColor3 = JumpOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)
UIS.JumpRequest:Connect(function() if JumpOn then Player.Character.Humanoid:ChangeState("Jumping") end end)

-- 3. زر الطيران
local FlyBtn = Instance.new("TextButton", PlayerPage)
FlyBtn.Size = UDim2.new(0.8, 0, 0, 50)
FlyBtn.Position = UDim2.new(0.1, 0, 0, 140)
FlyBtn.Text = "تفعيل الطيران (Fly V3)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FlyBtn)
FlyBtn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

-- 4. زر السطوع (إصلاح القائمة الأولى)
local LightBtn = Instance.new("TextButton", PlayerPage)
LightBtn.Size = UDim2.new(0.8, 0, 0, 50)
LightBtn.Position = UDim2.new(0.1, 0, 0, 200)
LightBtn.Text = "تفعيل السطوع الكامل"
LightBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", LightBtn)
LightBtn.MouseButton1Click:Connect(function() game:GetService("Lighting").Ambient = Color3.new(1,1,1) end)
