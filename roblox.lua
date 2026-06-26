local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService") 

local playerGui = player:WaitForChild("PlayerGui")

-- ================= BẢNG MÀU PASTEL & DỊU MẮT ================= --
-- Bảng màu mang phong cách Soft Dark / Pastel, nhìn hiện đại và không bị chói.
local Colors = {
    Background = Color3.fromRGB(30, 30, 46),       -- Xanh đen dịu (Nền chính)
    Title = Color3.fromRGB(24, 24, 37),            -- Đen xám đậm (Thanh tiêu đề)
    BtnOff = Color3.fromRGB(49, 50, 68),           -- Xám nhẹ (Nút lúc tắt)
    BtnOn = Color3.fromRGB(166, 227, 161),         -- Xanh ngọc Pastel (Nút lúc bật)
    BtnHover = Color3.fromRGB(69, 71, 90),         -- Xám sáng hơn (Khi di chuột)
    BtnOnHover = Color3.fromRGB(180, 245, 175),    -- Xanh ngọc sáng (Khi di chuột nút bật)
    Keybind = Color3.fromRGB(49, 50, 68),          -- Nền nút Keybind
    KeybindHover = Color3.fromRGB(69, 71, 90),     -- Nền nút Keybind Hover
    SliderBg = Color3.fromRGB(69, 71, 90),         -- Nền thanh trượt
    SliderHandle = Color3.fromRGB(137, 180, 250),  -- Xanh dương Pastel (Cục kéo thanh trượt)
    TextPrimary = Color3.fromRGB(205, 214, 244),   -- Trắng xám (Chữ chính)
    TextSecondary = Color3.fromRGB(166, 173, 200), -- Xám nhạt (Chữ phụ)
    RedBtn = Color3.fromRGB(243, 139, 168),        -- Đỏ / Hồng Pastel (Nút Đóng)
    RedBtnHover = Color3.fromRGB(249, 168, 212),   -- Hồng sáng (Hover nút đóng)
    BlueBtn = Color3.fromRGB(137, 180, 250),       -- Xanh dương Pastel (Nút Refresh)
    BlueBtnHover = Color3.fromRGB(180, 203, 234),  -- Xanh dương sáng
    OrangeBtn = Color3.fromRGB(250, 179, 135),     -- Cam đào Pastel (Nút Teleport)
    OrangeBtnHover = Color3.fromRGB(250, 211, 180) -- Cam đào sáng
}

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- HÀM HỖ TRỢ LÀM ĐẸP UI (Bo góc)
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
end

-- HIỆU ỨNG TWEEN (HOVER / CLICK)
local function applyHover(btn, colorNormal, colorHover, isToggle, getState)
    btn.MouseEnter:Connect(function()
        local targetColor = colorHover
        if isToggle and getState() then targetColor = Colors.BtnOnHover end
        TS:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        local targetColor = colorNormal
        if isToggle and getState() then targetColor = Colors.BtnOn end
        TS:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
    end)
end

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 430)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Colors.Background
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true -- QUAN TRỌNG: Cắt phần thừa khi thu nhỏ UI, giúp UI không bị lỗi rớt chữ
frame.Parent = gui
addCorner(frame, 10)

-- MINI BUTTON (Icon sấm sét khi thu nhỏ - Giao diện nổi bật)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 45, 0, 45)
miniIcon.Position = UDim2.new(0, 100, 0, 100)
miniIcon.Text = "⚡"
miniIcon.TextSize = 22
miniIcon.Visible = false
miniIcon.BackgroundColor3 = Colors.Title
miniIcon.TextColor3 = Colors.TextPrimary
miniIcon.Active = true
miniIcon.Parent = gui
addCorner(miniIcon, 25) -- Bo tròn thành hình tròn
applyHover(miniIcon, Colors.Title, Colors.BtnHover)

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Colors.Title
title.Text = "⚡ Ambrose ⚡"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Colors.TextPrimary
title.Active = true
title.Parent = frame
addCorner(title, 10)

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 10)
titleFix.Position = UDim2.new(0, 0, 1, -10)
titleFix.BackgroundColor3 = Colors.Title
titleFix.BorderSizePixel = 0
titleFix.Parent = title

-- CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BackgroundColor3 = Colors.RedBtn
closeBtn.TextColor3 = Colors.Title -- Chữ màu tối trên nền sáng cho dễ nhìn
closeBtn.Parent = frame
addCorner(closeBtn, 8)
applyHover(closeBtn, Colors.RedBtn, Colors.RedBtnHover)

-- MINIMIZE
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 35, 0, 35)
miniBtn.Position = UDim2.new(1, -70, 0, 0)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.BackgroundColor3 = Colors.Title
miniBtn.TextColor3 = Colors.TextPrimary
miniBtn.Parent = frame
addCorner(miniBtn, 8)
applyHover(miniBtn, Colors.Title, Colors.BtnHover)

-- ================= LOGIC BIẾN ================= --
local enabled = false
local speedValue = 16
local weightEnabled = false
local weightValue = 0
local flyEnabled = false
local flySpeed = 50
local noclipEnabled = false

-- ================= CÁC THÀNH PHẦN UI ================= --
-- SPEED (Y: 45)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.65, 0, 0, 30)
toggleBtn.Position = UDim2.new(0.075, 0, 0, 45)
toggleBtn.Text = "Speed: OFF"
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 13
toggleBtn.BackgroundColor3 = Colors.BtnOff
toggleBtn.TextColor3 = Colors.TextPrimary
toggleBtn.Parent = frame
addCorner(toggleBtn, 6)
applyHover(toggleBtn, Colors.BtnOff, Colors.BtnHover, true, function() return enabled end)

local speedKeyBtn = Instance.new("TextButton")
speedKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
speedKeyBtn.Position = UDim2.new(0.745, 0, 0, 45)
speedKeyBtn.Text = "None"
speedKeyBtn.Font = Enum.Font.Gotham
speedKeyBtn.TextSize = 11
speedKeyBtn.BackgroundColor3 = Colors.Keybind
speedKeyBtn.TextColor3 = Colors.TextSecondary
speedKeyBtn.Parent = frame
addCorner(speedKeyBtn, 6)
applyHover(speedKeyBtn, Colors.Keybind, Colors.KeybindHover)

local sliderBar = Instance.new("Frame")
sliderBar.Size = UDim2.new(0.65, 0, 0, 6) 
sliderBar.Position = UDim2.new(0.075, 0, 0, 85)
sliderBar.BackgroundColor3 = Colors.SliderBg
sliderBar.Parent = frame
addCorner(sliderBar, 100)

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 14, 0, 14)
slider.Position = UDim2.new(0, -7, 0.5, -7)
slider.BackgroundColor3 = Colors.SliderHandle
slider.Parent = sliderBar
addCorner(slider, 100)

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.65, 0, 0, 20)
speedText.Position = UDim2.new(0.075, 0, 0, 95)
speedText.BackgroundTransparency = 1
speedText.Font = Enum.Font.Gotham
speedText.TextSize = 12
speedText.TextColor3 = Colors.TextSecondary
speedText.Text = "Speed: 16"
speedText.Parent = frame

-- WEIGHT (Y: 125)
local weightToggle = Instance.new("TextButton")
weightToggle.Size = UDim2.new(0.65, 0, 0, 30)
weightToggle.Position = UDim2.new(0.075, 0, 0, 125)
weightToggle.Text = "Weight: OFF"
weightToggle.Font = Enum.Font.GothamSemibold
weightToggle.TextSize = 13
weightToggle.BackgroundColor3 = Colors.BtnOff
weightToggle.TextColor3 = Colors.TextPrimary
weightToggle.Parent = frame
addCorner(weightToggle, 6)
applyHover(weightToggle, Colors.BtnOff, Colors.BtnHover, true, function() return weightEnabled end)

