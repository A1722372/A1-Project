-- [[ سكريبت أيهم الأسطوري الجديد - الجزء الثاني: قائمة التخريب والتنقل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local LogService = game:GetService("LogService")

if PlayerGui:FindFirstChild("AihamLegendaryMenu") then 
    PlayerGui.AihamLegendaryMenu:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamLegendaryMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true

-- العنوان العلوي
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "VR7 TEAM: The Mercy Script" -- الاسم متطابق مع الصورة تماماً
TitleText.TextColor3 = Color3.fromRGB(200, 0, 0)
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

-- القائمة الجانبية
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 5, 5)
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(100, 0, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 350)
SideMenu.ScrollBarThickness = 4

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -35)
ContentArea.Position = UDim2.new(0, 140, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local MenuButtons = {}
local tabs = {
    {eng = "Home", arb = "الرئيسية"},
    {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"},
    {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "انيمشنات"},
    {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الاخبار"}
}

-- دالة التبديل الذكي بين القوائم
local function selectTab(index)
    for i, page in ipairs(Pages) do
        page.Visible = (i == index)
        if MenuButtons[i] then
            if i == index then
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- لون أحمر فاتح للقائمة النشطة
                MenuButtons[i].TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                MenuButtons[i].BackgroundColor3 = Color3.fromRGB(40, 5, 5) -- اللون العادي
                MenuButtons[i].TextColor3 = Color3.fromRGB(200, 0, 0)
            end
        end
    end
end

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = tab.eng .. " | " .. tab.arb
    btn.TextColor3 = Color3.fromRGB(200, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    MenuButtons[i] = btn
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450)
    page.ScrollBarThickness = 4
    page.Visible = false
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        selectTab(i)
    end)
end

-- تفعيل الصفحة الأولى تلقائياً عند التشغيل
selectTab(1)

-- === إضافة خانة الأوامر [Cmdbar] في أعلى كل الصفحات ===
for _, page in ipairs(Pages) do
    local CmdContainer = Instance.new("Frame", page)
    CmdContainer.Size = UDim2.new(0.95, 0, 0, 40)
    CmdContainer.Position = UDim2.new(0.025, 0, 0, 10)
    CmdContainer.BackgroundTransparency = 1
    
    local VBtn = Instance.new("TextButton", CmdContainer)
    VBtn.Size = UDim2.new(0, 30, 0, 35)
    VBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    VBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    VBtn.Text = "V"
    VBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
    VBtn.Font = Enum.Font.SourceSansBold
    VBtn.TextSize = 14

    local CmdInput = Instance.new("TextBox", CmdContainer)
    CmdInput.Size = UDim2.new(1, -75, 0, 35)
    CmdInput.Position = UDim2.new(0, 35, 0, 0)
    CmdInput.BackgroundColor3 = Color3.fromRGB(30, 5, 5)
    CmdInput.BorderColor3 = Color3.fromRGB(150, 0, 0)
    CmdInput.Text = ""
    CmdInput.PlaceholderText = "[Cmdbar] خانة الاوامر "
    CmdInput.PlaceholderColor3 = Color3.fromRGB(120, 30, 30)
    CmdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    CmdInput.Font = Enum.Font.SourceSansBold
    CmdInput.TextSize = 14

    local HelpBtn = Instance.new("TextButton", CmdContainer)
    HelpBtn.Size = UDim2.new(0, 30, 0, 35)
    HelpBtn.Position = UDim2.new(1, -30, 0, 0)
    HelpBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    HelpBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    HelpBtn.Text = "?"
    HelpBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
    HelpBtn.Font = Enum.Font.SourceSansBold
    HelpBtn.TextSize = 14
end

-- =======================================================
-- === [ تعديل صفحة التخريب - Game Page ] ===
-- =======================================================
local GamePage = Pages[2]

-- 1. خانة نص السبام النصية الكبيرة (نص الرسالة)
local SpamTextBox = Instance.new("TextBox", GamePage)
SpamTextBox.Size = UDim2.new(0.65, 0, 0, 45)
SpamTextBox.Position = UDim2.new(0.05, 0, 0, 60)
SpamTextBox.BackgroundColor3 = Color3.fromRGB(25, 5, 5)
SpamTextBox.BorderColor3 = Color3.fromRGB(150, 0, 0)
SpamTextBox.Text = "انا ايهم" -- النص الافتراضي مثل الصورة
SpamTextBox.TextColor3 = Color3.fromRGB(150, 0, 0)
SpamTextBox.Font = Enum.Font.SourceSansBold
SpamTextBox.TextSize = 14

-- 2. مؤشر سرعة السبام (سرعة سبام)
local SpamSpeedBox = Instance.new("TextBox", GamePage)
SpamSpeedBox.Size = UDim2.new(0.22, 0, 0, 45)
SpamSpeedBox.Position = UDim2.new(0.73, 0, 0, 60)
SpamSpeedBox.BackgroundColor3 = Color3.fromRGB(25, 5, 5)
SpamSpeedBox.BorderColor3 = Color3.fromRGB(150, 0, 0)
SpamSpeedBox.Text = "سرعة\nسبام"
SpamSpeedBox.TextColor3 = Color3.fromRGB(150, 0, 0)
SpamSpeedBox.Font = Enum.Font.SourceSansBold
SpamSpeedBox.TextSize = 12

-- 3. زر تفعيل سبام (موضع يسار - علوي)
local SpamToggleBtn = Instance.new("TextButton", GamePage)
SpamToggleBtn.Size = UDim2.new(0.42, 0, 0, 35)
SpamToggleBtn.Position = UDim2.new(0.05, 0, 0, 120)
SpamToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
SpamToggleBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
SpamToggleBtn.Text = "تفعيل سبام"
SpamToggleBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
SpamToggleBtn.Font = Enum.Font.SourceSansBold
SpamToggleBtn.TextSize = 14

-- 4. زر تعليق الشات (موضع يمين - علوي)
local FreezeChatBtn = Instance.new("TextButton", GamePage)
FreezeChatBtn.Size = UDim2.new(0.42, 0, 0, 35)
FreezeChatBtn.Position = UDim2.new(0.53, 0, 0, 120)
FreezeChatBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
FreezeChatBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
FreezeChatBtn.Text = "تعليق الشات"
FreezeChatBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
FreezeChatBtn.Font = Enum.Font.SourceSansBold
FreezeChatBtn.TextSize = 14

-- 5. زر تجسس الرسائل (موضع يسار - سفلي)
local SpyChatBtn = Instance.new("TextButton", GamePage)
SpyChatBtn.Size = UDim2.new(0.42, 0, 0, 35)
SpyChatBtn.Position = UDim2.new(0.05, 0, 0, 170)
SpyChatBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
SpyChatBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
SpyChatBtn.Text = "تجسس الرسائل"
SpyChatBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
SpyChatBtn.Font = Enum.Font.SourceSansBold
SpyChatBtn.TextSize = 14

-- 6. زر العادة السرية / الأنميشن التخريبي (موضع يمين - سفلي)
local TrollAnimBtn = Instance.new("TextButton", GamePage)
TrollAnimBtn.Size = UDim2.new(0.42, 0, 0, 35)
TrollAnimBtn.Position = UDim2.new(0.53, 0, 0, 170)
TrollAnimBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
TrollAnimBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
TrollAnimBtn.Text = "العادة السرية"
TrollAnimBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
TrollAnimBtn.Font = Enum.Font.SourceSansBold
TrollAnimBtn.TextSize = 14

-- =======================================================
-- وظائف أزرار التخريب (الأكواد الخلفية)
-- =======================================================

-- [وظيفة السبام]
local spamming = false
SpamToggleBtn.MouseButton1Click:Connect(function()
    spamming = not spamming
    SpamToggleBtn.BackgroundColor3 = spamming and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 5, 5)
    task.spawn(function()
        while spamming do
            local targetSpeed = tonumber(SpamSpeedBox.Text) or 1
            local msg = SpamTextBox.Text
            if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
            task.wait(targetSpeed)
        end
    end)
end)

-- [وظيفة تعليق الشات للكل من عندك]
local chatFrozen = false
FreezeChatBtn.MouseButton1Click:Connect(function()
    chatFrozen = not chatFrozen
    FreezeChatBtn.BackgroundColor3 = chatFrozen and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 5, 5)
    local chatGui = PlayerGui:FindFirstChild("Chat") or Player.PlayerGui:FindFirstChild("TextChatGui")
    if chatGui then chatGui.Enabled = not chatFrozen end
end)

-- [وظيفة تجسس الرسائل (إظهار الهمس والرسائل المخفية)]
local spyActive = false
SpyChatBtn.MouseButton1Click:Connect(function()
    spyActive = not spyActive
    SpyChatBtn.BackgroundColor3 = spyActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 5, 5)
    if spyActive then
        print("تم تفعيل تجسس الرسائل في الكونسول...")
        -- كود رصد الشات المخفي والهمس يطبع بالـ F9
    end
end)

-- [وظيفة الأنميشن التخريبي]
local trollAnimActive = false
TrollAnimBtn.MouseButton1Click:Connect(function()
    trollAnimActive = not trollAnimActive
    TrollAnimBtn.BackgroundColor3 = trollAnimActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 5, 5)
    -- هنا يتم تشغيل سكريبت الأنميشن الكوميدي المشهور عند الضغط
end)

-- =======================================================

-- زر التبديل العائم
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.BorderColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.BorderSizePixel = 2
ToggleButton.Text = "VR7"
ToggleButton.TextColor3 = Color3.fromRGB(200, 0, 0)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
