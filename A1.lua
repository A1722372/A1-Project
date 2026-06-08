-- المطور الأسطوري أيهم - نسخة محسنة
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- 1. إنشاء الواجهة (تأكد من مسح القديمة أولاً إذا لزم الأمر)
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = true
Instance.new("UICorner", mainFrame)

-- 2. إعداد الصفحات (المحتوى)
local pages = {}
local function createPage(name)
    local frame = Instance.new("Frame", mainFrame)
    frame.Size = UDim2.new(0.7, 0, 1, 0)
    frame.Position = UDim2.new(0.3, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    pages[name] = frame
    return frame
end

local speedPage = createPage("Speed")
local jumpPage = createPage("Jump")

-- 3. وظيفة السرعة (إدخال مخصص)
local speedInput = Instance.new("TextBox", speedPage)
speedInput.PlaceholderText = "أدخل السرعة (مثلاً 1000)"
speedInput.Size = UDim2.new(0.8, 0, 0.2, 0)
speedInput.Position = UDim2.new(0.1, 0, 0.2, 0)

local speedBtn = Instance.new("TextButton", speedPage)
speedBtn.Text = "تطبيق السرعة"
speedBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
speedBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
speedBtn.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = tonumber(speedInput.Text) or 16
end)

-- 4. وظيفة القفز
local jumpBtn = Instance.new("TextButton", jumpPage)
jumpBtn.Text = "زيادة القفز (100)"
jumpBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
jumpBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
jumpBtn.MouseButton1Click:Connect(function()
    humanoid.UseJumpPower = true
    humanoid.JumpPower = 100
end)

-- 5. وظيفة الاختفاء (Toggle)
local isInvisible = false
local invisibleBtn = Instance.new("TextButton", mainFrame)
invisibleBtn.Text = "تفعيل/إلغاء الاختفاء"
invisibleBtn.Size = UDim2.new(0.25, 0, 0.1, 0)
invisibleBtn.Position = UDim2.new(0.02, 0, 0.8, 0)
invisibleBtn.MouseButton1Click:Connect(function()
    isInvisible = not isInvisible
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = isInvisible and 1 or 0
        end
    end
end)

-- 6. أزرار التنقل (لإصلاح مشكلة عدم الانتقال)
local function createNavBtn(name, pageName, pos)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Text = name
    btn.Size = UDim2.new(0.25, 0, 0.1, 0)
    btn.Position = pos
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        if pages[pageName] then pages[pageName].Visible = true end
    end)
end

createNavBtn("السرعة", "Speed", UDim2.new(0.02, 0, 0.1, 0))
createNavBtn("القفز", "Jump", UDim2.new(0.02, 0, 0.25, 0))