local weightKeyBtn = Instance.new("TextButton")
weightKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
weightKeyBtn.Position = UDim2.new(0.745, 0, 0, 125)
weightKeyBtn.Text = "None"
weightKeyBtn.Font = Enum.Font.Gotham
weightKeyBtn.TextSize = 11
weightKeyBtn.BackgroundColor3 = Colors.Keybind
weightKeyBtn.TextColor3 = Colors.TextSecondary
weightKeyBtn.Parent = frame
addCorner(weightKeyBtn, 6)
applyHover(weightKeyBtn, Colors.Keybind, Colors.KeybindHover)

local weightBar = Instance.new("Frame")
weightBar.Size = UDim2.new(0.65, 0, 0, 6)
weightBar.Position = UDim2.new(0.075, 0, 0, 165)
weightBar.BackgroundColor3 = Colors.SliderBg
weightBar.Parent = frame
addCorner(weightBar, 100)

local weightSlider = Instance.new("Frame")
weightSlider.Size = UDim2.new(0, 14, 0, 14)
weightSlider.Position = UDim2.new(0, -7, 0.5, -7)
weightSlider.BackgroundColor3 = Colors.SliderHandle
weightSlider.Parent = weightBar
addCorner(weightSlider, 100)

local weightText = Instance.new("TextLabel")
weightText.Size = UDim2.new(0.65, 0, 0, 20)
weightText.Position = UDim2.new(0.075, 0, 0, 175)
weightText.BackgroundTransparency = 1
weightText.Font = Enum.Font.Gotham
weightText.TextSize = 12
weightText.TextColor3 = Colors.TextSecondary
weightText.Text = "Weight: 0"
weightText.Parent = frame

-- FLY (Y: 205)
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0.65, 0, 0, 30)
flyToggle.Position = UDim2.new(0.075, 0, 0, 205)
flyToggle.Text = "Fly: OFF"
flyToggle.Font = Enum.Font.GothamSemibold
flyToggle.TextSize = 13
flyToggle.BackgroundColor3 = Colors.BtnOff
flyToggle.TextColor3 = Colors.TextPrimary
flyToggle.Parent = frame
addCorner(flyToggle, 6)
applyHover(flyToggle, Colors.BtnOff, Colors.BtnHover, true, function() return flyEnabled end)

local flyKeyBtn = Instance.new("TextButton")
flyKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
flyKeyBtn.Position = UDim2.new(0.745, 0, 0, 205)
flyKeyBtn.Text = "None"
flyKeyBtn.Font = Enum.Font.Gotham
flyKeyBtn.TextSize = 11
flyKeyBtn.BackgroundColor3 = Colors.Keybind
flyKeyBtn.TextColor3 = Colors.TextSecondary
flyKeyBtn.Parent = frame
addCorner(flyKeyBtn, 6)
applyHover(flyKeyBtn, Colors.Keybind, Colors.KeybindHover)

local flyBar = Instance.new("Frame")
flyBar.Size = UDim2.new(0.65, 0, 0, 6)
flyBar.Position = UDim2.new(0.075, 0, 0, 245)
flyBar.BackgroundColor3 = Colors.SliderBg
flyBar.Parent = frame
addCorner(flyBar, 100)

local flySlider = Instance.new("Frame")
flySlider.Size = UDim2.new(0, 14, 0, 14)
flySlider.Position = UDim2.new(0, -7, 0.5, -7)
flySlider.BackgroundColor3 = Colors.SliderHandle
flySlider.Parent = flyBar
addCorner(flySlider, 100)

local flyText = Instance.new("TextLabel")
flyText.Size = UDim2.new(0.65, 0, 0, 20)
flyText.Position = UDim2.new(0.075, 0, 0, 255)
flyText.BackgroundTransparency = 1
flyText.Font = Enum.Font.Gotham
flyText.TextSize = 12
flyText.TextColor3 = Colors.TextSecondary
flyText.Text = "Fly Speed: 50"
flyText.Parent = frame

