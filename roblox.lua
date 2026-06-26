local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService") 

local playerGui = player:WaitForChild("PlayerGui")

-- ================= BẢNG MÀU PASTEL & DỊU MẮT ================= --
local Colors = {
    Background = Color3.fromRGB(30, 30, 46),       -- Xanh đen dịu
    Title = Color3.fromRGB(24, 24, 37),            -- Đen xám đậm
    BtnOff = Color3.fromRGB(49, 50, 68),           -- Xám nhẹ
    BtnOn = Color3.fromRGB(166, 227, 161),         -- Xanh ngọc Pastel
    BtnHover = Color3.fromRGB(69, 71, 90),         -- Xám sáng hơn
    BtnOnHover = Color3.fromRGB(180, 245, 175),    -- Xanh ngọc sáng
    Keybind = Color3.fromRGB(49, 50, 68),          
    KeybindHover = Color3.fromRGB(69, 71, 90),     
    SliderBg = Color3.fromRGB(69, 71, 90),         
    SliderHandle = Color3.fromRGB(137, 180, 250),  -- Xanh dương Pastel
    TextPrimary = Color3.fromRGB(205, 214, 244),   
    TextSecondary = Color3.fromRGB(166, 173, 200), 
    RedBtn = Color3.fromRGB(243, 139, 168),        
    RedBtnHover = Color3.fromRGB(249, 168, 212),   
    BlueBtn = Color3.fromRGB(137, 180, 250),       
    BlueBtnHover = Color3.fromRGB(180, 203, 234),  
    OrangeBtn = Color3.fromRGB(250, 179, 135),     
    OrangeBtnHover = Color3.fromRGB(250, 211, 180) 
}

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- HÀM HỖ TRỢ LÀM ĐẸP UI
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
end

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

-- ================= MAIN FRAME ================= --
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 480) -- Tăng chiều cao để chứa Tab
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Colors.Background
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
addCorner(frame, 10)

-- MINI BUTTON
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
addCorner(miniIcon, 25)
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

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BackgroundColor3 = Colors.RedBtn
closeBtn.TextColor3 = Colors.Title
closeBtn.Parent = frame
addCorner(closeBtn, 8)
applyHover(closeBtn, Colors.RedBtn, Colors.RedBtnHover)

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

-- ================= HỆ THỐNG TABS ================= --
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 30)
tabContainer.Position = UDim2.new(0, 10, 0, 45)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = frame

local tabMainBtn = Instance.new("TextButton")
tabMainBtn.Size = UDim2.new(0.48, 0, 1, 0)
tabMainBtn.Position = UDim2.new(0, 0, 0, 0)
tabMainBtn.Text = "Main"
tabMainBtn.Font = Enum.Font.GothamBold
tabMainBtn.TextSize = 12
tabMainBtn.BackgroundColor3 = Colors.BtnHover
tabMainBtn.TextColor3 = Colors.TextPrimary
tabMainBtn.Parent = tabContainer
addCorner(tabMainBtn, 6)

local tabProfileBtn = Instance.new("TextButton")
tabProfileBtn.Size = UDim2.new(0.48, 0, 1, 0)
tabProfileBtn.Position = UDim2.new(0.52, 0, 0, 0)
tabProfileBtn.Text = "Profile"
tabProfileBtn.Font = Enum.Font.GothamBold
tabProfileBtn.TextSize = 12
tabProfileBtn.BackgroundColor3 = Colors.BtnOff
tabProfileBtn.TextColor3 = Colors.TextSecondary
tabProfileBtn.Parent = tabContainer
addCorner(tabProfileBtn, 6)

-- Các khung trang (Pages)
local pageMain = Instance.new("Frame")
pageMain.Size = UDim2.new(1, 0, 1, -85)
pageMain.Position = UDim2.new(0, 0, 0, 85)
pageMain.BackgroundTransparency = 1
pageMain.Visible = true
pageMain.Parent = frame

local pageProfile = Instance.new("Frame")
pageProfile.Size = UDim2.new(1, 0, 1, -85)
pageProfile.Position = UDim2.new(0, 0, 0, 85)
pageProfile.BackgroundTransparency = 1
pageProfile.Visible = false
pageProfile.Parent = frame

