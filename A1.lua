-- [[ سكريبت أيهم - الجزء الأول: نظام الواجهة ]]
_G.AihamMenuLoaded = true
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("AihamLegendaryMenu") then 
    PlayerGui.AihamLegendaryMenu:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamLegendaryMenu"
ScreenGui.ResetOnSpawn = false
_G.MainScreenGui = ScreenGui

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 200, 50)
MainFrame.Active = true
MainFrame.Draggable = true

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "VR7 TEAM: The Mercy Script"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Name = "SideMenu"
SideMenu.Size = UDim2.new(0, 140, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(50, 50, 50)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 350)
SideMenu.ScrollBarThickness = 4

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -140, 1, -35)
ContentArea.Position = UDim2.new(0, 140, 0, 35)
ContentArea.BackgroundTransparency = 1

_G.Pages = {}
local MenuButtons = {}
local tabs = {
    {eng = "Home", arb = "الرئيسية"}, {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"}, {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "انيمشنات"}, {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الاخبار"}
}

_G.SelectTab = function(index)
    for i, page in ipairs(_G.Pages) do
        page.Visible = (i == index)
        if MenuButtons[i] then
            if i == index then
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MenuButtons[i].TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                MenuButtons[i].TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
    end
end

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = tab.eng .. " | " .. tab.arb
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    MenuButtons[i] = btn
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Name = tab.eng .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450)
    page.ScrollBarThickness = 4
    page.Visible = false
    _G.Pages[i] = page
    
    btn.MouseButton1Click:Connect(function() _G.SelectTab(i) end)
end

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.BorderColor3 = Color3.fromRGB(150, 0, 0)
ToggleButton.BorderSizePixel = 2
ToggleButton.Text = "VR7"
ToggleButton.TextColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

print("الجزء الأول جاهز!")
-- [[ سكريبت أيهم - الجزء الثاني: تصميم عناصر صفحة اللاعب من الصورة ]]
if not _G.AihamMenuLoaded then print("يرجى تشغيل الجزء الأول أولاً!") return end

local CharPage = _G.Pages[3] -- صفحة اللاعب رقم 3
CharPage.CanvasSize = UDim2.new(0, 0, 0, 520) -- توسيع مساحة التمرير لتكفي كل الأزرار

