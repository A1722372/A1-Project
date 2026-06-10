-- [[ سكريبت أيهم الأسطوري - النسخة V48 (التثبيت الجذري لكل خانة) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0); ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
Instance.new("UICorner", ToggleBtn); ToggleBtn.Draggable = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0); SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0); ContentArea.Position = UDim2.new(0, 120, 0, 0); ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [1] الخانة الأولى (شغالة)
local MapPage = AllPages["اعدادات الماب"]
local SBtn = Instance.new("TextButton", MapPage); SBtn.Size = UDim2.new(0.9, 0, 0, 40); SBtn.Position = UDim2.new(0.05, 0, 0, 10); SBtn.Text = "تفعيل الشادر"; SBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", SBtn)
SBtn.MouseButton1Click:Connect(function() Lighting.Brightness = 3; Lighting.ClockTime = 12 end)

-- [2] الخانة الثانية (شغالة)
local PlayerPage = AllPages["اللاعب"]
local FBtn = Instance.new("TextButton", PlayerPage); FBtn.Size = UDim2.new(0.9, 0, 0, 40); FBtn.Position = UDim2.new(0.05, 0, 0, 10); FBtn.Text = "تفعيل الطيران"; FBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200); Instance.new("UICorner", FBtn)
FBtn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

-- [3] الخانة الثالثة (الاستهداف - منفصلة تماماً)
local TargetPage = AllPages["الاستهداف"]
local TInput = Instance.new("TextBox", TargetPage); TInput.Size = UDim2.new(0.9, 0, 0, 40); TInput.Position = UDim2.new(0.05, 0, 0, 10); TInput.PlaceholderText = "أول 3 حروف"; TInput.BackgroundColor3 = Color3.fromRGB(40,40,40); Instance.new("UICorner", TInput)
local TargetPlayer = nil
TInput.FocusLost:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(TInput.Text, 1, 3)) then
            TargetPlayer = plr; break
        end
    end
end)

local BNames = {"مشاهدة", "انتقال", "Bang", "ESP", "جلسة فوق"}
for i, bName in ipairs(BNames) do
    local b = Instance.new("TextButton", TargetPage); b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = UDim2.new(0.05, 0, 0, 60 + (i-1) * 40); b.Text = bName; b.BackgroundColor3 = Color3.fromRGB(60,60,60); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        if TargetPlayer and TargetPlayer.Character then
            if bName == "مشاهدة" then workspace.CurrentCamera.CameraSubject = TargetPlayer.Character.Humanoid
            elseif bName == "انتقال" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif bName == "ESP" then Instance.new("Highlight", TargetPlayer.Character)
            elseif bName == "جلسة فوق" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
        end
    end)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
