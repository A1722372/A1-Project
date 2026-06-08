-- السكربت الشامل المطور - أيهم (Ayham)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- أيقونة الأيقونة الخاصة بك (استبدل الرقم برقم صورتك `1000000371.png` بعد رفعها)
local iconBtn = Instance.new("ImageButton", screenGui)
iconBtn.Size = UDim2.new(0, 60, 0, 60)
iconBtn.Position = UDim2.new(0, 20, 0, 20)
iconBtn.Image = "rbxassetid://ضع_رقم_الصورة_هنا" 
iconBtn.Visible = false
iconBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; iconBtn.Visible = false end)

-- نظام المشاهدة (Spectate)
local spectating = false
local targetPlayer = nil

local function spectate(target)
    if target and target.Character and target.Character:FindFirstChild("Humanoid") then
        camera.CameraSubject = target.Character.Humanoid
        spectating = true
    end
end

-- تبويبات السكربت
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(0, 150, 1, 0)
-- (باقي كود التبويبات كما هو في الإصدار السابق لضمان التوافق)

-- زر المشاهدة (يوضع في تبويب الاستهداف)
local specBtn = Instance.new("TextButton", targetPage)
specBtn.Size = UDim2.new(0.8, 0, 0, 40)
specBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
specBtn.Text = "مشاهدة (Spectate)"
specBtn.MouseButton1Click:Connect(function()
    local search = string.lower(input.Text)
    for _, p in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #search) == search then
            spectate(p)
            break
        end
    end
end)

-- زر إيقاف المشاهدة
local stopSpecBtn = Instance.new("TextButton", targetPage)
stopSpecBtn.Size = UDim2.new(0.8, 0, 0, 40)
stopSpecBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
stopSpecBtn.Text = "إيقاف المشاهدة"
stopSpecBtn.MouseButton1Click:Connect(function()
    camera.CameraSubject = localPlayer.Character:FindFirstChild("Humanoid")
    spectating = false
end)
