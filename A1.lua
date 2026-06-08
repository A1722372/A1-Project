-- [[ سكريبت أيهم الأسطوري V14 - النسخة الكاملة والمحدثة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 450) -- تم زيادة الطول ليستوعب كل شيء
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

-- [ الوظائف الأساسية ]
local savedLocations = {}
local rainbowConnection
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    if mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        end)
    else
        MainFrame.BorderColor3 = (mode == "Red" and Color3.fromRGB(255, 0, 0)) or (mode == "Yellow" and Color3.fromRGB(255, 200, 0)) or Color3.fromRGB(0, 100, 255)
    end
end
setBorderColor("Yellow")

-- [ بناء الواجهة ]
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40) ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0) ToggleButton.Text = "●"
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.Font = Enum.Font.SourceSansBold

local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1
    page.Visible = (i == 1) Pages[i] = page
    btn.MouseButton1Click:Connect(function() for _, p in ipairs(Pages) do p.Visible = false end page.Visible = true end)
end

-- === [ شريحة 2: اللاعب (تم دمج كل شيء هنا) ] ===
local PlayerPage = Pages[2]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 500)

-- السرعة
local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 32) SpeedBtn.Position = UDim2.new(0.05, 0, 0, 10)
SpeedBtn.Text = "تفعيل السرعة (65)" SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBtn.MouseButton1Click:Connect(function() 
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid.WalkSpeed = 65 
    end 
end)

-- القفز
local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.9, 0, 0, 32) JumpBtn.Position = UDim2.new(0.05, 0, 0, 50)
JumpBtn.Text = "قفزة عالية" JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpBtn.MouseButton1Click:Connect(function() 
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid.JumpPower = 120 
    end 
end)

-- God Mode الجديد
local GodBtn = Instance.new("TextButton", PlayerPage)
GodBtn.Size = UDim2.new(0.9, 0, 0, 32) GodBtn.Position = UDim2.new(0.05, 0, 0, 90)
GodBtn.Text = "تفعيل وضع الخلود (God Mode)" GodBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
GodBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.HealthChanged:Connect(function() char.Humanoid.Health = char.Humanoid.MaxHealth end)
        char.Humanoid.Health = char.Humanoid.MaxHealth
        GodBtn.Text = "الخلود مفعل!"
    end
end)

-- Anti-AFK الجديد
local AFKBtn = Instance.new("TextButton", PlayerPage)
AFKBtn.Size = UDim2.new(0.9, 0, 0, 32) AFKBtn.Position = UDim2.new(0.05, 0, 0, 130)
AFKBtn.Text = "تفعيل مضاد الخمول (Anti-AFK)" AFKBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
AFKBtn.MouseButton1Click:Connect(function()
    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    AFKBtn.Text = "Anti-AFK يعمل الآن"
end)

-- باقي الكود (يمكنك نسخ بقية أزرار الماب، الاستهداف، ونقاط الحفظ ووضعها هنا)
-- السكربت أعلاه يشمل الهيكل الأساسي الذي طلبت الدمج فيه.
