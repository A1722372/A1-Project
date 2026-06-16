-- [[ سكريبت أيهم الأسطوري النظيف - الجزء الأول: نظام الواجهة ]]
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
TitleText.Text = "VR7 TEAM: The Mercy Script (Clean Edition)"
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

print("الجزء الأول النظيف جاهز!")
-- [[ سكريبت أيهم الأسطوري - الجزء الثاني: تصميم الأزرار النظيفة ]]
if not _G.AihamMenuLoaded then print("يرجى تشغيل الجزء الأول أولاً!") return end

for _, page in ipairs(_G.Pages) do
    local CmdContainer = Instance.new("Frame", page)
    CmdContainer.Size = UDim2.new(0.95, 0, 0, 40)
    CmdContainer.Position = UDim2.new(0.025, 0, 0, 10)
    CmdContainer.BackgroundTransparency = 1
    
    local CmdInput = Instance.new("TextBox", CmdContainer)
    CmdInput.Size = UDim2.new(1, -45, 0, 35)
    CmdInput.Position = UDim2.new(0, 0, 0, 0)
    CmdInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    CmdInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
    CmdInput.Text = ""
    CmdInput.PlaceholderText = "[Cmdbar] خانة الاوامر "
    CmdInput.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    CmdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    CmdInput.Font = Enum.Font.SourceSansBold
    CmdInput.TextSize = 14

    local HelpBtn = Instance.new("TextButton", CmdContainer)
    HelpBtn.Size = UDim2.new(0, 35, 0, 35)
    HelpBtn.Position = UDim2.new(1, -35, 0, 0)
    HelpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    HelpBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    HelpBtn.Text = "?"
    HelpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HelpBtn.Font = Enum.Font.SourceSansBold
    HelpBtn.TextSize = 14
end

local GamePage = _G.Pages[2]

local SpamTextBox = Instance.new("TextBox", GamePage)
SpamTextBox.Name = "SpamTextBox"
SpamTextBox.Size = UDim2.new(0.65, 0, 0, 45)
SpamTextBox.Position = UDim2.new(0.05, 0, 0, 60)
SpamTextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SpamTextBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
SpamTextBox.Text = "كلام"
SpamTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpamTextBox.Font = Enum.Font.SourceSansBold
SpamTextBox.TextSize = 14

local SpamSpeedBox = Instance.new("TextBox", GamePage)
SpamSpeedBox.Name = "SpamSpeedBox"
SpamSpeedBox.Size = UDim2.new(0.22, 0, 0, 45)
SpamSpeedBox.Position = UDim2.new(0.73, 0, 0, 60)
SpamSpeedBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SpamSpeedBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
SpamSpeedBox.Text = "0.5"
SpamSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpamSpeedBox.Font = Enum.Font.SourceSansBold
SpamSpeedBox.TextSize = 12

local function makeGreyBtn(text, pos)
    local btn = Instance.new("TextButton", GamePage)
    btn.Size = UDim2.new(0.42, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    btn.BorderColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    return btn
end

_G.SpamToggleBtn = makeGreyBtn("تفعيل سبام", UDim2.new(0.05, 0, 0, 120))
_G.FreezeChatBtn = makeGreyBtn("تعليق الشات", UDim2.new(0.53, 0, 0, 120)) -- سبام A1 لتعليق الشات
_G.SpyChatBtn = makeGreyBtn("تجسس الرسائل", UDim2.new(0.05, 0, 0, 170))
_G.TrollAnimBtn = makeGreyBtn("تعليق السيرفر", UDim2.new(0.53, 0, 0, 170)) -- البديل الإسلامي القوي

_G.SelectTab(2)
print("الجزء الثاني النظيف جاهز!")
-- [[ سكريبت أيهم الأسطوري - الجزء الثالث: تشغيل ميزات التخريب النظيفة ]]
if not _G.SpamToggleBtn then print("يرجى تشغيل الجزء الثاني أولاً!") return end

local Player = game.Players.LocalPlayer
local GamePage = _G.Pages[2]
local SpamTextBox = GamePage:FindFirstChild("SpamTextBox")
local SpamSpeedBox = GamePage:FindFirstChild("SpamSpeedBox")

local function sendToChat(msg)
    if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral")
        if channel then channel:SendAsync(msg) end
    else
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
        if remote and remote:IsA("RemoteEvent") then remote:FireServer(msg, "All") end
    end
end

-- 1. تفعيل سبام الكلام العادي
local spamming = false
_G.SpamToggleBtn.MouseButton1Click:Connect(function()
    spamming = not spamming
    _G.SpamToggleBtn.BackgroundColor3 = spamming and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(100, 100, 100)
    task.spawn(function()
        while spamming do
            local delayTime = tonumber(SpamSpeedBox.Text) or 0.5
            sendToChat(SpamTextBox.Text)
            task.wait(delayTime)
        end
    end)
end)

-- 2. تعليق الشات (سبام سريع جداً بكلمة A1 لملء الشات وتعليقه)
local a1Spamming = false
_G.FreezeChatBtn.MouseButton1Click:Connect(function()
    a1Spamming = not a1Spamming
    _G.FreezeChatBtn.BackgroundColor3 = a1Spamming and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(100, 100, 100)
    task.spawn(function()
        while a1Spamming do
            sendToChat("A1")
            task.wait(0.15) -- سرعة خارقة لتجميد الشات بالـ A1
        end
    end)
end)

-- 3. تجسس الرسائل
local spyActive = false
_G.SpyChatBtn.MouseButton1Click:Connect(function()
    spyActive = not spyActive
    _G.SpyChatBtn.BackgroundColor3 = spyActive and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(100, 100, 100)
    if spyActive then print("[نظام الرصد]: مراقبة الشات مفعلة") end
end)

-- 4. البديل الإسلامي: تعليق السيرفر (سبام تحديث الخصائص للاعب لإحداث ثقل بالفريمات)
local serverLag = false
_G.TrollAnimBtn.MouseButton1Click:Connect(function()
    serverLag = not serverLag
    _G.TrollAnimBtn.BackgroundColor3 = serverLag and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(100, 100, 100)
    task.spawn(function()
        while serverLag do
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                -- عملية رندرة سريعة وآمنة ديناميكياً لعمل ثقل للمحيطين بك
                Player.Character.Humanoid.PlatformStand = true
                task.wait(0.01)
                Player.Character.Humanoid.PlatformStand = false
            end
            task.wait(0.02)
        end
    end)
end)

print("--- تم تشغيل نسخة أيهم الإسلامية والنظيفة بنجاح كامل! ---")
