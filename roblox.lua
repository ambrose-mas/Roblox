local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local playerGui = player:WaitForChild("PlayerGui")

-- ================= BẢNG MÀU SANG TRỌNG & RỰC RỠ (LUXURY THEME) ================= --
local Colors = {
    Background = Color3.fromRGB(24, 24, 30),       -- Xám đậm sang trọng
    Title = Color3.fromRGB(15, 15, 20),            -- Đen ánh xanh sâu
    BtnOff = Color3.fromRGB(40, 40, 48),           -- Xám kim loại
    BtnOn = Color3.fromRGB(255, 190, 60),          -- Vàng kim (Gold) rực rỡ
    BtnHover = Color3.fromRGB(55, 55, 65),         -- Xám sáng khi di chuột
    BtnOnHover = Color3.fromRGB(255, 215, 100),    -- Vàng sáng chói
    Keybind = Color3.fromRGB(35, 35, 42),          
    KeybindHover = Color3.fromRGB(45, 45, 55),     
    SliderBg = Color3.fromRGB(45, 45, 55),         
    SliderHandle = Color3.fromRGB(255, 190, 60),   -- Kéo trượt màu vàng kim
    TextPrimary = Color3.fromRGB(250, 250, 250),   -- Trắng tinh khiết
    TextSecondary = Color3.fromRGB(160, 160, 170), -- Xám nhạt
    RedBtn = Color3.fromRGB(255, 80, 80),          -- Đỏ san hô
    RedBtnHover = Color3.fromRGB(255, 110, 110),   
    BlueBtn = Color3.fromRGB(90, 170, 255),        -- Xanh thiên thanh sáng
    BlueBtnHover = Color3.fromRGB(120, 190, 255),  
    OrangeBtn = Color3.fromRGB(255, 120, 90),      -- Cam hoàng hôn rực
    OrangeBtnHover = Color3.fromRGB(255, 145, 120) 
}

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LuxurySpeedMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- ================= HÀM HỖ TRỢ LÀM ĐẸP UI ================= --
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
frame.Size = UDim2.new(0, 420, 0, 610) 
frame.Position = UDim2.new(0.5, -210, 0.5, -305)
frame.BackgroundColor3 = Colors.Background
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
addCorner(frame, 12)

-- Đổ bóng (Glow mờ)
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Colors.BtnOn
uiStroke.Transparency = 0.5
uiStroke.Thickness = 1.5
uiStroke.Parent = frame

-- MINI BUTTON (Nút khi thu nhỏ)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 45, 0, 45)
miniIcon.Position = UDim2.new(0.5, -22, 0, 20)
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
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Colors.Title
title.Text = " ⚡ LUXURY HUB ⚡ "
title.Font = Enum.Font.GothamBlack
title.TextSize = 15
title.TextColor3 = Colors.BtnOn
title.Active = true
title.Parent = frame
addCorner(title, 12)

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 12)
titleFix.Position = UDim2.new(0, 0, 1, -12)
titleFix.BackgroundColor3 = Colors.Title
titleFix.BorderSizePixel = 0
titleFix.Parent = title

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Colors.RedBtn
closeBtn.Parent = frame
addCorner(closeBtn, 10)

closeBtn.MouseEnter:Connect(function() TS:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Colors.TextPrimary, BackgroundTransparency = 0, BackgroundColor3 = Colors.RedBtn}):Play() end)
closeBtn.MouseLeave:Connect(function() TS:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Colors.RedBtn, BackgroundTransparency = 1}):Play() end)

local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 40, 0, 40)
miniBtn.Position = UDim2.new(1, -80, 0, 0)
miniBtn.Text = "—"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 14
miniBtn.BackgroundTransparency = 1
miniBtn.TextColor3 = Colors.TextPrimary
miniBtn.Parent = frame
addCorner(miniBtn, 10)