-- Logic chuyển Tab
tabMainBtn.MouseButton1Click:Connect(function()
    pageMain.Visible = true
    pageProfile.Visible = false
    TS:Create(tabMainBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.BtnHover, TextColor3 = Colors.TextPrimary}):Play()
    TS:Create(tabProfileBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.BtnOff, TextColor3 = Colors.TextSecondary}):Play()
end)

tabProfileBtn.MouseButton1Click:Connect(function()
    pageMain.Visible = false
    pageProfile.Visible = true
    TS:Create(tabProfileBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.BtnHover, TextColor3 = Colors.TextPrimary}):Play()
    TS:Create(tabMainBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.BtnOff, TextColor3 = Colors.TextSecondary}):Play()
end)

-- ================= LOGIC BIẾN ================= --
local enabled, weightEnabled, flyEnabled, noclipEnabled = false, false, false, false
local speedValue, weightValue, flySpeed = 16, 0, 50

-- ================= UI: PAGE MAIN (Chức năng cũ) ================= --
-- SPEED
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.65, 0, 0, 30)
toggleBtn.Position = UDim2.new(0.075, 0, 0, 10)
toggleBtn.Text = "Speed: OFF"
toggleBtn.Font = Enum.Font.GothamSemibold; toggleBtn.TextSize = 13
toggleBtn.BackgroundColor3 = Colors.BtnOff; toggleBtn.TextColor3 = Colors.TextPrimary
toggleBtn.Parent = pageMain
addCorner(toggleBtn, 6)
applyHover(toggleBtn, Colors.BtnOff, Colors.BtnHover, true, function() return enabled end)

local speedKeyBtn = Instance.new("TextButton")
speedKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
speedKeyBtn.Position = UDim2.new(0.745, 0, 0, 10)
speedKeyBtn.Text = "None"
speedKeyBtn.Font = Enum.Font.Gotham; speedKeyBtn.TextSize = 11
speedKeyBtn.BackgroundColor3 = Colors.Keybind; speedKeyBtn.TextColor3 = Colors.TextSecondary
speedKeyBtn.Parent = pageMain
addCorner(speedKeyBtn, 6)
applyHover(speedKeyBtn, Colors.Keybind, Colors.KeybindHover)

local sliderBar = Instance.new("Frame")
sliderBar.Size = UDim2.new(0.65, 0, 0, 6) 
sliderBar.Position = UDim2.new(0.075, 0, 0, 50)
sliderBar.BackgroundColor3 = Colors.SliderBg
sliderBar.Parent = pageMain
addCorner(sliderBar, 100)

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 14, 0, 14)
slider.Position = UDim2.new(0, -7, 0.5, -7)
slider.BackgroundColor3 = Colors.SliderHandle
slider.Parent = sliderBar
addCorner(slider, 100)

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.65, 0, 0, 20)
speedText.Position = UDim2.new(0.075, 0, 0, 60)
speedText.BackgroundTransparency = 1
speedText.Font = Enum.Font.Gotham; speedText.TextSize = 12
speedText.TextColor3 = Colors.TextSecondary
speedText.Text = "Speed: 16"
speedText.Parent = pageMain

-- WEIGHT
local weightToggle = Instance.new("TextButton")
weightToggle.Size = UDim2.new(0.65, 0, 0, 30)
weightToggle.Position = UDim2.new(0.075, 0, 0, 90)
weightToggle.Text = "Weight: OFF"
weightToggle.Font = Enum.Font.GothamSemibold; weightToggle.TextSize = 13
weightToggle.BackgroundColor3 = Colors.BtnOff; weightToggle.TextColor3 = Colors.TextPrimary
weightToggle.Parent = pageMain
addCorner(weightToggle, 6)
applyHover(weightToggle, Colors.BtnOff, Colors.BtnHover, true, function() return weightEnabled end)

local weightKeyBtn = Instance.new("TextButton")
weightKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
weightKeyBtn.Position = UDim2.new(0.745, 0, 0, 90)
weightKeyBtn.Text = "None"
weightKeyBtn.Font = Enum.Font.Gotham; weightKeyBtn.TextSize = 11
weightKeyBtn.BackgroundColor3 = Colors.Keybind; weightKeyBtn.TextColor3 = Colors.TextSecondary
weightKeyBtn.Parent = pageMain
addCorner(weightKeyBtn, 6)
applyHover(weightKeyBtn, Colors.Keybind, Colors.KeybindHover)

