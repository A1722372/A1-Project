-- سكربت الانتقال الذكي (بحث + تصغير) - أيهم (Ayham)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 160)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true

-- زر التصغير (Minimize)
local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(0.9, 0, 0, 0)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local input = Instance.new("TextBox", mainFrame)
input.Size = UDim2.new(0.9, 0, 0, 40)
input.Position = UDim2.new(0.05, 0, 0.25, 0)
input.Text = "أول 3 حروف..."

local btn = Instance.new("TextButton", mainFrame)
btn.Size = UDim2.new(0.9, 0, 0, 40)
btn.Position = UDim2.new(0.05, 0, 0.6, 0)
btn.Text = "انتقال (Teleport)"
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)

-- وظيفة التصغير
local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    mainFrame.Size = isMinimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 160)
    input.Visible = not isMinimized
    btn.Visible = not isMinimized
    minBtn.Text = isMinimized and "+" or "-"
end)

-- وظيفة الانتقال
btn.MouseButton1Click:Connect(function()
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