miniBtn.MouseEnter:Connect(function() TS:Create(miniBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = Colors.BtnHover}):Play() end)
miniBtn.MouseLeave:Connect(function() TS:Create(miniBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play() end)

local playerListFrame = Instance.new("ScrollingFrame")

-- ================= HỆ THỐNG TABS VỚI HIỆU ỨNG ================= --
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -30, 0, 36)
tabContainer.Position = UDim2.new(0, 15, 0, 50)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = frame

local tabMainBtn = Instance.new("TextButton")
tabMainBtn.Size = UDim2.new(0.32, 0, 1, 0)
tabMainBtn.Position = UDim2.new(0, 0, 0, 0)
tabMainBtn.Text = "Main"
tabMainBtn.Font = Enum.Font.GothamBold
tabMainBtn.TextSize = 13
tabMainBtn.BackgroundColor3 = Colors.BtnHover
tabMainBtn.TextColor3 = Colors.BtnOn
tabMainBtn.Parent = tabContainer
addCorner(tabMainBtn, 6)

local tabServerBtn = Instance.new("TextButton")
tabServerBtn.Size = UDim2.new(0.32, 0, 1, 0)
tabServerBtn.Position = UDim2.new(0.34, 0, 0, 0)
tabServerBtn.Text = "Server"
tabServerBtn.Font = Enum.Font.GothamBold
tabServerBtn.TextSize = 13
tabServerBtn.BackgroundColor3 = Colors.BtnOff
tabServerBtn.TextColor3 = Colors.TextSecondary
tabServerBtn.Parent = tabContainer
addCorner(tabServerBtn, 6)

local tabProfileBtn = Instance.new("TextButton")
tabProfileBtn.Size = UDim2.new(0.32, 0, 1, 0)
tabProfileBtn.Position = UDim2.new(0.68, 0, 0, 0)
tabProfileBtn.Text = "Profile"
tabProfileBtn.Font = Enum.Font.GothamBold
tabProfileBtn.TextSize = 13
tabProfileBtn.BackgroundColor3 = Colors.BtnOff
tabProfileBtn.TextColor3 = Colors.TextSecondary
tabProfileBtn.Parent = tabContainer
addCorner(tabProfileBtn, 6)

local pagesContainer = Instance.new("Frame")
pagesContainer.Size = UDim2.new(1, 0, 1, -100)
pagesContainer.Position = UDim2.new(0, 0, 0, 100)
pagesContainer.BackgroundTransparency = 1
pagesContainer.ClipsDescendants = true
pagesContainer.Parent = frame

local pageMain = Instance.new("Frame")
pageMain.Size = UDim2.new(1, 0, 1, 0)
pageMain.Position = UDim2.new(0, 0, 0, 0)
pageMain.BackgroundTransparency = 1
pageMain.Parent = pagesContainer

local pageServer = Instance.new("Frame")
pageServer.Size = UDim2.new(1, 0, 1, 0)
pageServer.Position = UDim2.new(1, 0, 0, 0) 
pageServer.BackgroundTransparency = 1
pageServer.Parent = pagesContainer

local pageProfile = Instance.new("Frame")
pageProfile.Size = UDim2.new(1, 0, 1, 0)
pageProfile.Position = UDim2.new(1, 0, 0, 0)
pageProfile.BackgroundTransparency = 1
pageProfile.Parent = pagesContainer

local pagesList = {pageMain, pageServer, pageProfile}
local tabBtns = {tabMainBtn, tabServerBtn, tabProfileBtn}

local function switchTab(index)
    if playerListFrame and playerListFrame.Visible then
        playerListFrame.Visible = false
    end

    for i, p in ipairs(pagesList) do
        local targetPos
        if i < index then
            targetPos = UDim2.new(-1, 0, 0, 0)
        elseif i > index then
            targetPos = UDim2.new(1, 0, 0, 0)
        else
            targetPos = UDim2.new(0, 0, 0, 0)
        end
        TS:Create(p, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    end

    for i, btn in ipairs(tabBtns) do
        local isAct = (i == index)
        local bgCol = isAct and Colors.BtnHover or Colors.BtnOff
        local txtCol = isAct and Colors.BtnOn or Colors.TextSecondary
        TS:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = bgCol, TextColor3 = txtCol}):Play()
    end
