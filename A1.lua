-- ==========================================
-- صنع من قبل: أيهم (Made by Ayham)
-- سكربت مخصص لماب ريفن العسكرية
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- 1. إنشاء القائمة الرئيسية (UI) باللون الأصفر والأسود
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AyhamSuperMenu"
screenGui.Parent = game:GetService("CoreGui")

-- اللوحة الخلفية للقائمة
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 320)
mainFrame.Position = UDim2.new(0.1, 0, 0.3, 0) -- تظهر على يسار الشاشة لتجنب أزرار اللعبة
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- خلفية سوداء داكنة للوضوح
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- إطار أصفر ذهبي
mainFrame.Active = true
mainFrame.Draggable = true -- يمكنك سحب القائمة وتحريكها في الشاشة بجوالك
mainFrame.Parent = screenGui

-- عنوان القائمة (صنع من ايهم)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- خلفية صفراء للعنوان
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- نص أسود
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "صنع من ايهم"
titleLabel.Parent = mainFrame

-- دالة مساعدة لإنشاء الأزرار بشكل متناسق تحت بعضها
local buttonCount = 0
local function createMenuButton(text, callback)
    buttonCount = buttonCount + 1
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, 40 + (buttonCount - 1) * 55)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 215, 0) -- نص أصفر
    btn.BorderColor3 = Color3.fromRGB(255, 215, 0)
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.Parent = mainFrame
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ==========================================
-- وبرمجة وظائف الأزرار الأربعة
-- ==========================================

-- [الزر الأول: الانتقال الى الدروب]
createMenuButton("الانتقال الى الدروب", function()
    local dropsFolder = workspace:FindFirstChild("Drops") or workspace
    local targetDrop = dropsFolder:FindFirstChild("SupplyDrop") or dropsFolder:FindFirstChild("Drop") or dropsFolder:FindFirstChild("Drops")
    
    -- إذا لم يجد الاسم المباشر، يبحث عن أول شيء يحتوي اسمه على كلمة Drop
    if not targetDrop then
        for _, child in pairs(dropsFolder:GetChildren()) do
            if string.find(child.Name:lower(), "drop") then
                targetDrop = child
                break
            end
        end
    end

    if targetDrop and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = targetDrop.CFrame + Vector3.new(0, 5, 0)
        print("تم الانتقال للدروب!")
    else
        print("لم يتم العثور على دروب في الماب حالياً.")
    end
end)

-- [الزر الثاني: تجميع صناديق تلقائي]
local autoBoxes = false
createMenuButton("تجميع صناديق تلقائي", function()
    autoBoxes = not autoBoxes
    print("تجميع الصناديق التلقائي: " .. tostring(autoBoxes))
    -- هنا يتم وضع دالة التجميع التلقائي بناءً على كود الماب وحمل الصناديق للمنطقة
    -- السكربت جاهز لاستقبال المسارات البرمجية الخاصة بالصناديق وموقع التسليم
end)

-- [الزر الثالث: مضاد اي اف كي]
local antiAfkEnabled = false
createMenuButton("مضاد اي اف كي", function()
    antiAfkEnabled = not antiAfkEnabled
    print("مضاد الـ AFK: " .. tostring(antiAfkEnabled))
    
    if antiAfkEnabled then
        task.spawn(function()
            while antiAfkEnabled do
                task.wait(900) -- قفز كل 15 دقيقة
                if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
                    localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end)

-- [الزر الرابع: فلاي v2]
local flying = false
local speed = 50
createMenuButton("فلاي v2", function()
    flying = not flying
    print("الطيران: " .. tostring(flying))
    
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    
    if flying then
        -- كود طيران بسيط ومناسب للجوال عن طريق التحكم بالـ Velocity
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "AyhamFly"
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = hrp
        
        task.spawn(function()
            while flying do
                task.wait()
                if character:FindFirstChild("Humanoid") then
                    -- الطيران باتجاه الكاميرا التي ينظر إليها اللاعب
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
