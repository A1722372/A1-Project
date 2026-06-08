-- صنع من قبل أيهم
loadstring(game:HttpGet("https://rawscripts.net/raw/ryfn-alaskryh-or-jwaez-ywmyh-RAVEN-ACADEMY-230857"))()

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
task.spawn(function()
    while true do
        task.wait(900)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
