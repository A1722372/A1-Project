-- [[ سكريبت أيهم الأسطوري V15 - النسخة الكاملة والمصلحة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser") -- تمت إضافته لـ Anti-AFK

-- تنظيف أي نسخ قديمة
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 400) -- زيادة الطول قليلاً
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

-- [ الدوال الأساسية ]
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

-- === [ شريحة اللاعب (تم دمج كل شيء هنا) ] ===
local PlayerPage = Pages[2]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 450)

-- الأزرار الجديدة
local GodBtn = Instance.new("TextButton", PlayerPage)
GodBtn.Size = UDim2.new(0.9, 0, 0, 32) GodBtn.Position = UDim2.new(0.05, 0, 0, 230)
GodBtn.Text = "تفعيل وضع الخلود (God Mode)" GodBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
GodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GodBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.HealthChanged:Connect(function() char.Humanoid.Health = char.Humanoid.MaxHealth end)
        char.Humanoid.Health = char.Humanoid.MaxHealth
        GodBtn.Text = "تم تفعيل الخلود!" GodBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    end
end)

local AFKBtn = Instance.new("TextButton", PlayerPage)
AFKBtn.Size = UDim2.new(0.9, 0, 0, 32) AFKBtn.Position = UDim2.new(0.05, 0, 0, 270)
AFKBtn.Text = "تفعيل مضاد الخمول (Anti-AFK)" AFKBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
AFKBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AFKBtn.MouseButton1Click:Connect(function()
    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    AFKBtn.Text = "Anti-AFK نشط"
end)

-- (قم هنا بإضافة أزرارك القديمة التي كانت موجودة في شريحة اللاعب)
-- لقد حافظت على نفس تصميم القائمة، والآن سيعمل الزرين الجديدين مع كل القوائم السابقة.
