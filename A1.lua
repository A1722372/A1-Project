-- [تبويب الاستهداف]
local TargetPage = AllPages["الاستهداف"]

-- خانة البحث (أول 3 أحرف)
local NameInput = Instance.new("TextBox", TargetPage); NameInput.Size = UDim2.new(0.9, 0, 0, 40); NameInput.Position = UDim2.new(0.05, 0, 0, 10); NameInput.PlaceholderText = "اكتب أول 3 أحرف من اسم اللاعب"; Instance.new("UICorner", NameInput)

-- لعرض صورة السكن (ImageLabel)
local SkinDisplay = Instance.new("ImageLabel", TargetPage); SkinDisplay.Size = UDim2.new(0.4, 0, 0, 80); SkinDisplay.Position = UDim2.new(0.3, 0, 0, 60); SkinDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", SkinDisplay)

-- دالة البحث عن اللاعب
local TargetPlayer = nil
NameInput.FocusLost:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(NameInput.Text, 1, 3)) then
            TargetPlayer = plr
            SkinDisplay.Image = "rbxthumb://type=Avatar&id="..plr.UserId.."&w=420&h=420"
            break
        end
    end
end)

-- الأزرار الخمسة
local Buttons = {"مشاهدة", "انتقال", "Bang", "ESP", "جلسة فوق"}
for i, btnName in ipairs(Buttons) do
    local btn = Instance.new("TextButton", TargetPage)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 150 + (i-1) * 40)
    btn.Text = btnName
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        if not TargetPlayer or not TargetPlayer.Character then return end
        if btnName == "مشاهدة" then workspace.CurrentCamera.CameraSubject = TargetPlayer.Character.Humanoid
        elseif btnName == "انتقال" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
        elseif btnName == "Bang" then -- (يمكن إضافة حركة الـ Bang هنا)
        elseif btnName == "ESP" then -- (تفعيل الـ Highlight للهدف)
            local h = Instance.new("Highlight", TargetPlayer.Character)
        elseif btnName == "جلسة فوق" then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
        end
    end)
end