-- دالتين لتصميم الأزرار والخانات بشكل مطابق للصورة باللون الأصفر والرمادي الداكن
local function createRowWithInput(text, placeholder, yPos)
    local btn = Instance.new("TextButton", CharPage)
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = UDim2.new(0.03, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15

    local box = Instance.new("TextBox", CharPage)
    box.Size = UDim2.new(0.45, 0, 0, 35)
    box.Position = UDim2.new(0.52, 0, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    return btn, box
end

local function createNormalBtn(text, xPos, yPos)
    local btn = Instance.new("TextButton", CharPage)
    btn.Size = UDim2.new(0.45, 0, 0, 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 150, 20)
    btn.BorderSizePixel = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    return btn
end

-- الأسطر الثلاثة الأولى (أزرار مع خانات أرقام)
_G.WSBtn, _G.WSBox = createRowWithInput("السرعه | Ws", "Number [1-99999]", 15)
_G.JumpBtn, _G.JumpBox = createRowWithInput("النط | Jump", "Number [1-99999]", 55)
_G.FlySpeedBtn, _G.FlySpeedBox = createRowWithInput("سرعه الطيران", "Number [1-99999]", 95)

-- بقية الأزرار العادية موزعة على عمودين (يمين ويسار) مثل الصورة
_G.FlyBtn = createNormalBtn("سكربت طيران", 0.03, 145)
_G.CheckSaveBtn = createNormalBtn("حفظ الشيك بوينت", 0.52, 145)

_G.NoclipBtn = createNormalBtn("اختراق جدران", 0.03, 190)
_G.CheckTPBtn = createNormalBtn("انتقال للشيك بوينت", 0.52, 190)

_G.InvisBtn = createNormalBtn("اختفاء", 0.03, 235)
_G.CheckRemoveBtn = createNormalBtn("ازاله الشيك بوينت", 0.52, 235)

_G.InfJumpBtn = createNormalBtn("قفز لانهائى", 0.03, 280)
_G.TPToolBtn = createNormalBtn("اداة الانتقال", 0.52, 280)

_G.SelectTab(3)
print("الجزء الثاني (قائمة اللاعب من الصورة) جاهز!")
-- [[ سكريبت أيهم - الجزء الثالث: تشغيل وبرمجة ميزات اللاعب كاملة ]]
if not _G.WSBtn then print("يرجى تشغيل الجزء الثاني أولاً!") return end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = Player:GetMouse()

-- متغيرات تتبع الحالة للميزات المفعلة
local noclip = false
local infJump = false
local flying = false
local invisible = false
local savedCheckpoint = nil
local flySpeed = 50

-- دالة للحصول على الكاركتر الحالي للاعب
local function getChar() return Player.Character or Player.CharacterAdded:Wait() end

-- 1. تفعيل وتغيير السرعة
_G.WSBtn.MouseButton1Click:Connect(function()
    local num = tonumber(_G.WSBox.Text) or 16
    local char = getChar()
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = num
    end
end)

-- 2. تفعيل وتغيير قوة القفز
_G.JumpBtn.MouseButton1Click:Connect(function()
    local num = tonumber(_G.JumpBox.Text) or 50
    local char = getChar()
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = num
        char.Humanoid.UseJumpPower = true
    end
end)

-- 3. ضبط سرعة الطيران من الخانة
_G.FlySpeedBtn.MouseButton1Click:Connect(function()
    flySpeed = tonumber(_G.FlySpeedBox.Text) or 50
end)

-- 4. سكربت الطيران (Fly)
_G.FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    _G.FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    
    local char = getChar()
    local torso = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not torso then return end
    
    if flying then
        local bv = Instance.new("BodyVelocity", torso)
        bv.Name = "AihamFlyForce"
        bv.maxForce = Vector3.new(0,0,0)
        bv.velocity = Vector3.new(0,0,0)
        
        task.spawn(function()
            while flying and char and torso and torso.Parent do
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                local cam = workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new(0,0,0)
                
                -- التحكم عبر الكاميرا أو التوجيه التلقائي المبسط
                bv.velocity = cam.LookVector * flySpeed
                task.wait()
            end
            if bv then bv:Destroy() end
        end)
    end
end)

-- 5. اختراق الجدران (Noclip)
_G.NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    _G.NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
end)
RunService.Stepped:Connect(function()
    if noclip then
        local char = Player.Character
        if char then
            for _, child in pairs(char:GetDescendants()) do
                if child:IsA("BasePart") then child.CanCollide = false end
            end
        end
    end
end)

-- 6. القفز اللانهائي (Inf Jump)
_G.InfJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    _G.InfJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
end)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump then
        local char = Player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
end)

-- 7. ميزة الاختفاء النظيف (Invis)
_G.InvisBtn.MouseButton1Click:Connect(function()
    invisible = not invisible
    _G.InvisBtn.BackgroundColor3 = invisible and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 150, 20)
    local char = getChar()
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = invisible and 1 or 0
            end
        end
    end
end)

-- 8. حفظ الشيك بوينت الحالي
_G.CheckSaveBtn.MouseButton1Click:Connect(function()
    local char = getChar()
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCheckpoint = char.HumanoidRootPart.CFrame
        print("[الشيك بوينت]: تم حفظ موقعك الحالي بنجاح!")
    end
end)

-- 9. الانتقال للشيك بوينت المحفوظ
_G.CheckTPBtn.MouseButton1Click:Connect(function()
    if savedCheckpoint then
        local char = getChar()
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = savedCheckpoint
        end
    else
        print("[الشيك بوينت]: لا يوجد موقع محفوظ للانتقال إليه!")
    end
end)

-- 10. إزالة الشيك بوينت المحفوظ
_G.CheckRemoveBtn.MouseButton1Click:Connect(function()
    savedCheckpoint = nil
    print("[الشيك بوينت]: تم مسح الموقع المحفوظ.")
end)

-- 11. إعطاء أداة الانتقال (Click TP Tool)
_G.TPToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "اداة الانتقال"
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local pos = Mouse.Hit
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z)
        end
    end)
    tool.Parent = Player.Backpack
    print("[الأدوات]: تم إضافة أداة الانتقال لحقيبتك!")
end)

print("--- نسخة أيهم الأسطورية كاملة ومطابقة للصورة بنسبة 100% وجاهزة للتشغيل! ---")