end

tabMainBtn.MouseButton1Click:Connect(function() switchTab(1) end)
tabServerBtn.MouseButton1Click:Connect(function() switchTab(2) end)
tabProfileBtn.MouseButton1Click:Connect(function() switchTab(3) end)


-- ================= LOGIC BIẾN ================= --
local enabled, weightEnabled, lowGravEnabled, flyEnabled, noclipEnabled = false, false, false, false, false
-- Mặc định trị số lowGravValue = 500
local speedValue, weightValue, lowGravValue, flySpeed = 16, 0, 500, 50

-- ================= UI: PAGE MAIN ================= --
local mainLayout = Instance.new("UIListLayout")
mainLayout.Parent = pageMain
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Padding = UDim.new(0, 12)
mainLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createModule(name, order, getStat, textValue)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 45)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = order
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.7, 0, 0, 36)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.Text = name .. ": OFF"
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 13
    toggle.BackgroundColor3 = Colors.BtnOff
    toggle.TextColor3 = Colors.TextPrimary
    toggle.Parent = frame
    addCorner(toggle, 6)
    applyHover(toggle, Colors.BtnOff, Colors.BtnHover, true, getStat)

    local keybtn = Instance.new("TextButton")
    keybtn.Size = UDim2.new(0.25, 0, 0, 36)
    keybtn.Position = UDim2.new(0.75, 0, 0, 0)
    keybtn.Text = "None"
    keybtn.Font = Enum.Font.Gotham
    keybtn.TextSize = 12
    keybtn.BackgroundColor3 = Colors.Keybind
    keybtn.TextColor3 = Colors.TextSecondary
    keybtn.Parent = frame
    addCorner(keybtn, 6)
    applyHover(keybtn, Colors.Keybind, Colors.KeybindHover)

    return frame, toggle, keybtn
end

