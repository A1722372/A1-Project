-- إنشاء واجهة المستخدم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyCustomGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)

-- 1. زر الاختفاء
local btnHide = Instance.new("TextButton", frame)
btnHide.Text = "اختفاء"
btnHide.Size = UDim2.new(1, 0, 0, 30)
btnHide.Position = UDim2.new(0, 0, 0, 0)
btnHide.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- 2. حقل النص
local textBox = Instance.new("TextBox", frame)
textBox.PlaceholderText = "أدخل 3 أحرف"
textBox.Size = UDim2.new(1, 0, 0, 30)
textBox.Position = UDim2.new(0, 0, 0, 35)

-- 3. زر انتقال و 4. زر مشاهدة (مخفيان في البداية)
local btnTeleport = Instance.new("TextButton", frame)
btnTeleport.Text = "انتقال"
btnTeleport.Size = UDim2.new(0.5, 0, 0, 30)
btnTeleport.Position = UDim2.new(0, 0, 0, 70)
btnTeleport.Visible = false

local btnView = Instance.new("TextButton", frame)
btnView.Text = "مشاهدات"
btnView.Size = UDim2.new(0.5, 0, 0, 30)
btnView.Position = UDim2.new(0.5, 0, 0, 70)
btnView.Visible = false

-- منطق إظهار الأزرار عند كتابة 3 أحرف
textBox:GetPropertyChangedSignal("Text"):Connect(function()
    if #textBox.Text >= 3 then
        btnTeleport.Visible = true
        btnView.Visible = true
    else
        btnTeleport.Visible = false
        btnView.Visible = false
    end
end)

-- الدوال (يمكنك تعديل محتواها لاحقاً حسب حاجتك)
btnTeleport.MouseButton1Click:Connect(function()
    print("تم الضغط على انتقال للاعب: " .. textBox.Text)
end)

btnView.MouseButton1Click:Connect(function()
    print("تم الضغط على مشاهدة للاعب: " .. textBox.Text)
end)
