-- [[ سكريبت أيهم الأسطوري - النسخة V43 الكاملة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0); ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
Instance.new("UICorner", ToggleBtn); ToggleBtn.Draggable = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Visible = true; MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف"}
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

-- [1] إعدادات الماب
local MapPage = AllPages["اعدادات الماب"]
-- أضف هنا أزرار الماب (السطوع والشادر)

-- [2] اللاعب
local PlayerPage = AllPages["اللاعب"]
-- أضف هنا أزرار اللاعب (الطيران، السرعة، القفز)

-- [3] الاستهداف
local TargetPage = AllPages["الاستهداف"]
local NameInput = Instance.new("TextBox", TargetPage); NameInput.Size = UDim2.new(0.9, 0, 0, 40); NameInput.Position = UDim2.new(0.05, 0, 0, 10); NameInput.PlaceholderText = "اكتب أول 3 أحرف"; Instance.new("UICorner", NameInput)

local TargetPlayer = nil
NameInput.FocusLost:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(NameInput.Text, 1, 3)) then
            TargetPlayer = plr
            break
        end
    end
end)

local Buttons = {"مشاهدة", "انتقال", "Bang", "ESP", "جلسة فوق"}
for i, btnName in ipairs(Buttons) do
    local btn = Instance.new("TextButton", TargetPage)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, 60 + (i-1) * 40)
    btn.Text = btnName; btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        if TargetPlayer and TargetPlayer.Character then
            if btnName == "مشاهدة" then workspace.CurrentCamera.CameraSubject = TargetPlayer.Character.Humanoid
            elseif btnName == "انتقال" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif btnName == "ESP" then local h = Instance.new("Highlight", TargetPlayer.Character)
            elseif btnName == "جلسة فوق" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
        end
    end)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