local function createSlider(name, order, defaultVal, maxVal)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 25)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = order
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.7, 0, 0, 6) 
    bar.Position = UDim2.new(0, 0, 0.5, -3)
    bar.BackgroundColor3 = Colors.SliderBg
    bar.Parent = frame
    addCorner(bar, 100)

    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 16, 0, 16)
    handle.Position = UDim2.new(defaultVal/maxVal, -8, 0.5, -8)
    handle.BackgroundColor3 = Colors.SliderHandle
    handle.Parent = bar
    addCorner(handle, 100)

    local txt = Instance.new("TextBox")
    txt.Size = UDim2.new(0.25, 0, 1, 0)
    txt.Position = UDim2.new(0.75, 0, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamSemibold
    txt.TextSize = 12
    txt.TextColor3 = Colors.TextSecondary
    txt.Text = tostring(defaultVal)
    txt.ClearTextOnFocus = false
    txt.Parent = frame

    return frame, bar, handle, txt
end

-- Speed
local speedMod, speedToggle, speedKey = createModule("Speed", 1, function() return enabled end)
speedMod.Parent = pageMain
local speedSliderMod, speedBar, speedHandle, speedTxt = createSlider("Speed", 2, 16, 1000)
speedSliderMod.Parent = pageMain

-- Weight (Làm nặng)
local weightMod, weightToggle, weightKey = createModule("Weight", 3, function() return weightEnabled end)
weightMod.Parent = pageMain
local weightSliderMod, weightBar, weightHandle, weightTxt = createSlider("Weight", 4, 0, 1000)
weightSliderMod.Parent = pageMain

-- Low Grav (Làm nhẹ) MAX 1000
local lowGravMod, lowGravToggle, lowGravKey = createModule("Low Grav", 5, function() return lowGravEnabled end)
lowGravMod.Parent = pageMain
local lowGravSliderMod, lowGravBar, lowGravHandle, lowGravTxt = createSlider("Low Grav", 6, 500, 1000) 
lowGravSliderMod.Parent = pageMain

-- Fly
local flyMod, flyToggle, flyKey = createModule("Fly", 7, function() return flyEnabled end)
flyMod.Parent = pageMain
local flySliderMod, flyBar, flyHandle, flyTxt = createSlider("Fly", 8, 50, 1000)
flySliderMod.Parent = pageMain

-- Noclip
local noclipMod, noclipToggle, noclipKey = createModule("Noclip", 9, function() return noclipEnabled end)
noclipMod.Parent = pageMain

-- Khoảng trống
local spacer = Instance.new("Frame")
spacer.Size = UDim2.new(1, 0, 0, 5)
spacer.BackgroundTransparency = 1
spacer.LayoutOrder = 10
spacer.Parent = pageMain

-- Teleport Tool
local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(0.9, 0, 0, 36)
tpFrame.BackgroundTransparency = 1
tpFrame.LayoutOrder = 11
tpFrame.Parent = pageMain

local tpDropdownBtn = Instance.new("TextButton")
tpDropdownBtn.Size = UDim2.new(0.55, 0, 1, 0)
tpDropdownBtn.Text = "Chọn người chơi..."
tpDropdownBtn.Font = Enum.Font.Gotham
tpDropdownBtn.TextSize = 12
tpDropdownBtn.BackgroundColor3 = Colors.Keybind
tpDropdownBtn.TextColor3 = Colors.TextPrimary
tpDropdownBtn.Parent = tpFrame
addCorner(tpDropdownBtn, 6)
applyHover(tpDropdownBtn, Colors.Keybind, Colors.KeybindHover)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.2, 0, 1, 0)
refreshBtn.Position = UDim2.new(0.575, 0, 0, 0)
refreshBtn.Text = "Làm mới"
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextSize = 11
refreshBtn.BackgroundColor3 = Colors.BlueBtn
refreshBtn.TextColor3 = Colors.Title
refreshBtn.Parent = tpFrame
addCorner(refreshBtn, 6)
applyHover(refreshBtn, Colors.BlueBtn, Colors.BlueBtnHover)

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.2, 0, 1, 0)
tpBtn.Position = UDim2.new(0.8, 0, 0, 0)
tpBtn.Text = "Teleport"
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 11
tpBtn.BackgroundColor3 = Colors.OrangeBtn
tpBtn.TextColor3 = Colors.Title
tpBtn.Parent = tpFrame
addCorner(tpBtn, 6)
applyHover(tpBtn, Colors.OrangeBtn, Colors.OrangeBtnHover)

-- Dropdown
playerListFrame.Size = UDim2.new(0.55, 0, 0, 120)
playerListFrame.Position = UDim2.new(0.05, 0, 0, 475)
playerListFrame.BackgroundColor3 = Colors.Title
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.ZIndex = 10
playerListFrame.ScrollBarThickness = 4
playerListFrame.ScrollBarImageColor3 = Colors.SliderHandle
playerListFrame.Parent = frame 
addCorner(playerListFrame, 6)

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = playerListFrame
listLayout.SortOrder = Enum.SortOrder.Name


