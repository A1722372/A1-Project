-- [[ سكريبت Anxam الأسطوري - النسخة V41.6 الأصلية المعدلة بالكامل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if not getgenv().AihamSavedPositions then getgenv().AihamSavedPositions = {} end

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 390) 
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0)
ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- تبويب الماب
local MapPage = AllPages["اعدادات الماب"]
MapPage.CanvasSize = UDim2.new(0, 0, 0, 430)
local FBButton = Instance.new("TextButton", MapPage); FBButton.Size = UDim2.new(0.9, 0, 0, 40); FBButton.Position = UDim2.new(0.05, 0, 0, 10); FBButton.Text = "السطوع: مطفأ"; FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", FBButton)
local FBEnabled = false; FBButton.MouseButton1Click:Connect(function() FBEnabled = not FBEnabled; Lighting.Ambient = FBEnabled and Color3.new(1,1,1) or Color3.new(0,0,0); FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"; FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)
local ShaderBtn = Instance.new("TextButton", MapPage); ShaderBtn.Size = UDim2.new(0.9, 0, 0, 40); ShaderBtn.Position = UDim2.new(0.05, 0, 0, 60); ShaderBtn.Text = "الشادر: مطفأ"; ShaderBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", ShaderBtn)
local ShaderEnabled = false; ShaderBtn.MouseButton1Click:Connect(function() ShaderEnabled = not ShaderEnabled; Lighting.Brightness = ShaderEnabled and 3 or 2; Lighting.ClockTime = ShaderEnabled and 12 or 14; ShaderBtn.Text = ShaderEnabled and "الشادر: شغال" or "الشادر: مطفأ"; ShaderBtn.BackgroundColor3 = ShaderEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)
local ThemeBtn = Instance.new("TextButton", MapPage); ThemeBtn.Size = UDim2.new(0.9, 0, 0, 40); ThemeBtn.Position = UDim2.new(0.05, 0, 0, 110); ThemeBtn.Text = "اللون: أسود"; ThemeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", ThemeBtn)
local Themes = {{Name="أسود", Color=Color3.fromRGB(20,20,20)}, {Name="أبيض", Color=Color3.fromRGB(200,200,200)}, {Name="أزرق", Color=Color3.fromRGB(0,50,100)}}; local currentTheme = 1; ThemeBtn.MouseButton1Click:Connect(function() currentTheme = currentTheme % #Themes + 1; local choice = Themes[currentTheme]; ThemeBtn.Text = "اللون: "..choice.Name; MainFrame.BackgroundColor3 = choice.Color; SideMenu.BackgroundColor3 = Color3.new(choice.Color.r*0.5, choice.Color.g*0.5, choice.Color.b*0.5) end)
local DiscordBtn = Instance.new("TextButton", MapPage); DiscordBtn.Size = UDim2.new(0.9, 0, 0, 40); DiscordBtn.Position = UDim2.new(0.05, 0, 0, 160); DiscordBtn.Text = "نسخ سيرفر الديسكورد"; DiscordBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", DiscordBtn); DiscordBtn.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/WrxQZDVps") end)

-- تبويب اللاعب
local PlayerPage = AllPages["اللاعب"]; PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 470)
local SpeedInput = Instance.new("TextBox", PlayerPage); SpeedInput.Size = UDim2.new(0.5, 0, 0, 40); SpeedInput.Position = UDim2.new(0.05, 0, 0, 10); SpeedInput.PlaceholderText = "السرعة"; Instance.new("UICorner", SpeedInput)
local SpeedBtn = Instance.new("TextButton", PlayerPage); SpeedBtn.Size = UDim2.new(0.35, 0, 0, 40); SpeedBtn.Position = UDim2.new(0.6, 0, 0, 10); SpeedBtn.Text = "تفعيل"; SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", SpeedBtn)
local SpeedEnabled = false; SpeedBtn.MouseButton1Click:Connect(function() SpeedEnabled = not SpeedEnabled; SpeedBtn.Text = SpeedEnabled and "مفعل" or "تفعيل"; SpeedBtn.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) end)
RunService.Heartbeat:Connect(function() if SpeedEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 end end)

-- تبويب الاستهداف (المعدل)
local TargetPage = AllPages["الاستهداف"]; TargetPage.CanvasSize = UDim2.new(0, 0, 0, 400)
local TInput = Instance.new("TextBox", TargetPage); TInput.Size = UDim2.new(0.9, 0, 0, 40); TInput.Position = UDim2.new(0.05, 0, 0, 10); TInput.PlaceholderText = "أول 3 حروف"; Instance.new("UICorner", TInput)
local TargetPlayer = nil
TInput.FocusLost:Connect(function() for _, plr in pairs(game.Players:GetPlayers()) do if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(TInput.Text, 1, 3)) then TargetPlayer = plr; break end end end)

local BNames = {"انتقال", "استهداف", "ESP", "جلوس فوق", "بانق وترف"}
for i, bName in ipairs(BNames) do
    local b = Instance.new("TextButton", TargetPage); b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = UDim2.new(0.05, 0, 0, 60 + (i-1) * 40); b.Text = bName .. " (OFF)"; b.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", b)
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = bName .. (state and " (ON)" or " (OFF)")
        b.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
        if bName == "بانق وترف" then
            spawn(function() while state and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") do Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.6, 0); task.wait(0.1); Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.6, 0); task.wait(0.1) end end)
        elseif TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if bName == "انتقال" and state then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif bName == "استهداف" then workspace.CurrentCamera.CameraSubject = state and TargetPlayer.Character.Humanoid or Player.Character.Humanoid
            elseif bName == "ESP" then if state and not TargetPlayer.Character:FindFirstChild("Highlight") then Instance.new("Highlight", TargetPlayer.Character) elseif not state and TargetPlayer.Character:FindFirstChild("Highlight") then TargetPlayer.Character.Highlight:Destroy() end
            elseif bName == "جلوس فوق" and state then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) end
        end
    end)
end

-- تبويب المحفوظات
local SavePage = AllPages["المحفوظات"]; local SaveInput = Instance.new("TextBox", SavePage); SaveInput.Size = UDim2.new(0.7, 0, 0, 40); SaveInput.Position = UDim2.new(0.05, 0, 0, 10); SaveInput.PlaceholderText = "اسم المكان"; Instance.new("UICorner", SaveInput)
local SaveBtn = Instance.new("TextButton", SavePage); SaveBtn.Size = UDim2.new(0.2, 0, 0, 40); SaveBtn.Position = UDim2.new(0.75, 0, 0, 10); SaveBtn.Text = "حفظ"; SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0); Instance.new("UICorner", SaveBtn)
SaveBtn.MouseButton1Click:Connect(function() if SaveInput.Text ~= "" and Player.Character:FindFirstChild("HumanoidRootPart") then getgenv().AihamSavedPositions[SaveInput.Text] = Player.Character.HumanoidRootPart.CFrame; SaveInput.Text = "" end end)

-- تبويب التأثيرات
local EffectsPage = AllPages["التأثيرات"]; local SpamInput = Instance.new("TextBox", EffectsPage); SpamInput.Size = UDim2.new(0.9, 0, 0, 40); SpamInput.Position = UDim2.new(0.05, 0, 0, 10); SpamInput.PlaceholderText = "اكتب النص هنا"; Instance.new("UICorner", SpamInput)
