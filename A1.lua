-- [[ سكريبت أيهم الأسطوري - النسخة النهائية المخصصة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui); ScreenGui.Name = "AihamScript_Main"
local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 400, 0, 350); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175); MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Active = true; MainFrame.Draggable = true; Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame); SideMenu.Size = UDim2.new(0, 120, 1, 0); SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local ContentArea = Instance.new("Frame", MainFrame); ContentArea.Size = UDim2.new(1, -120, 1, 0); ContentArea.Position = UDim2.new(0, 120, 0, 0); ContentArea.BackgroundTransparency = 1
local AllPages = {}

for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu); btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea); page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = (i == 1); AllPages[name] = page
    btn.MouseButton1Click:Connect(function() for _, p in pairs(AllPages) do p.Visible = false end; page.Visible = true end)
end

-- [1] الخانة الأولى: الماب
local MapPage = AllPages["اعدادات الماب"]
Instance.new("TextButton", MapPage).Text = "تغيير لون السكريبت"; -- أضف كود التغيير هنا
Instance.new("TextButton", MapPage).Text = "تفعيل الشادر"; -- أضف كود الشادر هنا
local Info = Instance.new("TextBox", MapPage); Info.Size = UDim2.new(0.9, 0, 0, 60); Info.Position = UDim2.new(0.05, 0, 0, 100); Info.Text = "تم صنعه من قبل انكسام \n ديسكورد: [رابطك هنا]"

-- [2] الخانة الثانية: اللاعب
local PlayerPage = AllPages["اللاعب"]
-- أزرار: السرعة، قوة النط، قفز لا نهائي، اختراق الجدران، طيران
local function AddPBtn(txt, func) local b = Instance.new("TextButton", PlayerPage); b.Size = UDim2.new(0.9, 0, 0, 35); b.Text = txt; b.Position = UDim2.new(0.05, 0, 0, #PlayerPage:GetChildren() * 40); b.MouseButton1Click:Connect(func) end
AddPBtn("سرعة: 100", function() Player.Character.Humanoid.WalkSpeed = 100 end)
AddPBtn("قفز: 100", function() Player.Character.Humanoid.JumpPower = 100 end)
AddPBtn("قفز لا نهائي", function() -- كود القفز اللانهائي
end)
AddPBtn("اختراق الجدران", function() -- كود النوكليب
end)
AddPBtn("طيران", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

-- [3] الخانة الثالثة: الاستهداف (كما طلبت سابقاً)
local TargetPage = AllPages["الاستهداف"]
-- (نفس أكواد الاستهداف السابقة التي تحتاج تعديل)