local weightBar = Instance.new("Frame")
weightBar.Size = UDim2.new(0.65, 0, 0, 6)
weightBar.Position = UDim2.new(0.075, 0, 0, 130)
weightBar.BackgroundColor3 = Colors.SliderBg
weightBar.Parent = pageMain
addCorner(weightBar, 100)

local weightSlider = Instance.new("Frame")
weightSlider.Size = UDim2.new(0, 14, 0, 14)
weightSlider.Position = UDim2.new(0, -7, 0.5, -7)
weightSlider.BackgroundColor3 = Colors.SliderHandle
weightSlider.Parent = weightBar
addCorner(weightSlider, 100)

local weightText = Instance.new("TextLabel")
weightText.Size = UDim2.new(0.65, 0, 0, 20)
weightText.Position = UDim2.new(0.075, 0, 0, 140)
weightText.BackgroundTransparency = 1
weightText.Font = Enum.Font.Gotham; weightText.TextSize = 12
weightText.TextColor3 = Colors.TextSecondary
weightText.Text = "Weight: 0"
weightText.Parent = pageMain

-- FLY
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0.65, 0, 0, 30)
flyToggle.Position = UDim2.new(0.075, 0, 0, 170)
flyToggle.Text = "Fly: OFF"
flyToggle.Font = Enum.Font.GothamSemibold; flyToggle.TextSize = 13
flyToggle.BackgroundColor3 = Colors.BtnOff; flyToggle.TextColor3 = Colors.TextPrimary
flyToggle.Parent = pageMain
addCorner(flyToggle, 6)
applyHover(flyToggle, Colors.BtnOff, Colors.BtnHover, true, function() return flyEnabled end)

local flyKeyBtn = Instance.new("TextButton")
flyKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
flyKeyBtn.Position = UDim2.new(0.745, 0, 0, 170)
flyKeyBtn.Text = "None"
flyKeyBtn.Font = Enum.Font.Gotham; flyKeyBtn.TextSize = 11
flyKeyBtn.BackgroundColor3 = Colors.Keybind; flyKeyBtn.TextColor3 = Colors.TextSecondary
flyKeyBtn.Parent = pageMain
addCorner(flyKeyBtn, 6)
applyHover(flyKeyBtn, Colors.Keybind, Colors.KeybindHover)

local flyBar = Instance.new("Frame")
flyBar.Size = UDim2.new(0.65, 0, 0, 6)
flyBar.Position = UDim2.new(0.075, 0, 0, 210)
flyBar.BackgroundColor3 = Colors.SliderBg
flyBar.Parent = pageMain
addCorner(flyBar, 100)

local flySlider = Instance.new("Frame")
flySlider.Size = UDim2.new(0, 14, 0, 14)
flySlider.Position = UDim2.new(0, -7, 0.5, -7)
flySlider.BackgroundColor3 = Colors.SliderHandle
flySlider.Parent = flyBar
addCorner(flySlider, 100)

local flyText = Instance.new("TextLabel")
flyText.Size = UDim2.new(0.65, 0, 0, 20)
flyText.Position = UDim2.new(0.075, 0, 0, 220)
flyText.BackgroundTransparency = 1
flyText.Font = Enum.Font.Gotham; flyText.TextSize = 12
flyText.TextColor3 = Colors.TextSecondary
flyText.Text = "Fly Speed: 50"
flyText.Parent = pageMain

-- NOCLIP
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0.65, 0, 0, 30)
noclipToggle.Position = UDim2.new(0.075, 0, 0, 250) 
noclipToggle.Text = "Noclip: OFF"
noclipToggle.Font = Enum.Font.GothamSemibold; noclipToggle.TextSize = 13
noclipToggle.BackgroundColor3 = Colors.BtnOff; noclipToggle.TextColor3 = Colors.TextPrimary
noclipToggle.Parent = pageMain
addCorner(noclipToggle, 6)
applyHover(noclipToggle, Colors.BtnOff, Colors.BtnHover, true, function() return noclipEnabled end)