-- ================= UI: PAGE SERVER ================= --
local serverLayout = Instance.new("UIListLayout")
serverLayout.Parent = pageServer
serverLayout.SortOrder = Enum.SortOrder.LayoutOrder
serverLayout.Padding = UDim.new(0, 15)
serverLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createServerBtn(text, color, hoverColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = color
    btn.TextColor3 = color == Colors.BtnOff and Colors.TextPrimary or Colors.Title
    addCorner(btn, 8)
    applyHover(btn, color, hoverColor)
    return btn
end

local rejoinBtn = createServerBtn("Rejoin Server", Colors.BtnOff, Colors.BtnHover)
rejoinBtn.Parent = pageServer

local randomServerBtn = createServerBtn("Join Random Server", Colors.BlueBtn, Colors.BlueBtnHover)
randomServerBtn.Parent = pageServer

local smallServerBtn = createServerBtn("Join Smallest Server", Colors.OrangeBtn, Colors.OrangeBtnHover)
smallServerBtn.Parent = pageServer

local copyJobBtn = createServerBtn("Copy Server JobId", Colors.Keybind, Colors.KeybindHover)
copyJobBtn.TextColor3 = Colors.BtnOn
copyJobBtn.Parent = pageServer


-- ================= UI: PAGE PROFILE ================= --
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 110, 0, 110)
avatarImage.Position = UDim2.new(0.5, -55, 0, 15)
avatarImage.BackgroundColor3 = Colors.Keybind
avatarImage.BorderSizePixel = 0
avatarImage.Image = "rbxthumb://type=AvatarBust&id=" .. player.UserId .. "&w=150&h=150"
avatarImage.Parent = pageProfile
addCorner(avatarImage, 100) 

local profileName = Instance.new("TextLabel")
profileName.Size = UDim2.new(0.9, 0, 0, 30)
profileName.Position = UDim2.new(0.05, 0, 0, 135)
profileName.BackgroundTransparency = 1
profileName.Font = Enum.Font.GothamBlack
profileName.TextSize = 22
profileName.TextColor3 = Colors.BtnOn
profileName.Text = player.DisplayName
profileName.Parent = pageProfile

local profileUser = Instance.new("TextLabel")
profileUser.Size = UDim2.new(0.9, 0, 0, 20)
profileUser.Position = UDim2.new(0.05, 0, 0, 165)
profileUser.BackgroundTransparency = 1
profileUser.Font = Enum.Font.Gotham
profileUser.TextSize = 14
profileUser.TextColor3 = Colors.TextSecondary
profileUser.Text = "@" .. player.Name
profileUser.Parent = pageProfile

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0.85, 0, 0, 90)
statsFrame.Position = UDim2.new(0.075, 0, 0, 210)
statsFrame.BackgroundColor3 = Colors.Keybind
statsFrame.BorderSizePixel = 0
statsFrame.Parent = pageProfile
addCorner(statsFrame, 10)

local function addStatText(yScale, title, val)
    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, -30, 0.5, 0)
    tLabel.Position = UDim2.new(0, 15, yScale, 0)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 13
    tLabel.TextColor3 = Colors.TextPrimary
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.Text = title
    tLabel.Parent = statsFrame

    local vLabel = Instance.new("TextLabel")
    vLabel.Size = UDim2.new(1, -30, 0.5, 0)
    vLabel.Position = UDim2.new(0, 15, yScale, 0)
    vLabel.BackgroundTransparency = 1
    vLabel.Font = Enum.Font.Gotham
    vLabel.TextSize = 13
    vLabel.TextColor3 = Colors.BlueBtn
    vLabel.TextXAlignment = Enum.TextXAlignment.Right
    vLabel.Text = val
    vLabel.Parent = statsFrame
end

addStatText(0, "User ID:", tostring(player.UserId))
addStatText(0.5, "Account Age:", tostring(player.AccountAge) .. " Days")


-- ================= LOGIC ĐIỀU KHIỂN & CHỨC NĂNG ================= --
local draggingSlider, draggingWeight, draggingLowGrav, draggingFly = false, false, false, false
local weightForce, lowGravForce, flyVelocity, moveY = nil, nil, nil, 0
local keybinds = { Speed = nil, Weight = nil, LowGrav = nil, Fly = nil, Noclip = nil }
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