-- NOCLIP (Y: 285)
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0.65, 0, 0, 30)
noclipToggle.Position = UDim2.new(0.075, 0, 0, 285) 
noclipToggle.Text = "Noclip: OFF"
noclipToggle.Font = Enum.Font.GothamSemibold
noclipToggle.TextSize = 13
noclipToggle.BackgroundColor3 = Colors.BtnOff
noclipToggle.TextColor3 = Colors.TextPrimary
noclipToggle.Parent = frame
addCorner(noclipToggle, 6)
applyHover(noclipToggle, Colors.BtnOff, Colors.BtnHover, true, function() return noclipEnabled end)

local noclipKeyBtn = Instance.new("TextButton")
noclipKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
noclipKeyBtn.Position = UDim2.new(0.745, 0, 0, 285)
noclipKeyBtn.Text = "None"
noclipKeyBtn.Font = Enum.Font.Gotham
noclipKeyBtn.TextSize = 11
noclipKeyBtn.BackgroundColor3 = Colors.Keybind
noclipKeyBtn.TextColor3 = Colors.TextSecondary
noclipKeyBtn.Parent = frame
addCorner(noclipKeyBtn, 6)
applyHover(noclipKeyBtn, Colors.Keybind, Colors.KeybindHover)

-- DROPDOWN TELEPORT (Y: 335)
local tpDropdownBtn = Instance.new("TextButton")
tpDropdownBtn.Size = UDim2.new(0.85, 0, 0, 30)
tpDropdownBtn.Position = UDim2.new(0.075, 0, 0, 335)
tpDropdownBtn.Text = "Chọn người chơi..."
tpDropdownBtn.Font = Enum.Font.Gotham
tpDropdownBtn.TextSize = 12
tpDropdownBtn.BackgroundColor3 = Colors.Keybind
tpDropdownBtn.TextColor3 = Colors.TextPrimary
tpDropdownBtn.Parent = frame
addCorner(tpDropdownBtn, 6)
applyHover(tpDropdownBtn, Colors.Keybind, Colors.KeybindHover)

-- NÚT REFRESH (Y: 380, bên trái)
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.4, 0, 0, 30)
refreshBtn.Position = UDim2.new(0.075, 0, 0, 380)
refreshBtn.Text = "Refresh"
refreshBtn.Font = Enum.Font.GothamSemibold
refreshBtn.TextSize = 12
refreshBtn.BackgroundColor3 = Colors.BlueBtn
refreshBtn.TextColor3 = Colors.Title
refreshBtn.Parent = frame
addCorner(refreshBtn, 6)
applyHover(refreshBtn, Colors.BlueBtn, Colors.BlueBtnHover)

-- NÚT TELEPORT (Y: 380, bên phải)
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.4, 0, 0, 30)
tpBtn.Position = UDim2.new(0.525, 0, 0, 380)
tpBtn.Text = "Teleport"
tpBtn.Font = Enum.Font.GothamSemibold
tpBtn.TextSize = 12
tpBtn.BackgroundColor3 = Colors.OrangeBtn
tpBtn.TextColor3 = Colors.Title
tpBtn.Parent = frame
addCorner(tpBtn, 6)
applyHover(tpBtn, Colors.OrangeBtn, Colors.OrangeBtnHover)

-- KHUNG DANH SÁCH CUỘN (SCROLLING FRAME)
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(0.85, 0, 0, 100)
playerListFrame.Position = UDim2.new(0.075, 0, 0, 368)
playerListFrame.BackgroundColor3 = Colors.Title
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.ZIndex = 10
playerListFrame.ScrollBarThickness = 3
playerListFrame.ScrollBarImageColor3 = Colors.SliderHandle
playerListFrame.Parent = frame
addCorner(playerListFrame, 6)

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = playerListFrame
listLayout.SortOrder = Enum.SortOrder.Name

-- ================= LOGIC TIẾP TỤC ================= --
local draggingSlider = false
local draggingWeight = false
local draggingFly = false

local weightForce = nil
local flyVelocity = nil
local moveY = 0

