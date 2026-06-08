-- تعريف المتغيرات للحالات (خارج الدوال)
local isSpeedEnabled = false
local isJumpEnabled = false
local isInvisible = false

-- 1. دالة السرعة (مع التبديل)
-- استبدل زر السرعة الحالي بهذا المنطق
speedBtn.MouseButton1Click:Connect(function()
    isSpeedEnabled = not isSpeedEnabled -- عكس الحالة
    if isSpeedEnabled then
        humanoid.WalkSpeed = tonumber(speedInput.Text) or 100 -- السرعة عند التفعيل
        speedBtn.Text = "السرعة: ON"
    else
        humanoid.WalkSpeed = 16 -- السرعة الافتراضية عند الإيقاف
        speedBtn.Text = "السرعة: OFF"
    end
end)

-- 2. دالة القفز (مع التبديل)
jumpBtn.MouseButton1Click:Connect(function()
    isJumpEnabled = not isJumpEnabled
    if isJumpEnabled then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 100 -- قوة القفز المطلوبة
        jumpBtn.Text = "القفز: ON"
    else
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 50 -- القيمة الطبيعية للقفز
        jumpBtn.Text = "القفز: OFF"
    end
end)

-- 3. دالة الاختفاء (مع التبديل)
invisibleBtn.MouseButton1Click:Connect(function()
    isInvisible = not isInvisible
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = isInvisible and 1 or 0
        end
    end
    invisibleBtn.Text = isInvisible and "الاختفاء: ON" or "الاختفاء: OFF"
end)
