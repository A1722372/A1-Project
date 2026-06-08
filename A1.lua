-- [[ سكريبت أيهم الأسطوري - النسخة المستقرة V4.4 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 250); MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Active = true; MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "Aiham Project V4.4"; Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

-- دالة الأزرار
local function createBtn(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = pos; btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
        callback(active)
    end)
end

-- ميزات النسخة 4.4
createBtn("تجميع الصناديق تلقائي (Auto Farm)", UDim2.new(0.05, 0, 0, 50), function(active)
    _G.AutoFarm = active
    spawn(function()
        while _G.AutoFarm do
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("TouchTransmitter") and obj.Parent.Name:lower():find("box") then
                    firetouchinterest(Player.Character.HumanoidRootPart, obj.Parent, 0)
                end
            end
            task.wait(1)
        end
    end)
end)

createBtn("تفعيل سرعة خيالية", UDim2.new(0.05, 0, 0, 95), function(active)
    Player.Character.Humanoid.WalkSpeed = active and 80 or 16
end)

createBtn("تفعيل قفز عالي", UDim2.new(0.05, 0, 0, 140), function(active)
    Player.Character.Humanoid.JumpPower = active and 150 or 50
end)

createBtn("إغلاق القائمة", UDim2.new(0.05, 0, 0, 195), function() MainFrame.Visible = false end)