-- LOGIC LOW GRAV MỚI: Chỉ giảm tốc độ rơi, không làm nhảy cao
local function applyLowGrav()
    local root = getTargetRoot()
    if not root then return end
    if not lowGravForce or lowGravForce.Parent ~= root then
        if lowGravForce then pcall(function() lowGravForce:Destroy() end) end
        local att = root:FindFirstChild("LowGravAttachment")
        if not att then
            att = Instance.new("Attachment", root)
            att.Name = "LowGravAttachment"
        end
        lowGravForce = Instance.new("VectorForce")
        lowGravForce.Attachment0 = att
        lowGravForce.RelativeTo = Enum.ActuatorRelativeTo.World
        lowGravForce.Parent = root
    end
    
    -- Kiểm tra nếu người chơi ĐANG RƠI XUỐNG (vận tốc Y < 0)
    if root.AssemblyLinearVelocity.Y < 0 then
        -- Lực đẩy ngược lên chống lại trọng lực (Tỉ lệ 0 -> 1000)
        lowGravForce.Force = Vector3.new(0, workspace.Gravity * root.AssemblyMass * (lowGravValue / 1000), 0)
    else
        -- Nếu đang đứng yên hoặc nhảy lên trên thì hủy lực đẩy để nhảy đúng độ cao gốc
        lowGravForce.Force = Vector3.new(0, 0, 0)
    end
end

local function removeLowGrav()
    if lowGravForce then lowGravForce:Destroy(); lowGravForce = nil end
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
    speedToggle.Text = enabled and "Speed: ON" or "Speed: OFF"
    toggleColor(speedToggle, enabled)
end

local function toggleWeightLogic()
    weightEnabled = not weightEnabled
    weightToggle.Text = weightEnabled and "Weight: ON" or "Weight: OFF"
    toggleColor(weightToggle, weightEnabled)
end

local function toggleLowGravLogic()
    lowGravEnabled = not lowGravEnabled
    lowGravToggle.Text = lowGravEnabled and "Low Grav: ON" or "Low Grav: OFF"
    toggleColor(lowGravToggle, lowGravEnabled)
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

speedToggle.MouseButton1Click:Connect(toggleSpeedLogic)
weightToggle.MouseButton1Click:Connect(toggleWeightLogic)
lowGravToggle.MouseButton1Click:Connect(toggleLowGravLogic)
flyToggle.MouseButton1Click:Connect(toggleFlyLogic)
noclipToggle.MouseButton1Click:Connect(toggleNoclipLogic)

local function setupKeybindButton(btn, targetName)
    btn.MouseButton1Click:Connect(function()
        bindingTarget = targetName
        bindingBtn = btn
        btn.Text = "..."
    end)
end

setupKeybindButton(speedKey, "Speed")
setupKeybindButton(weightKey, "Weight")
setupKeybindButton(lowGravKey, "LowGrav")
setupKeybindButton(flyKey, "Fly")
setupKeybindButton(noclipKey, "Noclip")

-- ================= MINIMIZE / MAXIMIZE LOGIC ================= --
local function toggleMenu()
    if frame.Visible then
        miniIcon.Position = frame.Position
        TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.3, function()
            frame.Visible = false; frame.Size = UDim2.new(0, 420, 0, 610)
            miniIcon.Visible = true; miniIcon.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(miniIcon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
        end)
    else
        frame.Position = miniIcon.Position
        TS:Create(miniIcon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.2, function()
            miniIcon.Visible = false; miniIcon.Size = UDim2.new(0, 45, 0, 45)
            frame.Visible = true; frame.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 610)}):Play()
        end)
    end
end

miniBtn.MouseButton1Click:Connect(toggleMenu)
miniIcon.MouseButton1Click:Connect(toggleMenu)

