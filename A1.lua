-- ==========================================
-- صنع من قبل: أيهم (Made by Ayham)
-- سكربت تجميع الصناديق التلقائي الفعلي
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- 1. تشغيل السكربت المساعد في الخلفية
pcall(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/ryfn-alaskryh-or-jwaez-ywmyh-RAVEN-ACADEMY-230857"))()
end)

-- 2. إنشاء الواجهة (UI) بقائمتك الصفراء المميزة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AyhamSuperMenuV4"
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 310)
mainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "صنع من ايهم"
titleLabel.Parent = mainFrame

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.Text = "-"
minimizeBtn.Parent = mainFrame

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
-- برمجة الأزرار المصلحة بالكامل بناءً على الصور
-- ==========================================

-- [الزر الأول]: الانتقال الى الدروب (تحديث للتعرف الفوري عند النزول)
createMenuButton("الانتقال الى الدروب", function()
    local targetDrop = workspace:FindFirstChild("SupplyDrop") or workspace:FindFirstChild("Drop")
    if not targetDrop then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "SupplyDrop" or v.Name == "DropModel" or (v:IsA("BasePart") and string.find(v.Name:lower(), "supply")) then
                targetDrop = v
                break
            end
        end
    end
    if targetDrop and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = targetDrop.CFrame + Vector3.new(0, 4, 0)
    end
end)

-- [الزر الثاني]: تجميع صناديق تلقائي (الذهاب لكومة الصناديق ثم علامة التسليم)
local autoBoxes = false
createMenuButton("تجميع صناديق تلقائي", function()
    autoBoxes = not autoBoxes
    if autoBoxes then
        task.spawn(function()
            while autoBoxes do
                task.wait(1) -- مهلة ثانية واحدة لالتقاط الصندوق والتسليم لضمان الاستجابة
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    
                    -- 1. البحث عن موقع "كومة الصناديق" (المنطقة الخضراء الأولى)
                    local boxSpawn = workspace:FindFirstChild("BoxSpawn") or workspace:FindFirstChild("BoxGiver")
                    if not boxSpawn then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v.Name == "Box" and v:IsA("BasePart") and v.Anchored then
                                boxSpawn = v -- تحديد موقع الكومة من الصناديق الثابتة
                                break
                            end
                        end
                    end
                    
                    -- الانتقال للكومة لأخذ الصندوق
                    if boxSpawn then
                        localPlayer.Character.HumanoidRootPart.CFrame = boxSpawn.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.5) -- انتظر نصف ثانية ليحمل الصندوق
                    end
                    
                    -- 2. البحث عن علامة "موقع التسليم" البيضاء
                    local deliveryZone = workspace:FindFirstChild("DeliveryZone") or workspace:FindFirstChild("DropOff")
                    if not deliveryZone then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if string.find(v.Name:lower(), "deliver") or string.find(v.Name:lower(), "finish") or v.Name == "Give" then
                                deliveryZone = v
                                break
                            end
                        end
                    end
                    
                    -- الانتقال لموقع التسليم لإنهاء المهمة
                    if deliveryZone then
                        localPlayer.Character.HumanoidRootPart.CFrame = deliveryZone.CFrame + Vector3.new(0, 2, 0)
                    end
                    
                end
            end
        end)
    end
end)

-- [الزر الثالث]: مضاد اي اف كي
local antiAfkEnabled = false
createMenuButton("مضاد اي اف كي", function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        task.spawn(function()
            while antiAfkEnabled do
                if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
                    localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(300)
            end
        end)
    end
end)

-- [الزر الرابع]: فلاي v2
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