local noclipKeyBtn = Instance.new("TextButton")
noclipKeyBtn.Size = UDim2.new(0.18, 0, 0, 30)
noclipKeyBtn.Position = UDim2.new(0.745, 0, 0, 250)
noclipKeyBtn.Text = "None"
noclipKeyBtn.Font = Enum.Font.Gotham; noclipKeyBtn.TextSize = 11
noclipKeyBtn.BackgroundColor3 = Colors.Keybind; noclipKeyBtn.TextColor3 = Colors.TextSecondary
noclipKeyBtn.Parent = pageMain
addCorner(noclipKeyBtn, 6)
applyHover(noclipKeyBtn, Colors.Keybind, Colors.KeybindHover)

-- DROPDOWN TELEPORT
local tpDropdownBtn = Instance.new("TextButton")
tpDropdownBtn.Size = UDim2.new(0.85, 0, 0, 30)
tpDropdownBtn.Position = UDim2.new(0.075, 0, 0, 295)
tpDropdownBtn.Text = "Chọn người chơi..."
tpDropdownBtn.Font = Enum.Font.Gotham; tpDropdownBtn.TextSize = 12
tpDropdownBtn.BackgroundColor3 = Colors.Keybind; tpDropdownBtn.TextColor3 = Colors.TextPrimary
tpDropdownBtn.Parent = pageMain
addCorner(tpDropdownBtn, 6)
applyHover(tpDropdownBtn, Colors.Keybind, Colors.KeybindHover)

-- NÚT REFRESH & TELEPORT
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.4, 0, 0, 30)
refreshBtn.Position = UDim2.new(0.075, 0, 0, 335)
refreshBtn.Text = "Refresh"
refreshBtn.Font = Enum.Font.GothamSemibold; refreshBtn.TextSize = 12
refreshBtn.BackgroundColor3 = Colors.BlueBtn; refreshBtn.TextColor3 = Colors.Title
refreshBtn.Parent = pageMain
addCorner(refreshBtn, 6)
applyHover(refreshBtn, Colors.BlueBtn, Colors.BlueBtnHover)

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.4, 0, 0, 30)
tpBtn.Position = UDim2.new(0.525, 0, 0, 335)
tpBtn.Text = "Teleport"
tpBtn.Font = Enum.Font.GothamSemibold; tpBtn.TextSize = 12
tpBtn.BackgroundColor3 = Colors.OrangeBtn; tpBtn.TextColor3 = Colors.Title
tpBtn.Parent = pageMain
addCorner(tpBtn, 6)
applyHover(tpBtn, Colors.OrangeBtn, Colors.OrangeBtnHover)

-- DANH SÁCH CUỘN (ZIndex cao để đè lên các nút)
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(0.85, 0, 0, 100)
playerListFrame.Position = UDim2.new(0.075, 0, 0, 328)
playerListFrame.BackgroundColor3 = Colors.Title
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.ZIndex = 10
playerListFrame.ScrollBarThickness = 3
playerListFrame.ScrollBarImageColor3 = Colors.SliderHandle
playerListFrame.Parent = pageMain
addCorner(playerListFrame, 6)

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = playerListFrame
listLayout.SortOrder = Enum.SortOrder.Name

-- ================= UI: PAGE PROFILE (Tính năng mới) ================= --
-- Avatar
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 100, 0, 100)
avatarImage.Position = UDim2.new(0.5, -50, 0, 10)
avatarImage.BackgroundColor3 = Colors.Keybind
avatarImage.BorderSizePixel = 0
avatarImage.Image = "rbxthumb://type=AvatarBust&id=" .. player.UserId .. "&w=150&h=150"
avatarImage.Parent = pageProfile
addCorner(avatarImage, 50) -- Hình tròn

-- Thông tin Display Name
local profileName = Instance.new("TextLabel")
profileName.Size = UDim2.new(0.9, 0, 0, 25)
profileName.Position = UDim2.new(0.05, 0, 0, 120)
profileName.BackgroundTransparency = 1
profileName.Font = Enum.Font.GothamBold
profileName.TextSize = 18
profileName.TextColor3 = Colors.TextPrimary
profileName.Text = player.DisplayName
profileName.Parent = pageProfile

-- Username (@name)
local profileUser = Instance.new("TextLabel")
profileUser.Size = UDim2.new(0.9, 0, 0, 20)
profileUser.Position = UDim2.new(0.05, 0, 0, 145)
profileUser.BackgroundTransparency = 1
profileUser.Font = Enum.Font.Gotham
profileUser.TextSize = 12
profileUser.TextColor3 = Colors.TextSecondary
profileUser.Text = "@" .. player.Name
profileUser.Parent = pageProfile