-- ================= SỰ KIỆN PHÍM & CLICK OUTSIDE ================= --
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

    if playerListFrame.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = input.Position
        local dropMin = playerListFrame.AbsolutePosition
        local dropMax = dropMin + playerListFrame.AbsoluteSize
        local btnMin = tpDropdownBtn.AbsolutePosition
        local btnMax = btnMin + tpDropdownBtn.AbsoluteSize
        
        local inDrop = pos.X >= dropMin.X and pos.X <= dropMax.X and pos.Y >= dropMin.Y and pos.Y <= dropMax.Y
        local inBtn = pos.X >= btnMin.X and pos.X <= btnMax.X and pos.Y >= btnMin.Y and pos.Y <= btnMax.Y
        
        if not inDrop and not inBtn then
            playerListFrame.Visible = false
        end
    end

    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == keybinds["Speed"] then toggleSpeedLogic() end
            if input.KeyCode == keybinds["Weight"] then toggleWeightLogic() end
            if input.KeyCode == keybinds["LowGrav"] then toggleLowGravLogic() end
            if input.KeyCode == keybinds["Fly"] then toggleFlyLogic() end
            if input.KeyCode == keybinds["Noclip"] then toggleNoclipLogic() end
        end

        if (input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.F5) then
            toggleMenu()
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
    if lowGravEnabled then applyLowGrav() else removeLowGrav() end
    
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
    refreshBtn.Text = "Xong!"
    task.delay(1, function() if refreshBtn then refreshBtn.Text = "Làm mới" end end)
end)

tpBtn.MouseButton1Click:Connect(function()
    local targetPlayer = game.Players:FindFirstChild(tpDropdownBtn.Text)
    if targetPlayer and targetPlayer.Character then
        local targetCFrame = targetPlayer.Character:GetPivot()
        local myRoot = getTargetRoot()
        if targetCFrame and myRoot then
            myRoot.AssemblyLinearVelocity = Vector3.zero; myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = targetCFrame * CFrame.new(0, 3, 3)
            tpBtn.Text = "Thành công!"
            task.delay(1, function() if tpBtn then tpBtn.Text = "Teleport" end end)
        end
    else
        tpBtn.Text = "Lỗi Target!"
        task.delay(1.5, function() if tpBtn then tpBtn.Text = "Teleport" end end)
    end
end)

-- ================= SERVER TAB LOGIC ================= --
local function fetchServers()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
    if success and result and result.data then return result.data end
    return {}
end

