-- Dynamic Jazz Music Player Script for Delta Executor
-- Created for A1 Script Hub / anxam
-- Simple and Clean Layout

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- منع تكرار الواجهة إذا تم تشغيل السكريبت أكثر من مرة
if CoreGui:FindFirstChild("A1_MusicTester") then
    CoreGui.A1_MusicTester:Destroy()
end

-- قائمة أغاني الجاز الأربعة الجاهزة للتجربة
local playlist = {
    {id = 184166541, name = "Classic Smooth Jazz"},
    {id = 184547960, name = "Retro Jazz Cafe"},
    {id = 184149065, name = "Upbeat Big Band Jazz"},
    {id = 183777595, name = "Elevator Jazz Style"}
}
local currentTrackIndex = 1

-- إنشاء كائن الصوت داخل كود اللعبة
local bgMusic = SoundService:FindFirstChild("A1_TestMusic")
if not bgMusic then
    bgMusic = Instance.new("Sound")
    bgMusic.Name = "A1_TestMusic"
    bgMusic.Volume = 0.6
    bgMusic.Looped = true
    bgMusic.Parent = SoundService
end

-- دالة تشغيل الأغنية بناءً على الترتيب
local function playTrack(index)
    local track = playlist[index]
    if track then
        bgMusic:Stop()
        bgMusic.SoundId = "rbxassetid://" .. track.id
        bgMusic:Play()
    end
end

-- بناء الواجهة برمائياً (ScreenGui) لضمان عملها على المحاكيات والـ Executors
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "A1_MusicTester"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- الهيكل الرئيسي (Main Frame) بستايل غامق وبسيط
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 150)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- تفعيل ميزة سحب اللوحة على الشاشة
MainFrame.Parent = ScreenGui

-- تنعيم حواف اللوحة
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- شريط العنوان العلوي (Top Bar)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "A1 Music Tester - anxam"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- زر الإغلاق الحمر (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 16
CloseButton.Parent = TopBar

CloseButton.MouseButton1Click:Connect(function()
    bgMusic:Stop()
    ScreenGui:Destroy()
end)

-- نص عرض اسم الأغنية الشغالة حالياً
local TrackLabel = Instance.new("TextLabel")
TrackLabel.Size = UDim2.new(1, -20, 0, 30)
TrackLabel.Position = UDim2.new(0, 10, 0, 45)
TrackLabel.BackgroundTransparency = 1
TrackLabel.Text = "Now Playing: " .. playlist[currentTrackIndex].name
TrackLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TrackLabel.Font = Enum.Font.SourceSansItalic
TrackLabel.TextSize = 14
TrackLabel.TextWrapped = true
TrackLabel.Parent = MainFrame

-- زر البدء والإيقاف (Play / Pause Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 135, 0, 40)
ToggleButton.Position = UDim2.new(0, 15, 0, 90)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
ToggleButton.Text = "Pause Music ⏸️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 5)
ToggleCorner.Parent = ToggleButton

-- زر التخطي (Skip Button)
local SkipButton = Instance.new("TextButton")
SkipButton.Name = "SkipButton"
SkipButton.Size = UDim2.new(0, 135, 0, 40)
SkipButton.Position = UDim2.new(1, -150, 0, 90)
SkipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SkipButton.Text = "Skip Track ⏭️"
SkipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SkipButton.Font = Enum.Font.SourceSansBold
SkipButton.TextSize = 14
SkipButton.Parent = MainFrame

local SkipCorner = Instance.new("UICorner")
SkipCorner.CornerRadius = UDim.new(0, 5)
SkipCorner.Parent = SkipButton

-- منطق التحكم بالتشغيل والتنقل
local isPlaying = true
playTrack(currentTrackIndex) -- تشغيل الأغنية الأولى تلقائياً عند بدء السكريبت

ToggleButton.MouseButton1Click:Connect(function()
    if isPlaying then
        bgMusic:Pause()
        ToggleButton.Text = "Play Music ▶️"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
        isPlaying = false
    else
        bgMusic:Resume()
        if not bgMusic.IsPlaying then
            playTrack(currentTrackIndex)
        end
        ToggleButton.Text = "Pause Music ⏸️"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
        isPlaying = true
    end
end)

SkipButton.MouseButton1Click:Connect(function()
    currentTrackIndex = currentTrackIndex + 1
    if currentTrackIndex > #playlist then
        currentTrackIndex = 1 -- العودة للأولى إذا خلصت القائمة
    end
    
    playTrack(currentTrackIndex)
    TrackLabel.Text = "Now Playing: " .. playlist[currentTrackIndex].name
    
    -- تأكيد إعادة الحالة إلى تشغيل تلقائي وتحديث شكل الزر
    isPlaying = true
    ToggleButton.Text = "Pause Music ⏸️"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
end)