-- Khung chứa thông số phụ
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0.85, 0, 0, 80)
statsFrame.Position = UDim2.new(0.075, 0, 0, 185)
statsFrame.BackgroundColor3 = Colors.Keybind
statsFrame.BorderSizePixel = 0
statsFrame.Parent = pageProfile
addCorner(statsFrame, 8)

local idTitle = Instance.new("TextLabel")
idTitle.Size = UDim2.new(1, -20, 0.5, 0)
idTitle.Position = UDim2.new(0, 10, 0, 0)
idTitle.BackgroundTransparency = 1
idTitle.Font = Enum.Font.GothamSemibold
idTitle.TextSize = 12
idTitle.TextColor3 = Colors.TextPrimary
idTitle.TextXAlignment = Enum.TextXAlignment.Left
idTitle.Text = "User ID:"
idTitle.Parent = statsFrame

local idValue = Instance.new("TextLabel")
idValue.Size = UDim2.new(1, -20, 0.5, 0)
idValue.Position = UDim2.new(0, 10, 0, 0)
idValue.BackgroundTransparency = 1
idValue.Font = Enum.Font.Gotham
idValue.TextSize = 12
idValue.TextColor3 = Colors.SliderHandle
idValue.TextXAlignment = Enum.TextXAlignment.Right
idValue.Text = tostring(player.UserId)
idValue.Parent = statsFrame

local ageTitle = Instance.new("TextLabel")
ageTitle.Size = UDim2.new(1, -20, 0.5, 0)
ageTitle.Position = UDim2.new(0, 10, 0.5, 0)
ageTitle.BackgroundTransparency = 1
ageTitle.Font = Enum.Font.GothamSemibold
ageTitle.TextSize = 12
ageTitle.TextColor3 = Colors.TextPrimary
ageTitle.TextXAlignment = Enum.TextXAlignment.Left
ageTitle.Text = "Account Age:"
ageTitle.Parent = statsFrame

local ageValue = Instance.new("TextLabel")
ageValue.Size = UDim2.new(1, -20, 0.5, 0)
ageValue.Position = UDim2.new(0, 10, 0.5, 0)
ageValue.BackgroundTransparency = 1
ageValue.Font = Enum.Font.Gotham
ageValue.TextSize = 12
ageValue.TextColor3 = Colors.SliderHandle
ageValue.TextXAlignment = Enum.TextXAlignment.Right
ageValue.Text = tostring(player.AccountAge) .. " Days"
ageValue.Parent = statsFrame

-- ================= LOGIC ĐIỀU KHIỂN & CHỨC NĂNG ================= --
local draggingSlider, draggingWeight, draggingFly = false, false, false
local weightForce, flyVelocity, moveY = nil, nil, 0
local keybinds = { Speed = nil, Weight = nil, Fly = nil, Noclip = nil }
local bindingTarget, bindingBtn = nil, nil

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

local function toggleColor(btn, state)
    local targetColor = state and Colors.BtnOn or Colors.BtnOff
    local targetTextColor = state and Colors.Title or Colors.TextPrimary
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

-- ================= SỰ KIỆN PHÍM ================= --
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
            bindingTarget = nil; bindingBtn = nil
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
                TS:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                task.delay(0.3, function()
                    frame.Visible = false; frame.Size = UDim2.new(0, 240, 0, 480)
                    miniIcon.Visible = true; miniIcon.Size = UDim2.new(0, 0, 0, 0)
                    TS:Create(miniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
                end)
            else
                frame.Position = miniIcon.Position
                TS:Create(miniIcon, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                task.delay(0.15, function()
                    miniIcon.Visible = false; miniIcon.Size = UDim2.new(0, 45, 0, 45)
                    frame.Visible = true; frame.Size = UDim2.new(0, 0, 0, 0)
                    TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 480)}):Play()
                end)
            end
        end

        if input.KeyCode == Enum.KeyCode.Space then moveY = 1 end
        if input.KeyCode == Enum.KeyCode.LeftShift then moveY = -1 end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then moveY = 0 end
end)

