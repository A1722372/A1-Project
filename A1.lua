-- [[ سكريبت أيهم الأسطوري - النسخة المحدثة مع نظام المحفوظات ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

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
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

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
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- نظام المحفوظات (الخانة الخامسة)
local SavePage = AllPages["المحفوظات"]
local SaveInput = Instance.new("TextBox", SavePage); SaveInput.Size = UDim2.new(0.7, 0, 0, 40); SaveInput.Position = UDim2.new(0.05, 0, 0, 10); SaveInput.PlaceholderText = "اسم الموقع"; SaveInput.TextColor3 = Color3.fromRGB(255, 255, 255); SaveInput.BackgroundColor3 = Color3.fromRGB(40,40,40); Instance.new("UICorner", SaveInput)
local SaveBtn = Instance.new("TextButton", SavePage); SaveBtn.Size = UDim2.new(0.2, 0, 0, 40); SaveBtn.Position = UDim2.new(0.75, 0, 0, 10); SaveBtn.Text = "حفظ"; SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255); SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); Instance.new("UICorner", SaveBtn)
local SavedList = Instance.new("ScrollingFrame", SavePage); SavedList.Size = UDim2.new(0.9, 0, 1, -60); SavedList.Position = UDim2.new(0.05, 0, 0, 60); SavedList.BackgroundTransparency = 1

local SavedLocations = {} -- يحفظ المواقع

SaveBtn.MouseButton1Click:Connect(function()
    local name = SaveInput.Text
    if name ~= "" and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = Player.Character.HumanoidRootPart.CFrame
        SavedLocations[name] = pos
        local btn = Instance.new("TextButton", SavedList); btn.Size = UDim2.new(1, 0, 0, 40); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(60,60,60); Instance.new("UICorner", btn)
        local del = Instance.new("TextButton", btn); del.Size = UDim2.new(0, 30, 1, 0); del.Position = UDim2.new(1, -30, 0, 0); del.Text = "X"; del.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Instance.new("UICorner", del)
        btn.MouseButton1Click:Connect(function() Player.Character.HumanoidRootPart.CFrame = SavedLocations[name] end)
        del.MouseButton1Click:Connect(function() SavedLocations[name] = nil; btn:Destroy() end)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