rejoinBtn.MouseButton1Click:Connect(function()
    rejoinBtn.Text = "Rejoining..."
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

randomServerBtn.MouseButton1Click:Connect(function()
    randomServerBtn.Text = "Finding Server..."
    local servers = fetchServers()
    local validServers = {}
    
    for _, v in pairs(servers) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then table.insert(validServers, v.id) end
    end
    
    if #validServers > 0 then
        randomServerBtn.Text = "Teleporting..."
        local randomId = validServers[math.random(1, #validServers)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, randomId, player)
    else
        randomServerBtn.Text = "No Server Found!"
        task.delay(1.5, function() randomServerBtn.Text = "Join Random Server" end)
    end
end)

smallServerBtn.MouseButton1Click:Connect(function()
    smallServerBtn.Text = "Finding Smallest..."
    local servers = fetchServers()
    local smallestId = nil
    local minPlayers = math.huge
    
    for _, v in pairs(servers) do
        if v.playing < minPlayers and v.playing > 0 and v.id ~= game.JobId then
            minPlayers = v.playing; smallestId = v.id
        end
    end
    
    if smallestId then
        smallServerBtn.Text = "Teleporting..."
        TeleportService:TeleportToPlaceInstance(game.PlaceId, smallestId, player)
    else
        smallServerBtn.Text = "No Server Found!"
        task.delay(1.5, function() smallServerBtn.Text = "Join Smallest Server" end)
    end
end)

copyJobBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(game.JobId)
        copyJobBtn.Text = "Copied to Clipboard!"
    else
        copyJobBtn.Text = "Executor Not Supported!"
    end
    task.delay(1.5, function() copyJobBtn.Text = "Copy Server JobId" end)
end)


closeBtn.MouseButton1Click:Connect(function()
    enabled = false; weightEnabled = false; lowGravEnabled = false; flyEnabled = false; noclipEnabled = false
    local hum = getHumanoid(); if hum then hum.WalkSpeed = 16 end
    removeWeight(); removeLowGrav(); stopFly()
    
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
    
    TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.35, function() gui:Destroy() end)
end)

-- ================= XỬ LÝ SLIDERS (KÉO & NHẬP SỐ) ================= --
speedBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
weightBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingWeight = true end end)
lowGravBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingLowGrav = true end end)
flyBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingFly = true end end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if draggingSlider then
            local p = math.clamp((input.Position.X - speedBar.AbsolutePosition.X)/speedBar.AbsoluteSize.X, 0, 1)
            speedHandle.Position = UDim2.new(p, -8, 0.5, -8); speedValue = math.floor(p * 1000); speedTxt.Text = tostring(speedValue)
        end
        if draggingWeight then
            local p = math.clamp((input.Position.X - weightBar.AbsolutePosition.X)/weightBar.AbsoluteSize.X, 0, 1)
            weightHandle.Position = UDim2.new(p, -8, 0.5, -8); weightValue = math.floor(p * 1000); weightTxt.Text = tostring(weightValue)
        end
        if draggingLowGrav then
            local p = math.clamp((input.Position.X - lowGravBar.AbsolutePosition.X)/lowGravBar.AbsoluteSize.X, 0, 1)
            -- Sửa thanh trượt thành max 1000
            lowGravHandle.Position = UDim2.new(p, -8, 0.5, -8); lowGravValue = math.floor(p * 1000); lowGravTxt.Text = tostring(lowGravValue)
        end
        if draggingFly then
            local p = math.clamp((input.Position.X - flyBar.AbsolutePosition.X)/flyBar.AbsoluteSize.X, 0, 1)
            flyHandle.Position = UDim2.new(p, -8, 0.5, -8); flySpeed = math.floor(p * 1000); flyTxt.Text = tostring(flySpeed)
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false; draggingWeight = false; draggingLowGrav = false; draggingFly = false
    end
end)

-- KHI NGƯỜI DÙNG NHẬP SỐ VÀO TEXTBOX
speedTxt.FocusLost:Connect(function()
    local num = tonumber(speedTxt.Text)
    if not num then num = speedValue end
    num = math.clamp(num, 0, 1000)
    speedValue = math.floor(num)
    speedTxt.Text = tostring(speedValue)
    speedHandle.Position = UDim2.new(speedValue / 1000, -8, 0.5, -8)
end)

weightTxt.FocusLost:Connect(function()
    local num = tonumber(weightTxt.Text)
    if not num then num = weightValue end
    num = math.clamp(num, 0, 1000)
    weightValue = math.floor(num)
    weightTxt.Text = tostring(weightValue)
    weightHandle.Position = UDim2.new(weightValue / 1000, -8, 0.5, -8)
end)

lowGravTxt.FocusLost:Connect(function()
    local num = tonumber(lowGravTxt.Text)
    if not num then num = lowGravValue end
    -- Cho phép max là 1000
    num = math.clamp(num, 0, 1000)
    lowGravValue = math.floor(num)
    lowGravTxt.Text = tostring(lowGravValue)
    lowGravHandle.Position = UDim2.new(lowGravValue / 1000, -8, 0.5, -8)
end)

flyTxt.FocusLost:Connect(function()
    local num = tonumber(flyTxt.Text)
    if not num then num = flySpeed end
    num = math.clamp(num, 0, 1000)
    flySpeed = math.floor(num)
    flyTxt.Text = tostring(flySpeed)
    flyHandle.Position = UDim2.new(flySpeed / 1000, -8, 0.5, -8)
end)