-- QUẢN LÝ KEYBINDS
local keybinds = { Speed = nil, Weight = nil, Fly = nil, Noclip = nil }
local bindingTarget = nil
local bindingBtn = nil

local function getHumanoid()
    local char = player.Character
    if char then return char:FindFirstChild("Humanoid") end
end

local function getTargetRoot()
    local char = player.Character
    if not char then return nil end
    local hum = char:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then
        return hum.SeatPart.AssemblyRootPart or hum.SeatPart
    end
    return char:FindFirstChild("HumanoidRootPart")
end

local function applyWeight()
    local root = getTargetRoot()
    if not root then return end
    if not weightForce or weightForce.Parent ~= root then
        if weightForce then pcall(function() weightForce:Destroy() end) end
        local att = root:FindFirstChild("WeightAttachment")
        if not att then
            att = Instance.new("Attachment", root)
            att.Name = "WeightAttachment"
        end
        weightForce = Instance.new("VectorForce")
        weightForce.Attachment0 = att
        weightForce.RelativeTo = Enum.ActuatorRelativeTo.World
        weightForce.Parent = root
    end
    weightForce.Force = Vector3.new(0, -workspace.Gravity * root.AssemblyMass * weightValue, 0)
end

local function removeWeight()
    if weightForce then weightForce:Destroy(); weightForce = nil end
end

local function startFly()
    local root = getTargetRoot()
    if not root then return end
    if not flyVelocity or flyVelocity.Parent ~= root then
        if flyVelocity then pcall(function() flyVelocity:Destroy() end) end
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.MaxForce = Vector3.new(1,1,1) * 1e6
        flyVelocity.Parent = root
    end
end

local function stopFly()
    if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
end

-- ================= CÁC HÀM TOGGLE CÓ HIỆU ỨNG ================= --
local function toggleColor(btn, state)
    local targetColor = state and Colors.BtnOn or Colors.BtnOff
    local targetTextColor = state and Colors.Title or Colors.TextPrimary -- Chữ tối màu khi nút sáng lên
    TS:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor, TextColor3 = targetTextColor}):Play()
end

local function toggleSpeedLogic()
    enabled = not enabled
    toggleBtn.Text = enabled and "Speed: ON" or "Speed: OFF"
    toggleColor(toggleBtn, enabled)
end

local function toggleWeightLogic()
    weightEnabled = not weightEnabled
    weightToggle.Text = weightEnabled and "Weight: ON" or "Weight: OFF"
    toggleColor(weightToggle, weightEnabled)
end

local function toggleFlyLogic()
    flyEnabled = not flyEnabled
    flyToggle.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    toggleColor(flyToggle, flyEnabled)
    if flyEnabled then startFly() else stopFly() end
end

local function toggleNoclipLogic()
    noclipEnabled = not noclipEnabled
    noclipToggle.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    toggleColor(noclipToggle, noclipEnabled)
    
    if not noclipEnabled then
        local char = player.Character
        if char then
            local partsToReset = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso"}
            for _, name in ipairs(partsToReset) do
                local part = char:FindFirstChild(name)
                if part and part:IsA("BasePart") then part.CanCollide = true end
            end
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end
end

toggleBtn.MouseButton1Click:Connect(toggleSpeedLogic)
weightToggle.MouseButton1Click:Connect(toggleWeightLogic)
flyToggle.MouseButton1Click:Connect(toggleFlyLogic)
noclipToggle.MouseButton1Click:Connect(toggleNoclipLogic)

-- ================= LOGIC GÁN PHÍM TẮT ================= --
local function setupKeybindButton(btn, targetName)
    btn.MouseButton1Click:Connect(function()
        bindingTarget = targetName
        bindingBtn = btn
        btn.Text = "..."
    end)
end

setupKeybindButton(speedKeyBtn, "Speed")
setupKeybindButton(weightKeyBtn, "Weight")
setupKeybindButton(flyKeyBtn, "Fly")
setupKeybindButton(noclipKeyBtn, "Noclip")