-- ================= KÉO UI ================= --
local function makeDraggable(dragHandle, targetFrame)
    targetFrame = targetFrame or dragHandle
    local dragging, dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = targetFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TS:Create(targetFrame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
end
makeDraggable(title, frame); makeDraggable(miniIcon, miniIcon)

-- ================= GAME LOOP ================= --
local loopConnection, noclipConnection
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
                local look, right = cam.CFrame.LookVector, cam.CFrame.RightVector
                local flatLook = Vector3.new(look.X, 0, look.Z); if flatLook.Magnitude > 0 then flatLook = flatLook.Unit end
                local flatRight = Vector3.new(right.X, 0, right.Z); if flatRight.Magnitude > 0 then flatRight = flatRight.Unit end
                
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

-- ================= TELEPORT LOGIC ================= --
local function updatePlayerList()
    for _, child in pairs(playerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yOffset = 0
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.BackgroundColor3 = Colors.Keybind; btn.TextColor3 = Colors.TextPrimary
            btn.Text = "  " .. p.Name; btn.Font = Enum.Font.Gotham; btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left; btn.BorderSizePixel = 0
            btn.ZIndex = 11; btn.Parent = playerListFrame
            applyHover(btn, Colors.Keybind, Colors.KeybindHover)
            btn.MouseButton1Click:Connect(function()
                tpDropdownBtn.Text = p.Name; playerListFrame.Visible = false
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
    updatePlayerList(); tpDropdownBtn.Text = "Chọn người chơi..."
    refreshBtn.Text = "Updated!"
    task.delay(1, function() if refreshBtn then refreshBtn.Text = "Refresh" end end)
end)

tpBtn.MouseButton1Click:Connect(function()
    local targetPlayer = game.Players:FindFirstChild(tpDropdownBtn.Text)
    if targetPlayer and targetPlayer.Character then
        local targetCFrame = targetPlayer.Character:GetPivot()
        local myRoot = getTargetRoot()
        if targetCFrame and myRoot then
            myRoot.AssemblyLinearVelocity = Vector3.zero; myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = targetCFrame * CFrame.new(0, 3, 3)
            tpBtn.Text = "Teleported!"
            task.delay(1, function() if tpBtn then tpBtn.Text = "Teleport" end end)
        end
    else
        tpBtn.Text = "Target Loading!"
        task.delay(1.5, function() if tpBtn then tpBtn.Text = "Teleport" end end)
    end
end)

-- ================= MINIMIZE & CLOSE ================= --
miniBtn.MouseButton1Click:Connect(function()
    miniIcon.Position = frame.Position
    TS:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.3, function()
        frame.Visible = false; frame.Size = UDim2.new(0, 240, 0, 480)
        miniIcon.Visible = true; miniIcon.Size = UDim2.new(0, 0, 0, 0)
        TS:Create(miniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
    end)
end)

miniIcon.MouseButton1Click:Connect(function()
    frame.Position = miniIcon.Position
    TS:Create(miniIcon, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.15, function()
        miniIcon.Visible = false; miniIcon.Size = UDim2.new(0, 45, 0, 45)
        frame.Visible = true; frame.Size = UDim2.new(0, 0, 0, 0)
        TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 480)}):Play()
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    enabled = false; weightEnabled = false; flyEnabled = false; noclipEnabled = false
    local hum = getHumanoid(); if hum then hum.WalkSpeed = 16 end
    removeWeight(); stopFly()
    
    local char = player.Character
    if char then
        for _, name in ipairs({"HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso"}) do
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
sliderBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
weightBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingWeight = true end end)
flyBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingFly = true end end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if draggingSlider then
            local p = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X)/sliderBar.AbsoluteSize.X, 0, 1)
            slider.Position = UDim2.new(p, -7, 0.5, -7); speedValue = math.floor(p * 1000); speedText.Text = "Speed: " .. speedValue
        end
        if draggingWeight then
            local p = math.clamp((input.Position.X - weightBar.AbsolutePosition.X)/weightBar.AbsoluteSize.X, 0, 1)
            weightSlider.Position = UDim2.new(p, -7, 0.5, -7); weightValue = math.floor(p * 1000); weightText.Text = "Weight: " .. weightValue
        end
        if draggingFly then
            local p = math.clamp((input.Position.X - flyBar.AbsolutePosition.X)/flyBar.AbsoluteSize.X, 0, 1)
            flySlider.Position = UDim2.new(p, -7, 0.5, -7); flySpeed = math.floor(p * 1000); flyText.Text = "Fly Speed: " .. flySpeed
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false; draggingWeight = false; draggingFly = false
    end
end)
