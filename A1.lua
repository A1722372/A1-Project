-- [[ سكريبت أيهم الأسطوري - النسخة الكاملة V5.0 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AihamSuperMenu"; ScreenGui.ResetOnSpawn = false; ScreenGui.Parent = PlayerGui

-- واجهة القائمة
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); MainFrame.Active = true; MainFrame.Draggable = true

local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 100, 1, 0); SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -100, 1, 0); ContentArea.Position = UDim2.new(0, 100, 0, 0); ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"عام", "لاعب", "استهداف", "حفظ", "أنيميشن"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(1, 0, 0, 40); btn.Position = UDim2.new(0, 0, 0, (i-1)*40)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = (i==1)
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- كود تبويب الأنيميشن (النسخة 5.0)
local AnimPage = Pages[5]
local function createAnimBtn(name, id)
    local b = Instance.new("TextButton", AnimPage)
    b.Size = UDim2.new(0.9, 0, 0, 30); b.Position = UDim2.new(0.05, 0, 0, (#AnimPage:GetChildren()-1)*35)
    b.Text = name; b.MouseButton1Click:Connect(function()
        local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if h then local a = Instance.new("Animation"); a.AnimationId = "rbxassetid://"..id; h:LoadAnimation(a):Play() end
    end)
end

createAnimBtn("رقصة 1", 507750864)
createAnimBtn("رقصة 2", 507751034)
createAnimBtn("ضحك", 507749043)
createAnimBtn("إيقاف", 0)

-- زر إغلاق القائمة
local Close = Instance.new("TextButton", MainFrame)
Close.Size = UDim2.new(0, 30, 0, 30); Close.Position = UDim2.new(1, -30, 0, 0); Close.Text = "X"
Close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
