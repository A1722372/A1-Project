-- سكربت أيهم (Ayham) المطور - نسخة القائمة الرئيسية
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 300)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- زر التصغير
local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(0.9, 0, 0, 0)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- حاوية الأزرار
local content = Instance.new("UIListLayout", mainFrame)
content.Padding = UDim.new(0, 5)
content.Padding = UDim.new(0, 10)

-- دالة إنشاء الأزرار
local function createButton(text, callback)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. زر الانتقال (Search)
local input = Instance.new("TextBox", mainFrame)
input.Size = UDim2.new(0.9, 0, 0, 40)
input.PlaceholderText = "اكتب أول 3 حروف..."
local tpBtn = createButton("انتقال (Teleport)", function()
    local search = string.lower(input.Text)
    for _, p in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, #search) == search then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                break
            end
        end
    end
end)

-- 2. زر مضاد الـ AFK
local antiAfkEnabled = false
createButton("مضاد AFK: إيقاف", function(btn)
    antiAfkEnabled = not antiAfkEnabled
    btn.Text = antiAfkEnabled and "مضاد AFK: تفعيل" or "مضاد AFK: إيقاف"
    if antiAfkEnabled then
        local vu = game:GetService("VirtualUser")
        localPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- 3. زر رقصات R6
createButton("تشغيل رقصات R6 (مرح)", function()
    local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://128062452" -- رقصة تشجيع
        local track = humanoid:LoadAnimation(anim)
        track:Play()
    end
end)

-- منطق التصغير
local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    mainFrame.Size = isMinimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 300)
end)
