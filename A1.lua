local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local ContentPanel = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- إعداد الواجهة الرئيسية
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- لوحة التبويبات الجانبية (اليسرى)
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LeftPanel.Size = UDim2.new(0, 130, 1, 0)

UIListLayout.Parent = LeftPanel
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- لوحة المحتوى (اليمنى)
ContentPanel.Name = "ContentPanel"
ContentPanel.Parent = MainFrame
ContentPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentPanel.Position = UDim2.new(0, 135, 0, 5)
ContentPanel.Size = UDim2.new(1, -140, 1, -10)

-- تخزين التبويبات والمحتويات
local tabs = {}
local pages = {}

local function CreateTab(tabName, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Text = tabName
    TabButton.LayoutOrder = order
    TabButton.Parent = LeftPanel

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    Page.Parent = ContentPanel
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.Padding = UDim.new(0, 8)

    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, t in pairs(tabs) do t.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page
    return Page
end

-- دالة إنشاء الأزرار الملونة للقدرات تبعا لحالتها
local function CreateButton(page, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.95, 0, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = text
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 18
    Button.Parent = page

    local active = false
    Button.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- أخضر عند التفعيل
        else
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- رمادي عند الإطفاء
        end
        callback(active)
    end)
end

-- إنشاء الشرائح الخمسة الأولى (فارغة بناءً على طلبك لتركيز التعديل على السادسة)
for i = 1, 5 do
    CreateTab("الشريحة " .. i, i)
end

-- =========================================================
-- الشريحة السادسة فقط وتسميتها IY وإضافة القدرات الستة لها
-- =========================================================
local IYPage = CreateTab("IY", 6)

-- 1. حلقة الألوان
CreateButton(IYPage, "💫 حلقة الألوان", function(state)
    if state then
        _G.ColorRing = true
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        
        local ring = Instance.new("Part")
        ring.Name = "ColorRingPart"
        ring.Size = Vector3.new(5, 0.2, 5)
        ring.Anchored = false
        ring.CanCollide = false
        ring.Parent = char
        
        local attachment0 = Instance.new("Attachment", hrp)
        local attachment1 = Instance.new("Attachment", ring)
        local align = Instance.new("AlignPosition", ring)
        align.Attachment0 = attachment1
        align.Attachment1 = attachment0
        
        local speed = 0
        task.spawn(function()
            while _G.ColorRing and ring and ring.Parent do
                speed = speed + 0.05
                ring.Color = Color3.fromHSV(math.sin(speed)%1, 1, 1)
                task.wait(0.02)
            end
        end)
    else
        _G.ColorRing = false
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("ColorRingPart") then
            char.ColorRingPart:Destroy()
        end
    end
end)

-- 2. رؤية الأعلى (Top View)
CreateButton(IYPage, "👁️ رؤية الأعلى — Top View", function(state)
    local camera = workspace.CurrentCamera
    if state then
        _G.TopView = true
        task.spawn(function()
            while _G.TopView do
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 40, 0), hrp.Position)
                end
                task.wait()
            end
        end)
    else
        _G.TopView = false
        camera.CameraType = Enum.CameraType.Custom
    end
end)

-- 3. المشي على الجدران (WallWalk)
CreateButton(IYPage, "🧱 المشي على الجدران — WallWalk", function(state)
    _G.WallWalk = state
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    task.spawn(function()
        while _G.WallWalk and task.wait(0.1) do
            local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 3)
            local part, pos, normal = workspace:FindPartOnRay(ray, char)
            if part and math.abs(normal.Y) < 0.1 then
                hrp.Velocity = Vector3.new(0, 15, 0) + (hrp.CFrame.LookVector * 10)
            end
        end
    end)
end)

-- 4. منع الطرد تلقائياً (Anti-AFK)
CreateButton(IYPage, "⏱️ منع الطرد تلقائياً — Anti-AFK", function(state)
    if state then
        _G.AntiAFK = game.Players.LocalPlayer.Idled:Connect(function()
            local virtualUser = game:GetService("VirtualUser")
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new(0,0))
        end)
    else
        if _G.AntiAFK then
            _G.AntiAFK:Disconnect()
            _G.AntiAFK = nil
        end
    end
end)

-- 5. تدوير الشخصية باستمرار (Spin)
CreateButton(IYPage, "🌀 تدوير الشخصية — Spin", function(state)
    if state then
        _G.Spinning = true
        local char = game.Players.LocalPlayer.Character
        local hrp = char:WaitForChild("HumanoidRootPart")
        task.spawn(function()
            while _G.Spinning do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(20), 0)
                task.wait(0.01)
            end
        end)
    else
        _G.Spinning = false
    end
end)

-- 6. إخفاء الشخصية كاملاً (Invisible)
CreateButton(IYPage, "👻 إخفاء الشخصية كاملاً — Invisible", function(state)
    local char = game.Players.LocalPlayer.Character
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if part.Name ~= "HumanoidRootPart" then
                part.Transparency = state and 1 or 0
            end
        end
    end
end)

-- فتح التبويب الأول تلقائياً عند التشغيل
pages["الشريحة 1"].Visible = true
tabs["الشريحة 1"].BackgroundColor3 = Color3.fromRGB(65, 65, 65)
