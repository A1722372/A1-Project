-- إضافة زر الإخفاء
local hideButton = Instance.new("TextButton", mainFrame)
hideButton.Size = UDim2.new(0, 30, 0, 30)
hideButton.Position = UDim2.new(1, -35, 0, 5)
hideButton.Text = "-" -- أو يمكنك وضع صورة أيقونة هنا
hideButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- لون أحمر لزر الإغلاق
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Font = Enum.Font.Bold
local hideCorner = Instance.new("UICorner", hideButton)

-- دالة الإخفاء والإظهار
local isOpen = true
hideButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    
    -- إذا أغلقت السكربت، أظهر زر "فتح" صغير في الزاوية
    if not isOpen then
        local openButton = Instance.new("TextButton", screenGui)
        openButton.Size = UDim2.new(0, 50, 0, 50)
        openButton.Position = UDim2.new(0, 10, 0, 10)
        openButton.Text = "فتح"
        openButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        openButton.Name = "OpenScriptBtn"
        
        openButton.MouseButton1Click:Connect(function()
            mainFrame.Visible = true
            isOpen = true
            openButton:Destroy()
        end)
    end
end)
