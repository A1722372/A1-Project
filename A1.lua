-- [[ السكريبت الأسطوري المتكامل - نسخة أيهم ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

-- زر الإغلاق والفتح
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- نظام الصفحات
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0) SideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0) ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اللاعب", "الماب", "الاستهداف", "الحفظ", "تأثيرات"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(1, 0, 0, 40) btn.Position = UDim2.new(0, 0, 0, (i-1)*45)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.Visible = (i==1) page.BackgroundTransparency = 1
    Pages[i] = page
    btn.MouseButton1Click:Connect(function() for _, p in pairs(Pages) do p.Visible = false end page.Visible = true end)
end

-- === شريحة اللاعب (السرعة، القفز، نوكليب، إنفنيتي جامب) ===
local PPage = Pages[1]
local function addButton(text, parent, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0, 35) b.Position = UDim2.new(0.05, 0, 0, #parent:GetChildren() * 40)
    b.Text = text b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback) return b
end

-- 1. السرعة
local speed = false
addButton("تفعيل السرعة (65)", PPage, function() speed = not speed Player.Character.Humanoid.WalkSpeed = speed and 65 or 16 end)
-- 2. القفز العالي
local jump = false
addButton("تفعيل القفز العالي (120)", PPage, function() jump = not jump Player.Character.Humanoid.JumpPower = jump and 120 or 50 end)
-- 3. اختراق الجدران (Noclip)
local noclip = false
addButton("اختراق الجدران (Noclip)", PPage, function() noclip = not noclip end)
RunService.Stepped:Connect(function() if noclip and Player.Character then for _,p in pairs(Player.Character:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)
-- 4. القفز اللانهائي
local infJump = false
addButton("القفز اللانهائي (Inf Jump)", PPage, function() infJump = not infJump end)
UserInputService.JumpRequest:Connect(function() if infJump then Player.Character.Humanoid:ChangeState("Jumping") end end)

-- === شريحة الحفظ (نقاط الحفظ) ===
local CPage = Pages[4]
local savedPos = {}
local input = Instance.new("TextBox", CPage)
input.Size = UDim2.new(0.8, 0, 0, 30) input.PlaceholderText = "اسم النقطة"
addButton("حفظ الموقع", CPage, function() savedPos[input.Text] = Player.Character.HumanoidRootPart.CFrame end)
addButton("انتقال للموقع", CPage, function() Player.Character.HumanoidRootPart.CFrame = savedPos[input.Text] end)

-- === إغلاق ===
local close = Instance.new("TextButton", MainFrame)
close.Size = UDim2.new(0, 30, 0, 30) close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "X" close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
