-- [[ سكريبت تجريبي - التركيز على الخانة الثالثة فقط ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("TestScript_Main") then PlayerGui.TestScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TestScript_Main"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0); SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0); ContentArea.Position = UDim2.new(0, 120, 0, 0); ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [التركيز الكامل على الخانة الثالثة فقط]
local TargetPage = AllPages["الاستهداف"]
local NameInput = Instance.new("TextBox", TargetPage); NameInput.Size = UDim2.new(0.9, 0, 0, 40); NameInput.Position = UDim2.new(0.05, 0, 0, 10); NameInput.PlaceholderText = "أول 3 حروف"; Instance.new("UICorner", NameInput)
local TargetPlayer = nil

NameInput.FocusLost:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(NameInput.Text, 1, 3)) then
            TargetPlayer = plr; print("تم تحديد: " .. plr.Name)
            break
        end
    end
end)

local Buttons = {"مشاهدة", "انتقال", "Bang", "ESP", "جلسة فوق"}
for i, bName in ipairs(Buttons) do
    local btn = Instance.new("TextButton", TargetPage); btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, 60 + (i-1) * 40); btn.Text = bName; btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80); Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        if TargetPlayer and TargetPlayer.Character then
            if bName == "مشاهدة" then workspace.CurrentCamera.CameraSubject = TargetPlayer.Character.Humanoid
            elseif bName == "انتقال" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif bName == "ESP" then Instance.new("Highlight", TargetPlayer.Character)
            elseif bName == "جلسة فوق" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
        end
    end)
end