-- ================= ĐIỀU KHIỂN ================= --
UIS.InputBegan:Connect(function(input, gameProcessed)
    if bindingTarget then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.Escape then
                keybinds[bindingTarget] = nil
                bindingBtn.Text = "None"
            else
                keybinds[bindingTarget] = input.KeyCode
                bindingBtn.Text = input.KeyCode.Name
            end
            bindingTarget = nil
            bindingBtn = nil
        end
        return
    end

    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == keybinds["Speed"] then toggleSpeedLogic() end
            if input.KeyCode == keybinds["Weight"] then toggleWeightLogic() end
            if input.KeyCode == keybinds["Fly"] then toggleFlyLogic() end
            if input.KeyCode == keybinds["Noclip"] then toggleNoclipLogic() end
        end

        if (input.KeyCode == Enum.KeyCode.F5 or input.KeyCode == Enum.KeyCode.Pause) then
            if frame.Visible then
                miniIcon.Position = frame.Position
                -- Tween Minimize
                TS:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                task.delay(0.3, function()
                    frame.Visible = false
                    frame.Size = UDim2.new(0, 240, 0, 430)
                    miniIcon.Visible = true
                    miniIcon.Size = UDim2.new(0, 0, 0, 0)
                    TS:Create(miniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
                end)
            else
                frame.Position = miniIcon.Position
                -- Tween Maximize
                TS:Create(miniIcon, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                task.delay(0.15, function()
                    miniIcon.Visible = false
                    miniIcon.Size = UDim2.new(0, 45, 0, 45)
                    frame.Visible = true
                    frame.Size = UDim2.new(0, 0, 0, 0)
                    TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 430)}):Play()
                end)
            end
        end

        if input.KeyCode == Enum.KeyCode.Space then moveY = 1 end
        if input.KeyCode == Enum.KeyCode.LeftShift then moveY = -1 end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
        moveY = 0
    end
end)

-- ================= KÉO THẢ UI ================= --
local function makeDraggable(dragHandle, targetFrame)
    targetFrame = targetFrame or dragHandle
    local dragging, dragInput, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TS:Create(targetFrame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
end

makeDraggable(title, frame)
makeDraggable(miniIcon, miniIcon)

-- ================= LOOP HỆ THỐNG ================= --
local loopConnection
local noclipConnection

loopConnection = RunService.RenderStepped:Connect(function()
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = enabled and speedValue or 16 end
    
    if weightEnabled then applyWeight() else removeWeight() end
    
    if flyEnabled then
        startFly() 
        if flyVelocity then
            local root = getTargetRoot()
            if root then
                local cam = workspace.CurrentCamera
                local look = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector
                
                local flatLook = Vector3.new(look.X, 0, look.Z)
                if flatLook.Magnitude > 0 then flatLook = flatLook.Unit end
                
                local flatRight = Vector3.new(right.X, 0, right.Z)
                if flatRight.Magnitude > 0 then flatRight = flatRight.Unit end
                
                local dir = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir += flatLook end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= flatLook end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= flatRight end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir += flatRight end
                
                if dir.Magnitude > 0 then dir = dir.Unit end
                dir += Vector3.new(0, moveY, 0)
                
                if dir.Magnitude > 0 then dir = dir.Unit * flySpeed end
                flyVelocity.Velocity = dir
            end
        end
    else
        stopFly()
    end
end)

noclipConnection = RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end
end)

