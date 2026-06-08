local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChild("Humanoid")

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.Visible = true

-- أيقونة النسر (للإخفاء والإظهار)
local eagleButton = Instance.new("ImageButton", screenGui)
eagleButton.Size = UDim2.new(0, 50, 0, 50)
eagleButton.Position = UDim2.new(0, 10, 0, 10)
eagleButton.Image = "rbxassetid://10672727188" -- هذه صورة نسر افتراضية في روبلوكس
eagleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- 1. زر إخفاء اللاعب (تغيير الشفافية)
local btnHidePlayer = Instance.new("TextButton", frame)
btnHidePlayer.Text = "إخفاء اللاعب"
btnHidePlayer.Size = UDim2.new(1, 0, 0, 30)
btnHidePlayer.MouseButton1Click:Connect(function()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = (part.Transparency == 0) and 1 or 0
        end
    end
end)

-- 2. حقل النص
local textBox = Instance.new("TextBox", frame)
textBox.PlaceholderText = "اسم اللاعب (3 أحرف+)"
textBox.Size = UDim2.new(1, 0, 0, 30)
textBox.Position = UDim2.new(0, 0, 0, 40)

-- الأزرار
local btnTeleport = Instance.new("TextButton", frame)
btnTeleport.Text = "انتقال"
btnTeleport.Size = UDim2.new(0.5, 0, 0, 30)
btnTeleport.Position = UDim2.new(0, 0, 0, 80)
btnTeleport.Visible = false

local btnView = Instance.new("TextButton", frame)
btnView.Text = "مشاهدة"
btnView.Size = UDim2.new(0.5, 0, 0, 30)
btnView.Position = UDim2.new(0.5, 0, 0, 80)
btnView.Visible = false

textBox:GetPropertyChangedSignal("Text"):Connect(function()
    local show = #textBox.Text >= 3
    btnTeleport.Visible = show
    btnView.Visible = show
end)

-- وظيفة البحث عن اللاعب
local function findTarget()
    for _, p in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #textBox.Text) == string.lower(textBox.Text) then
            return p.Character
        end
    end
    return nil
end

-- الانتقال
btnTeleport.MouseButton1Click:Connect(function()
    local targetChar = findTarget()
    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
    end
end)

-- المشاهدة
btnView.MouseButton1Click:Connect(function()
    local targetChar = findTarget()
    if targetChar then
        workspace.CurrentCamera.CameraSubject = targetChar:FindFirstChild("Humanoid")
    end
end)
