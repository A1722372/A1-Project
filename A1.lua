local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

if CoreGui:FindFirstChild("A1_MusicTester") then
    CoreGui.A1_MusicTester:Destroy()
end

-- الأكواد الجديدة المضمونة
local playlist = {
    {id = 9046863116, name = "Lo-Fi Jazz Chill"},
    {id = 1837014695, name = "Smooth Saxophone Jazz"},
    {id = 1839801222, name = "Classic Piano Jazz Lounge"},
    {id = 9043232147, name = "Retro Swing Jazz"}
}
local currentTrackIndex = 1

local bgMusic = SoundService:FindFirstChild("A1_TestMusic")
if not bgMusic then
    bgMusic = Instance.new("Sound")
    bgMusic.Name = "A1_TestMusic"
    bgMusic.Volume = 0.8 -- رفعنا الصوت شوي عشان نتأكد
    bgMusic.Looped = true
    bgMusic.Parent = SoundService
end

local function playTrack(index)
    local track = playlist[index]
    if track then
        bgMusic:Stop()
        bgMusic.SoundId = "rbxassetid://" .. track.id
        bgMusic:Play()
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "A1_MusicTester"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 150)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

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

local isPlaying = true
playTrack(currentTrackIndex)

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
        currentTrackIndex = 1
    end
    
    playTrack(currentTrackIndex)
    TrackLabel.Text = "Now Playing: " .. playlist[currentTrackIndex].name
    
    isPlaying = true
    ToggleButton.Text = "Pause Music ⏸️"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
end)