-- ================= TELEPORT DROPDOWN ================= --
local function updatePlayerList()
    for _, child in pairs(playerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local yOffset = 0
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.BackgroundColor3 = Colors.Keybind
            btn.Text = "  " .. p.Name
            btn.TextColor3 = Colors.TextPrimary
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.BorderSizePixel = 0
            btn.ZIndex = 11
            btn.Parent = playerListFrame
            
            applyHover(btn, Colors.Keybind, Colors.KeybindHover)
            
            btn.MouseButton1Click:Connect(function()
                tpDropdownBtn.Text = p.Name
                playerListFrame.Visible = false
            end)
            
            yOffset = yOffset + 25
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

tpDropdownBtn.MouseButton1Click:Connect(function()
    playerListFrame.Visible = not playerListFrame.Visible
    if playerListFrame.Visible then updatePlayerList() end
end)

refreshBtn.MouseButton1Click:Connect(function()
    updatePlayerList()
    tpDropdownBtn.Text = "Chọn người chơi..."
    refreshBtn.Text = "Updated!"
    task.delay(1, function()
        if refreshBtn then refreshBtn.Text = "Refresh" end
    end)
end)

tpBtn.MouseButton1Click:Connect(function()
    local targetName = tpDropdownBtn.Text
    local targetPlayer = game.Players:FindFirstChild(targetName)
    
    if targetPlayer and targetPlayer.Character then
        local targetCFrame = targetPlayer.Character:GetPivot()
        local myRoot = getTargetRoot()
        
        if targetCFrame and myRoot then
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = targetCFrame * CFrame.new(0, 3, 3)
            
            tpBtn.Text = "Teleported!"
            task.delay(1, function()
                if tpBtn then tpBtn.Text = "Teleport" end
            end)
        end
    else
        tpBtn.Text = "Target Loading!"
        task.delay(1.5, function()
            if tpBtn then tpBtn.Text = "Teleport" end
        end)
    end
end)

-- ================= ĐỒNG BỘ MINIMIZE ================= --
miniBtn.MouseButton1Click:Connect(function()
    miniIcon.Position = frame.Position
    -- Thu gọn Frame với hiệu ứng Back
    TS:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.3, function()
        frame.Visible = false
        frame.Size = UDim2.new(0, 240, 0, 430) -- Reset size để mở lại
        miniIcon.Visible = true
        miniIcon.Size = UDim2.new(0, 0, 0, 0)
        -- Phóng to Mini Icon
        TS:Create(miniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
    end)
end)

miniIcon.MouseButton1Click:Connect(function()
    frame.Position = miniIcon.Position
    -- Thu nhỏ Mini Icon
    TS:Create(miniIcon, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.15, function()
        miniIcon.Visible = false
        miniIcon.Size = UDim2.new(0, 45, 0, 45) -- Reset
        frame.Visible = true
        frame.Size = UDim2.new(0, 0, 0, 0)
        -- Phóng to Frame với hiệu ứng Back
        TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 430)}):Play()
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    enabled = false; weightEnabled = false; flyEnabled = false; noclipEnabled = false
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = 16 end
    removeWeight(); stopFly()
    
    local char = player.Character
    if char then
        local partsToReset = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso"}
        for _, name in ipairs(partsToReset) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then part.CanCollide = true end
        end
        if hum and hum.SeatPart then
            for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
    
    if loopConnection then loopConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    
    TS:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.3, function() gui:Destroy() end)
end)

-- ================= XỬ LÝ SLIDERS ================= --
sliderBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end
end)
weightBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingWeight = true end
end)
flyBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingFly = true end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if draggingSlider then
            local p = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X)/sliderBar.AbsoluteSize.X, 0, 1)
            slider.Position = UDim2.new(p, -7, 0.5, -7)
            speedValue = math.floor(p * 1000)
            speedText.Text = "Speed: " .. speedValue
        end
        if draggingWeight then
            local p = math.clamp((input.Position.X - weightBar.AbsolutePosition.X)/weightBar.AbsoluteSize.X, 0, 1)
            weightSlider.Position = UDim2.new(p, -7, 0.5, -7)
            weightValue = math.floor(p * 1000)
            weightText.Text = "Weight: " .. weightValue
        end
        if draggingFly then
            local p = math.clamp((input.Position.X - flyBar.AbsolutePosition.X)/flyBar.AbsoluteSize.X, 0, 1)
            flySlider.Position = UDim2.new(p, -7, 0.5, -7)
            flySpeed = math.floor(p * 1000)
            flyText.Text = "Fly Speed: " .. flySpeed
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false; draggingWeight = false; draggingFly = false
    end
end)
