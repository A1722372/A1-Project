-- سكريبت أيهم الأسطوري V12 - النسخة الكاملة 100%
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- تنظيف قديم
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

-- القائمة الجانبية (تمت زيادة القوائم إلى 7)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 400)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.BackgroundTransparency = 1

local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "الأنيميشن", "ميزات إضافية", "معلومات"}
local Pages = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    
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

-- === [ إضافة وظيفة الاستهداف المتقدم ] ===
local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 40)
NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.PlaceholderText = "أدخل أول 3 حروف من اسم اللاعب"
NameBox.Parent = TargetPage

local function getTarget()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, 3) == NameBox.Text:lower():sub(1, 3) then return p end
    end
end

-- أزرار الاستهداف
local buttons = {"انتقال", "مشاهدة", "باند (طرد)"}
for i, btnName in ipairs(buttons) do
    local btn = Instance.new("TextButton", TargetPage)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 60 + (i-1) * 40)
    btn.Text = btnName
    btn.MouseButton1Click:Connect(function()
        local target = getTarget()
        if not target then return end
        if btnName == "انتقال" then
            Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        elseif btnName == "مشاهدة" then
            workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
        end
    end)
end

-- === [ إضافة قائمة الأنيميشن ] ===
local AnimPage = Pages[5]
local anims = {"الضحك", "النوم", "التمدد", "البكاء"}
for i, animName in ipairs(anims) do
    local btn = Instance.new("TextButton", AnimPage)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.Text = animName
    btn.Parent = AnimPage
    -- هنا يتم ربط الأنيميشن (تحتاج لإضافة Animation ID خاص بك)
end
