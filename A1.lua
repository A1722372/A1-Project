-- ==========================================
-- صنع من قبل: أيهم (Made by Ayham)
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- 1. إنشاء القائمة الرئيسية (UI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AyhamSuperMenuV2"
screenGui.Parent = game:GetService("CoreGui")

-- اللوحة الخلفية للقائمة
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 310)
mainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- إطار أصفر
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- عنوان القائمة (صنع من ايهم)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- خلفية صفراء
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "صنع من ايهم"
titleLabel.Parent = mainFrame

-- [تعديل جديد]: زر لتصغير وتكبير القائمة
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.Text = "-"
minimizeBtn.Parent = mainFrame

-- حاوية الأزرار (عشان تختفي لما نصغر القائمة)
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, 0, 1, -40)
buttonContainer.Position = UDim2.new(0, 0, 0, 40)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 240, 0, 40)
        buttonContainer.Visible = false
        minimizeBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 240, 0, 310)
        buttonContainer.Visible = true
        minimizeBtn.Text = "-"
    end
end)

-- دالة إنشاء الأزرار بشكل متناسق
local buttonCount = 0
local function createMenuButton(text, callback)
    buttonCount = buttonCount + 1
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, 10 + (buttonCount - 1) * 60)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderColor3 = Color3.fromRGB(255, 215, 0)
    btn.TextSize = 15
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.Parent = buttonContainer
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ==========================================
-- برمجة الأزرار الأربعة لتعمل بذكاء وبحث أعمق
-- ==========================================

-- [الزر الأول: الانتقال الى الدروب] (بحث شامل في كل الماب)
createMenuButton("الانتقال الى الدروب", function()
    local targetDrop = nil
    -- البحث في كل مكان بالماب عن أي مجسم يحتوي اسمه على "Drop" أو "Supply"
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (string.find(obj.Name:lower(), "drop") or string.find(obj.Name:lower(), "supply")) then
            targetDrop = obj
            break
        end
    end

    if targetDrop and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = targetDrop.CFrame + Vector3.new(0, 4, 0)
    else
        print("لم يتم العثور على أي دروب نشط حالياً.")
    end
end)

-- [الزر الثاني: تجميع صناديق تلقائي] (البحث عن مجسمات الصناديق والمهمة)
local autoBoxes = false
createMenuButton("تجميع صناديق تلقائي", function()
    autoBoxes = not autoBoxes
    if autoBoxes then
        task.spawn(function()
            while autoBoxes do
                task.wait(0.5)
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- البحث عن أي صندوق قابل للحمل أو مجسم اسمه Box أو Package
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (string.find(obj.Name:lower(), "box") or string.find(obj.Name:lower(), "crate") or string.find(obj.Name:lower(), "cargo")) then
                            -- الانتقال للصندوق لتجميعه تلقائياً
                            localPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                            break
                        end
                    end
                end
            end
        end)
    end
end)

-- [الزر الثالث: مضاد اي اف كي] (معدل ليعمل فورياً وبدون انتظار طويل)
local antiAfkEnabled = false
createMenuButton("مضاد اي اف كي", function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        task.spawn(function()
            while antiAfkEnabled do
                if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
                    localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(300) -- يقفز كل 5 دقائق لضمان الحماية
            end
        end)
    end
end)

-- [الزر الرابع: فلاي v2] (شغال تمام وتم الحفاظ عليه)
local flying = false
local speed = 45
createMenuButton("فلاي v2", function()
    flying = not flying
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "AyhamFly"
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = hrp
        
        task.spawn(function()
            while flying do
                task.wait()
                if character:FindFirstChild("Humanoid") then
                    bodyVelocity.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                end
            end
            bodyVelocity:Destroy()
        end)
    else
        local flyObj = hrp:FindFirstChild("AyhamFly")
        if flyObj then flyObj:Destroy() end
    end
end)
