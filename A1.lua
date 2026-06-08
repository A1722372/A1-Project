-- [[ سكريبت أيهم الأسطوري V12 - المدمج بالكامل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

local function startFlying()
    local torso = Player.Character and (Player.Character:FindFirstChild("UpperTorso") or Player.Character:FindFirstChild("HumanoidRootPart"))
    if not torso then return end
    local bodyVelocity = Instance.new("BodyVelocity", torso)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    local bodyGyro = Instance.new("BodyGyro", torso)
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.CFrame = torso.CFrame
    RunService.RenderStepped:Connect(function()
        if Player.Character and torso then
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            local moveDirection = Player.Character.Humanoid.MoveDirection
            local velocity = moveDirection * 70
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 50, 0)
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity + Vector3.new(0, -50, 0) end
            bodyVelocity.Velocity = velocity
        end
    end)
end
startFlying()

local savedLocations = {}
local rainbowConnection
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    if mode == "Red" then MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    elseif mode == "Yellow" then MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
    elseif mode == "Blue" then MainFrame.BorderColor3 = Color3.fromRGB(0, 100, 255)
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        end)
    end
end
setBorderColor("Yellow")

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22 ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.TextSize = 16 Title.Font = Enum.Font.SourceSansBold

local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات", "الصناديق"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0) btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 13
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450) page.ScrollBarThickness = 5
    page.Visible = (i == 1) Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- === [ الأزرار الأربعة في شريحة الصناديق (6) ] ===
local ChestPage = Pages[6]
local chestData = {
    {name = "TE1", pos = CFrame.new(364.75, 72.27, -2792.82)},
    {name = "TE2", pos = CFrame.new(-87.30, 72.99, -2713.92)},
    {name = "TE3", pos = CFrame.new(-391.09, 72.99, -2659.82)},
    {name = "Green", pos = CFrame.new(-213.54, 73.27, -2343.59)}
}

for i, data in ipairs(chestData) do
    local btn = Instance.new("TextButton", ChestPage)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 10)
    btn.Text = data.name
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = data.pos
        end
    end)
end

local CloseBtn = Instance.new("TextButton", MainFrame) 
CloseBtn.Size = UDim2.new(0, 25, 0, 25) 
CloseBtn.Position = UDim2.new(1, -28, 0, 4) 
CloseBtn.Text = "X" 
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) 
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
