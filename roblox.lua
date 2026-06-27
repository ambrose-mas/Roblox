local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local playerGui = player:WaitForChild("PlayerGui")
local isScriptActive = true -- Biến kiểm soát toàn cục giúp hủy vòng lặp ngầm khi đóng script

-- ================= BẢNG MÀU SANG TRỌNG & RỰC RỠ (LUXURY THEME) ================= --
local Colors = {
    Background = Color3.fromRGB(24, 24, 30),       
    Title = Color3.fromRGB(15, 15, 20),            
    BtnOff = Color3.fromRGB(40, 40, 48),           
    BtnOn = Color3.fromRGB(255, 190, 60),          
    BtnHover = Color3.fromRGB(55, 55, 65),         
    BtnOnHover = Color3.fromRGB(255, 215, 100),    
    Keybind = Color3.fromRGB(35, 35, 42),          
    KeybindHover = Color3.fromRGB(45, 45, 55),     
    SliderBg = Color3.fromRGB(45, 45, 55),         
    SliderHandle = Color3.fromRGB(255, 190, 60),   
    TextPrimary = Color3.fromRGB(250, 250, 250),   
    TextSecondary = Color3.fromRGB(160, 160, 170), 
    RedBtn = Color3.fromRGB(255, 80, 80),          
    RedBtnHover = Color3.fromRGB(255, 110, 110),   
    BlueBtn = Color3.fromRGB(90, 170, 255),        
    BlueBtnHover = Color3.fromRGB(120, 190, 255),  
    OrangeBtn = Color3.fromRGB(255, 120, 90),      
    OrangeBtnHover = Color3.fromRGB(255, 145, 120) 
}

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LuxurySpeedMenu_V4"
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

local function toggleColor(btn, state)
    local targetColor = state and Colors.BtnOn or Colors.BtnOff
    local targetTextColor = state and Colors.Title or Colors.TextPrimary
    TS:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor, TextColor3 = targetTextColor}):Play()
end

-- ================= MAIN FRAME ================= --
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 650, 0, 520)
frame.Position = UDim2.new(0.5, -325, 0.5, -260)
frame.BackgroundColor3 = Colors.Background
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
addCorner(frame, 12)

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Colors.BtnOn
uiStroke.Transparency = 0.5
uiStroke.Thickness = 1.5
uiStroke.Parent = frame

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

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Colors.Title
title.Text = " ⚡ LUXURY HUB V4 ⚡ "
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


-- ================= HỆ THỐNG 4 TABS ================= --
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -30, 0, 36)
tabContainer.Position = UDim2.new(0, 15, 0, 50)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = frame

local function createTabBtn(text, xPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.Position = UDim2.new(xPos, 0, 0, 0)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BackgroundColor3 = Colors.BtnOff
    btn.TextColor3 = Colors.TextSecondary
    btn.Parent = tabContainer
    addCorner(btn, 6)
    return btn
end

local tabMainBtn = createTabBtn("Main", 0)
local tabWorldBtn = createTabBtn("World", 0.25)
local tabServerBtn = createTabBtn("Server", 0.50)
local tabProfileBtn = createTabBtn("Profile", 0.75)

local pagesContainer = Instance.new("Frame")
pagesContainer.Size = UDim2.new(1, 0, 1, -100)
pagesContainer.Position = UDim2.new(0, 0, 0, 100)
pagesContainer.BackgroundTransparency = 1
pagesContainer.ClipsDescendants = true
pagesContainer.Parent = frame

local function createPage()
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(1, 0, 0, 0)
    page.BackgroundTransparency = 1
    page.Parent = pagesContainer
    return page
end

local pageMain = createPage(); pageMain.Position = UDim2.new(0, 0, 0, 0)
local pageWorld = createPage()
local pageServer = createPage()
local pageProfile = createPage()

local pagesList = {pageMain, pageWorld, pageServer, pageProfile}
local tabBtns = {tabMainBtn, tabWorldBtn, tabServerBtn, tabProfileBtn}
local playerListFrame = Instance.new("ScrollingFrame") 

local function switchTab(index)
    if playerListFrame and playerListFrame.Visible then playerListFrame.Visible = false end

    for i, p in ipairs(pagesList) do
        local targetPos = (i < index) and UDim2.new(-1, 0, 0, 0) or (i > index) and UDim2.new(1, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
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
tabWorldBtn.MouseButton1Click:Connect(function() switchTab(2) end)
tabServerBtn.MouseButton1Click:Connect(function() switchTab(3) end)
tabProfileBtn.MouseButton1Click:Connect(function() switchTab(4) end)
switchTab(1)

-- ================= UI: LAYOUT ================= --
local mainTop = Instance.new("Frame"); mainTop.Size = UDim2.new(1, 0, 0.72, 0); mainTop.BackgroundTransparency = 1; mainTop.Parent = pageMain
local bottomCol = Instance.new("Frame"); bottomCol.Size = UDim2.new(0.96, 0, 0.28, 0); bottomCol.Position = UDim2.new(0.02, 0, 0.72, 0); bottomCol.BackgroundTransparency = 1; bottomCol.Parent = pageMain
local leftCol = Instance.new("Frame"); leftCol.Size = UDim2.new(0.48, 0, 1, 0); leftCol.Position = UDim2.new(0.01, 0, 0, 0); leftCol.BackgroundTransparency = 1; leftCol.Parent = mainTop
local leftLayout = Instance.new("UIListLayout"); leftLayout.Parent = leftCol; leftLayout.SortOrder = Enum.SortOrder.LayoutOrder; leftLayout.Padding = UDim.new(0, 8); leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local rightCol = Instance.new("Frame"); rightCol.Size = UDim2.new(0.48, 0, 1, 0); rightCol.Position = UDim2.new(0.51, 0, 0, 0); rightCol.BackgroundTransparency = 1; rightCol.Parent = mainTop
local rightLayout = Instance.new("UIListLayout"); rightLayout.Parent = rightCol; rightLayout.SortOrder = Enum.SortOrder.LayoutOrder; rightLayout.Padding = UDim.new(0, 8); rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createModule(parent, name, order, getStat)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = order
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.7, 0, 0, 34)
    toggle.Text = name .. ": OFF"
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.BackgroundColor3 = Colors.BtnOff
    toggle.TextColor3 = Colors.TextPrimary
    toggle.Parent = frame
    addCorner(toggle, 6)
    applyHover(toggle, Colors.BtnOff, Colors.BtnHover, true, getStat)

    local keybtn = Instance.new("TextButton")
    keybtn.Size = UDim2.new(0.27, 0, 0, 34)
    keybtn.Position = UDim2.new(0.73, 0, 0, 0)
    keybtn.Text = "None"
    keybtn.Font = Enum.Font.Gotham
    keybtn.TextSize = 11
    keybtn.BackgroundColor3 = Colors.Keybind
    keybtn.TextColor3 = Colors.TextSecondary
    keybtn.Parent = frame
    addCorner(keybtn, 6)
    applyHover(keybtn, Colors.Keybind, Colors.KeybindHover)

    frame.Parent = parent
    return frame, toggle, keybtn
end

local function createSlider(parent, order, defaultVal, maxVal)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 25)
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
    txt.Size = UDim2.new(0.27, 0, 1, 0)
    txt.Position = UDim2.new(0.73, 0, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamSemibold
    txt.TextSize = 12
    txt.TextColor3 = Colors.TextSecondary
    txt.Text = tostring(defaultVal)
    txt.ClearTextOnFocus = false
    txt.Parent = frame

    frame.Parent = parent
    return frame, bar, handle, txt
end

-- ================= KHAI BÁO BIẾN & UI ================= --
local enabled, weightEnabled, lowGravEnabled, flyEnabled, noclipEnabled = false, false, false, false, false
local autoClickEnabled, espEnabled, fogEnabled = false, false, false
local infJumpEnabled, fullBrightEnabled, timeEnabled = false, false, false

local speedValue, weightValue, lowGravValue, flySpeed = 16, 0, 500, 50
local autoClickCps = 10
local timeValue = 14

-- CỘT TRÁI (MAIN)
local _, speedToggle, speedKey = createModule(leftCol, "Speed", 1, function() return enabled end)
local _, speedBar, speedHandle, speedTxt = createSlider(leftCol, 2, 16, 1000)
local _, weightToggle, weightKey = createModule(leftCol, "Weight", 3, function() return weightEnabled end)
local _, weightBar, weightHandle, weightTxt = createSlider(leftCol, 4, 0, 1000)
local _, lowGravToggle, lowGravKey = createModule(leftCol, "Low Grav", 5, function() return lowGravEnabled end)
local _, lowGravBar, lowGravHandle, lowGravTxt = createSlider(leftCol, 6, 500, 1000) 
local _, noclipToggle, noclipKey = createModule(leftCol, "Noclip", 7, function() return noclipEnabled end)

-- CỘT PHẢI (MAIN)
local _, flyToggle, flyKey = createModule(rightCol, "Fly", 1, function() return flyEnabled end)
local _, flyBar, flyHandle, flyTxt = createSlider(rightCol, 2, 50, 1000)
local _, autoClickToggle, autoClickKey = createModule(rightCol, "Auto Click", 3, function() return autoClickEnabled end)
local _, autoClickBar, autoClickHandle, autoClickTxt = createSlider(rightCol, 4, 10, 50) 
local _, espToggle, espKey = createModule(rightCol, "ESP (Name/Dist)", 5, function() return espEnabled end)
local _, fogToggle, fogKey = createModule(rightCol, "Remove Fog", 6, function() return fogEnabled end)

-- DƯỚI CÙNG (TELEPORT)
local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(1, 0, 0, 36); tpFrame.Position = UDim2.new(0, 0, 0, 10); tpFrame.BackgroundTransparency = 1; tpFrame.Parent = bottomCol
local tpDropdownBtn = Instance.new("TextButton")
tpDropdownBtn.Size = UDim2.new(0.65, 0, 1, 0); tpDropdownBtn.Text = "Chọn người chơi để Teleport..."; tpDropdownBtn.Font = Enum.Font.Gotham; tpDropdownBtn.TextSize = 12; tpDropdownBtn.BackgroundColor3 = Colors.Keybind; tpDropdownBtn.TextColor3 = Colors.TextPrimary; tpDropdownBtn.Parent = tpFrame; addCorner(tpDropdownBtn, 6); applyHover(tpDropdownBtn, Colors.Keybind, Colors.KeybindHover)
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.15, 0, 1, 0); refreshBtn.Position = UDim2.new(0.675, 0, 0, 0); refreshBtn.Text = "Làm mới"; refreshBtn.Font = Enum.Font.GothamBold; refreshBtn.TextSize = 11; refreshBtn.BackgroundColor3 = Colors.BlueBtn; refreshBtn.TextColor3 = Colors.Title; refreshBtn.Parent = tpFrame; addCorner(refreshBtn, 6); applyHover(refreshBtn, Colors.BlueBtn, Colors.BlueBtnHover)
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.15, 0, 1, 0); tpBtn.Position = UDim2.new(0.85, 0, 0, 0); tpBtn.Text = "Teleport"; tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 11; tpBtn.BackgroundColor3 = Colors.OrangeBtn; tpBtn.TextColor3 = Colors.Title; tpBtn.Parent = tpFrame; addCorner(tpBtn, 6); applyHover(tpBtn, Colors.OrangeBtn, Colors.OrangeBtnHover)

playerListFrame.Size = UDim2.new(0.96 * 0.65, 0, 0, 120); playerListFrame.Position = UDim2.new(0.02, 0, 0, 440); playerListFrame.BackgroundColor3 = Colors.Title; playerListFrame.BorderSizePixel = 0; playerListFrame.Visible = false; playerListFrame.ZIndex = 10; playerListFrame.ScrollBarThickness = 4; playerListFrame.ScrollBarImageColor3 = Colors.SliderHandle; playerListFrame.Parent = frame; addCorner(playerListFrame, 6)
local listLayout = Instance.new("UIListLayout"); listLayout.Parent = playerListFrame; listLayout.SortOrder = Enum.SortOrder.Name

-- PAGE WORLD
local worldCenter = Instance.new("Frame"); worldCenter.Size = UDim2.new(0.6, 0, 1, 0); worldCenter.Position = UDim2.new(0.2, 0, 0, 0); worldCenter.BackgroundTransparency = 1; worldCenter.Parent = pageWorld
local wCenterLayout = Instance.new("UIListLayout"); wCenterLayout.Parent = worldCenter; wCenterLayout.SortOrder = Enum.SortOrder.LayoutOrder; wCenterLayout.Padding = UDim.new(0, 15)
local spacerW = Instance.new("Frame"); spacerW.Size = UDim2.new(1,0,0,10); spacerW.BackgroundTransparency = 1; spacerW.LayoutOrder = 0; spacerW.Parent = worldCenter

local _, infJumpToggle, infJumpKey = createModule(worldCenter, "Infinite Jump", 1, function() return infJumpEnabled end)
local _, fullBrightToggle, fullBrightKey = createModule(worldCenter, "Full Bright", 2, function() return fullBrightEnabled end)
local _, timeToggle, timeKey = createModule(worldCenter, "Time Changer", 3, function() return timeEnabled end)
local _, timeBar, timeHandle, timeTxt = createSlider(worldCenter, 4, 14, 24)

-- PAGE SERVER & PROFILE
local serverLayout = Instance.new("UIListLayout"); serverLayout.Parent = pageServer; serverLayout.SortOrder = Enum.SortOrder.LayoutOrder; serverLayout.Padding = UDim.new(0, 15); serverLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local spacerS = Instance.new("Frame"); spacerS.Size = UDim2.new(1,0,0,10); spacerS.BackgroundTransparency = 1; spacerS.LayoutOrder = 0; spacerS.Parent = pageServer

local function createServerBtn(text, color, hoverColor)
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(0.6, 0, 0, 45); btn.Text = text; btn.Font = Enum.Font.GothamBold; btn.TextSize = 14; btn.BackgroundColor3 = color; btn.TextColor3 = color == Colors.BtnOff and Colors.TextPrimary or Colors.Title; addCorner(btn, 8); applyHover(btn, color, hoverColor); return btn
end
local rejoinBtn = createServerBtn("Rejoin Server", Colors.BtnOff, Colors.BtnHover); rejoinBtn.Parent = pageServer
local randomServerBtn = createServerBtn("Join Random Server", Colors.BlueBtn, Colors.BlueBtnHover); randomServerBtn.Parent = pageServer
local smallServerBtn = createServerBtn("Join Smallest Server", Colors.OrangeBtn, Colors.OrangeBtnHover); smallServerBtn.Parent = pageServer
local copyJobBtn = createServerBtn("Copy Server JobId", Colors.Keybind, Colors.KeybindHover); copyJobBtn.TextColor3 = Colors.BtnOn; copyJobBtn.Parent = pageServer

local avatarImage = Instance.new("ImageLabel"); avatarImage.Size = UDim2.new(0, 110, 0, 110); avatarImage.Position = UDim2.new(0.5, -55, 0, 15); avatarImage.BackgroundColor3 = Colors.Keybind; avatarImage.BorderSizePixel = 0; avatarImage.Image = "rbxthumb://type=AvatarBust&id=" .. player.UserId .. "&w=150&h=150"; avatarImage.Parent = pageProfile; addCorner(avatarImage, 100) 
local profileName = Instance.new("TextLabel"); profileName.Size = UDim2.new(1, 0, 0, 30); profileName.Position = UDim2.new(0, 0, 0, 135); profileName.BackgroundTransparency = 1; profileName.Font = Enum.Font.GothamBlack; profileName.TextSize = 24; profileName.TextColor3 = Colors.BtnOn; profileName.Text = player.DisplayName; profileName.Parent = pageProfile
local profileUser = Instance.new("TextLabel"); profileUser.Size = UDim2.new(1, 0, 0, 20); profileUser.Position = UDim2.new(0, 0, 0, 165); profileUser.BackgroundTransparency = 1; profileUser.Font = Enum.Font.Gotham; profileUser.TextSize = 14; profileUser.TextColor3 = Colors.TextSecondary; profileUser.Text = "@" .. player.Name; profileUser.Parent = pageProfile
local statsFrame = Instance.new("Frame"); statsFrame.Size = UDim2.new(0.6, 0, 0, 90); statsFrame.Position = UDim2.new(0.2, 0, 0, 210); statsFrame.BackgroundColor3 = Colors.Keybind; statsFrame.BorderSizePixel = 0; statsFrame.Parent = pageProfile; addCorner(statsFrame, 10)

local function addStatText(yScale, title, val)
    local tLabel = Instance.new("TextLabel"); tLabel.Size = UDim2.new(1, -30, 0.5, 0); tLabel.Position = UDim2.new(0, 15, yScale, 0); tLabel.BackgroundTransparency = 1; tLabel.Font = Enum.Font.GothamBold; tLabel.TextSize = 13; tLabel.TextColor3 = Colors.TextPrimary; tLabel.TextXAlignment = Enum.TextXAlignment.Left; tLabel.Text = title; tLabel.Parent = statsFrame
    local vLabel = Instance.new("TextLabel"); vLabel.Size = UDim2.new(1, -30, 0.5, 0); vLabel.Position = UDim2.new(0, 15, yScale, 0); vLabel.BackgroundTransparency = 1; vLabel.Font = Enum.Font.Gotham; vLabel.TextSize = 13; vLabel.TextColor3 = Colors.BlueBtn; vLabel.TextXAlignment = Enum.TextXAlignment.Right; vLabel.Text = val; vLabel.Parent = statsFrame
end
addStatText(0, "User ID:", tostring(player.UserId)); addStatText(0.5, "Account Age:", tostring(player.AccountAge) .. " Days")


-- ================= CHUẨN HOÁ LOGIC CÁC HÀM TOGGLE (QUAN TRỌNG ĐỂ FIX LỖI KEYBIND & DỌN DẸP) ================= --
local draggingSlider, draggingWeight, draggingLowGrav, draggingFly, draggingTime, draggingAutoClick = false, false, false, false, false, false
local weightForce, lowGravForce, flyVelocity, moveY = nil, nil, nil, 0
local keybinds = {}
local bindingTarget, bindingBtn = nil, nil

local function getHumanoid() local char = player.Character; if char then return char:FindFirstChild("Humanoid") end end
local function getTargetRoot()
    local char = player.Character; if not char then return nil end
    local hum = char:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then return hum.SeatPart.AssemblyRootPart or hum.SeatPart end
    return char:FindFirstChild("HumanoidRootPart")
end

-- SPEED
local function toggleSpeed()
    enabled = not enabled
    speedToggle.Text = enabled and "Speed: ON" or "Speed: OFF"
    toggleColor(speedToggle, enabled)
end
speedToggle.MouseButton1Click:Connect(toggleSpeed)

-- WEIGHT
local function toggleWeight()
    weightEnabled = not weightEnabled
    weightToggle.Text = weightEnabled and "Weight: ON" or "Weight: OFF"
    toggleColor(weightToggle, weightEnabled)
end
weightToggle.MouseButton1Click:Connect(toggleWeight)

-- LOW GRAV
local function toggleLowGrav()
    lowGravEnabled = not lowGravEnabled
    lowGravToggle.Text = lowGravEnabled and "Low Grav: ON" or "Low Grav: OFF"
    toggleColor(lowGravToggle, lowGravEnabled)
end
lowGravToggle.MouseButton1Click:Connect(toggleLowGrav)

-- NOCLIP
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    noclipToggle.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    toggleColor(noclipToggle, noclipEnabled)
    if not noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end
noclipToggle.MouseButton1Click:Connect(toggleNoclip)

-- FLY
local function toggleFly()
    flyEnabled = not flyEnabled
    flyToggle.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    toggleColor(flyToggle, flyEnabled)
    if flyEnabled then
        local root = getTargetRoot()
        if root and not flyVelocity then
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.MaxForce = Vector3.new(1,1,1) * 1e6
            flyVelocity.Parent = root
        end
    else
        if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
    end
end
flyToggle.MouseButton1Click:Connect(toggleFly)

-- AUTO CLICK
local function toggleAutoClick()
    autoClickEnabled = not autoClickEnabled
    autoClickToggle.Text = autoClickEnabled and "Auto Click: ON" or "Auto Click: OFF"
    toggleColor(autoClickToggle, autoClickEnabled)
end
autoClickToggle.MouseButton1Click:Connect(toggleAutoClick)

task.spawn(function()
    while isScriptActive do
        if autoClickEnabled then
            pcall(function()
                if mouse1click then mouse1click() else game:GetService("VirtualUser"):ClickButton1(Vector2.new(9999,9999)) end
            end)
            task.wait(1 / autoClickCps)
        else
            task.wait(0.1)
        end
    end
end)

-- ESP
local espLoop
local function clearESP()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local esp = p.Character.Head:FindFirstChild("LuxESP")
            if esp then esp:Destroy() end
        end
    end
end
local function toggleESP()
    espEnabled = not espEnabled
    espToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    toggleColor(espToggle, espEnabled)
    
    if espEnabled then
        espLoop = RunService.RenderStepped:Connect(function()
            local myHead = player.Character and player.Character:FindFirstChild("Head")
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head; local esp = head:FindFirstChild("LuxESP")
                    if not esp then
                        esp = Instance.new("BillboardGui", head); esp.Name = "LuxESP"; esp.AlwaysOnTop = true
                        esp.Size = UDim2.new(0, 150, 0, 30); esp.StudsOffset = Vector3.new(0, 2, 0)
                        local txt = Instance.new("TextLabel", esp); txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1
                        txt.TextColor3 = Colors.BtnOn; txt.TextStrokeTransparency = 0.5; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                    end
                    if myHead then
                        esp.TextLabel.Text = p.Name .. " [" .. math.floor((myHead.Position - head.Position).Magnitude) .. "m]"
                    else esp.TextLabel.Text = p.Name end
                end
            end
        end)
    else
        if espLoop then espLoop:Disconnect(); espLoop = nil end
        clearESP()
    end
end
espToggle.MouseButton1Click:Connect(toggleESP)

-- REMOVE FOG
local originalFogEnd = game.Lighting.FogEnd
local originalFogStart = game.Lighting.FogStart
local function toggleFog()
    fogEnabled = not fogEnabled
    fogToggle.Text = fogEnabled and "Remove Fog: ON" or "Remove Fog: OFF"
    toggleColor(fogToggle, fogEnabled)
    if fogEnabled then
        originalFogEnd = game.Lighting.FogEnd; originalFogStart = game.Lighting.FogStart
        game.Lighting.FogEnd = 100000; game.Lighting.FogStart = 100000
    else
        game.Lighting.FogEnd = originalFogEnd; game.Lighting.FogStart = originalFogStart
    end
end
fogToggle.MouseButton1Click:Connect(toggleFog)

-- INFINITE JUMP
local function toggleInfJump()
    infJumpEnabled = not infJumpEnabled
    infJumpToggle.Text = infJumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
    toggleColor(infJumpToggle, infJumpEnabled)
end
infJumpToggle.MouseButton1Click:Connect(toggleInfJump)

UIS.JumpRequest:Connect(function()
    if infJumpEnabled then
        local hum = getHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- FULL BRIGHT
local brightLoop
local savedLighting = {}
local function toggleFullBright()
    fullBrightEnabled = not fullBrightEnabled
    fullBrightToggle.Text = fullBrightEnabled and "Full Bright: ON" or "Full Bright: OFF"
    toggleColor(fullBrightToggle, fullBrightEnabled)
    if fullBrightEnabled then
        savedLighting.Ambient = game.Lighting.Ambient
        savedLighting.OutdoorAmbient = game.Lighting.OutdoorAmbient
        savedLighting.Brightness = game.Lighting.Brightness
        savedLighting.GlobalShadows = game.Lighting.GlobalShadows
        
        brightLoop = RunService.RenderStepped:Connect(function()
            game.Lighting.Ambient = Color3.new(1, 1, 1); game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            game.Lighting.Brightness = 2; game.Lighting.GlobalShadows = false
        end)
    else
        if brightLoop then brightLoop:Disconnect(); brightLoop = nil end
        game.Lighting.Ambient = savedLighting.Ambient or Color3.new(0.5, 0.5, 0.5)
        game.Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient or Color3.new(0.5, 0.5, 0.5)
        game.Lighting.Brightness = savedLighting.Brightness or 1
        if savedLighting.GlobalShadows ~= nil then game.Lighting.GlobalShadows = savedLighting.GlobalShadows end
    end
end
fullBrightToggle.MouseButton1Click:Connect(toggleFullBright)

-- TIME CHANGER
local timeLoop
local savedTime = game.Lighting.ClockTime
local function toggleTimeChanger()
    timeEnabled = not timeEnabled
    timeToggle.Text = timeEnabled and "Time Changer: ON" or "Time Changer: OFF"
    toggleColor(timeToggle, timeEnabled)
    if timeEnabled then
        savedTime = game.Lighting.ClockTime
        timeLoop = RunService.RenderStepped:Connect(function() game.Lighting.ClockTime = timeValue end)
    else
        if timeLoop then timeLoop:Disconnect(); timeLoop = nil end
        game.Lighting.ClockTime = savedTime
    end
end
timeToggle.MouseButton1Click:Connect(toggleTimeChanger)


-- ================= GAME LOOP (MAIN PHYSICS) ================= --
local loopConnection, noclipConnection
loopConnection = RunService.RenderStepped:Connect(function()
    local root = getTargetRoot(); local hum = getHumanoid()
    if hum then hum.WalkSpeed = enabled and speedValue or 16 end
    
    if root then
        if weightEnabled then
            if not weightForce or weightForce.Parent ~= root then
                if weightForce then pcall(function() weightForce:Destroy() end) end
                local att = root:FindFirstChild("WeightAtt") or Instance.new("Attachment", root); att.Name = "WeightAtt"
                weightForce = Instance.new("VectorForce", root); weightForce.Attachment0 = att; weightForce.RelativeTo = Enum.ActuatorRelativeTo.World
            end
            weightForce.Force = Vector3.new(0, -workspace.Gravity * root.AssemblyMass * weightValue, 0)
        else
            if weightForce then weightForce:Destroy(); weightForce = nil end
        end

        if lowGravEnabled then
            if not lowGravForce or lowGravForce.Parent ~= root then
                if lowGravForce then pcall(function() lowGravForce:Destroy() end) end
                local att = root:FindFirstChild("LowGravAtt") or Instance.new("Attachment", root); att.Name = "LowGravAtt"
                lowGravForce = Instance.new("VectorForce", root); lowGravForce.Attachment0 = att; lowGravForce.RelativeTo = Enum.ActuatorRelativeTo.World
            end
            if root.AssemblyLinearVelocity.Y < 0 then
                lowGravForce.Force = Vector3.new(0, workspace.Gravity * root.AssemblyMass * (lowGravValue / 1000), 0)
            else
                lowGravForce.Force = Vector3.new(0, 0, 0)
            end
        else
            if lowGravForce then lowGravForce:Destroy(); lowGravForce = nil end
        end
        
        if flyEnabled and flyVelocity then
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
end)

noclipConnection = RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ================= SỰ KIỆN KEYBIND & GIAO DIỆN ================= --
local function setupKeybindButton(btn, targetName)
    btn.MouseButton1Click:Connect(function() bindingTarget = targetName; bindingBtn = btn; btn.Text = "..." end)
end
setupKeybindButton(speedKey, "Speed")
setupKeybindButton(weightKey, "Weight")
setupKeybindButton(lowGravKey, "LowGrav")
setupKeybindButton(flyKey, "Fly")
setupKeybindButton(noclipKey, "Noclip")
setupKeybindButton(autoClickKey, "AutoClick")
setupKeybindButton(espKey, "ESP")
setupKeybindButton(fogKey, "Fog")
setupKeybindButton(infJumpKey, "InfJump")
setupKeybindButton(fullBrightKey, "FullBright")
setupKeybindButton(timeKey, "TimeChanger")

local function toggleMenu()
    if frame.Visible then
        miniIcon.Position = frame.Position
        TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.3, function()
            frame.Visible = false; frame.Size = UDim2.new(0, 650, 0, 520)
            miniIcon.Visible = true; miniIcon.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(miniIcon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
        end)
    else
        frame.Position = miniIcon.Position
        TS:Create(miniIcon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.2, function()
            miniIcon.Visible = false; miniIcon.Size = UDim2.new(0, 45, 0, 45)
            frame.Visible = true; frame.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 650, 0, 520)}):Play()
        end)
    end
end
miniBtn.MouseButton1Click:Connect(toggleMenu); miniIcon.MouseButton1Click:Connect(toggleMenu)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if bindingTarget and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Escape then
            keybinds[bindingTarget] = nil; bindingBtn.Text = "None"
        else
            keybinds[bindingTarget] = input.KeyCode; bindingBtn.Text = input.KeyCode.Name
        end
        bindingTarget = nil; bindingBtn = nil; return
    end

    if playerListFrame.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = input.Position
        local dropMin = playerListFrame.AbsolutePosition; local dropMax = dropMin + playerListFrame.AbsoluteSize
        local btnMin = tpDropdownBtn.AbsolutePosition; local btnMax = btnMin + tpDropdownBtn.AbsoluteSize
        if not (pos.X >= dropMin.X and pos.X <= dropMax.X and pos.Y >= dropMin.Y and pos.Y <= dropMax.Y) and not (pos.X >= btnMin.X and pos.X <= btnMax.X and pos.Y >= btnMin.Y and pos.Y <= btnMax.Y) then
            playerListFrame.Visible = false
        end
    end

    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local k = input.KeyCode
            if k == keybinds["Speed"] then toggleSpeed() end
            if k == keybinds["Weight"] then toggleWeight() end
            if k == keybinds["LowGrav"] then toggleLowGrav() end
            if k == keybinds["Fly"] then toggleFly() end
            if k == keybinds["Noclip"] then toggleNoclip() end
            if k == keybinds["AutoClick"] then toggleAutoClick() end
            if k == keybinds["ESP"] then toggleESP() end
            if k == keybinds["Fog"] then toggleFog() end
            if k == keybinds["InfJump"] then toggleInfJump() end
            if k == keybinds["FullBright"] then toggleFullBright() end
            if k == keybinds["TimeChanger"] then toggleTimeChanger() end
            if (k == Enum.KeyCode.RightControl or k == Enum.KeyCode.F5) then toggleMenu() end
        end
        if input.KeyCode == Enum.KeyCode.Space then moveY = 1 end
        if input.KeyCode == Enum.KeyCode.LeftShift then moveY = -1 end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then moveY = 0 end
end)

-- ================= XỬ LÝ KÉO UI VÀ SLIDERS ================= --
local function makeDraggable(dragHandle, targetFrame)
    local dragging, dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = targetFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TS:Create(targetFrame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
end
makeDraggable(title, frame); makeDraggable(miniIcon, miniIcon)

speedBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
weightBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingWeight = true end end)
lowGravBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingLowGrav = true end end)
flyBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingFly = true end end)
autoClickBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingAutoClick = true end end)
timeBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingTime = true end end)

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
            lowGravHandle.Position = UDim2.new(p, -8, 0.5, -8); lowGravValue = math.floor(p * 1000); lowGravTxt.Text = tostring(lowGravValue)
        end
        if draggingFly then
            local p = math.clamp((input.Position.X - flyBar.AbsolutePosition.X)/flyBar.AbsoluteSize.X, 0, 1)
            flyHandle.Position = UDim2.new(p, -8, 0.5, -8); flySpeed = math.floor(p * 1000); flyTxt.Text = tostring(flySpeed)
        end
        if draggingAutoClick then
            local p = math.clamp((input.Position.X - autoClickBar.AbsolutePosition.X)/autoClickBar.AbsoluteSize.X, 0, 1)
            autoClickCps = math.max(1, math.floor(p * 50)); autoClickHandle.Position = UDim2.new(autoClickCps / 50, -8, 0.5, -8); autoClickTxt.Text = tostring(autoClickCps)
        end
        if draggingTime then
            local p = math.clamp((input.Position.X - timeBar.AbsolutePosition.X)/timeBar.AbsoluteSize.X, 0, 1)
            timeHandle.Position = UDim2.new(p, -8, 0.5, -8); timeValue = math.floor(p * 24); timeTxt.Text = tostring(timeValue)
            if timeEnabled then game.Lighting.ClockTime = timeValue end
        end
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider, draggingWeight, draggingLowGrav, draggingFly, draggingAutoClick, draggingTime = false, false, false, false, false, false end end)

local function attachFocusLost(txtObj, varName, maxVal, handleObj, callback)
    txtObj.FocusLost:Connect(function()
        local num = tonumber(txtObj.Text) or getfenv()[varName]; num = math.clamp(num, 0, maxVal)
        if varName == "autoClickCps" then num = math.max(1, num) end
        getfenv()[varName] = math.floor(num); txtObj.Text = tostring(getfenv()[varName]); handleObj.Position = UDim2.new(getfenv()[varName] / maxVal, -8, 0.5, -8)
        if callback then callback(getfenv()[varName]) end
    end)
end
attachFocusLost(speedTxt, "speedValue", 1000, speedHandle)
attachFocusLost(weightTxt, "weightValue", 1000, weightHandle)
attachFocusLost(lowGravTxt, "lowGravValue", 1000, lowGravHandle)
attachFocusLost(flyTxt, "flySpeed", 1000, flyHandle)
attachFocusLost(autoClickTxt, "autoClickCps", 50, autoClickHandle)
attachFocusLost(timeTxt, "timeValue", 24, timeHandle, function(val) if timeEnabled then game.Lighting.ClockTime = val end end)

-- ================= TELEPORT LOGIC ================= --
local function updatePlayerList()
    for _, child in pairs(playerListFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local yOffset = 0
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 25); btn.BackgroundColor3 = Colors.Keybind; btn.TextColor3 = Colors.TextPrimary; btn.Text = "  " .. p.Name; btn.Font = Enum.Font.Gotham; btn.TextSize = 12; btn.TextXAlignment = Enum.TextXAlignment.Left; btn.BorderSizePixel = 0; btn.ZIndex = 11; btn.Parent = playerListFrame; applyHover(btn, Colors.Keybind, Colors.KeybindHover)
            btn.MouseButton1Click:Connect(function() tpDropdownBtn.Text = p.Name; playerListFrame.Visible = false end)
            yOffset = yOffset + 25
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

tpDropdownBtn.MouseButton1Click:Connect(function() playerListFrame.Visible = not playerListFrame.Visible; if playerListFrame.Visible then updatePlayerList() end end)
refreshBtn.MouseButton1Click:Connect(function() updatePlayerList(); tpDropdownBtn.Text = "Chọn người chơi để Teleport..."; refreshBtn.Text = "Xong!"; task.delay(1, function() if refreshBtn then refreshBtn.Text = "Làm mới" end end) end)

tpBtn.MouseButton1Click:Connect(function()
    local targetPlayer = game.Players:FindFirstChild(tpDropdownBtn.Text)
    if targetPlayer and targetPlayer.Character then
        local targetCFrame = targetPlayer.Character:GetPivot()
        local myRoot = getTargetRoot()
        if targetCFrame and myRoot then
            myRoot.AssemblyLinearVelocity = Vector3.zero; myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = targetCFrame * CFrame.new(0, 3, 3); tpBtn.Text = "Đã dịch chuyển!"
            task.delay(1, function() if tpBtn then tpBtn.Text = "Teleport" end end)
        end
    else
        tpBtn.Text = "Lỗi Target!"; task.delay(1.5, function() if tpBtn then tpBtn.Text = "Teleport" end end)
    end
end)

-- ================= CÁC API SERVER ================= --
local function fetchServers()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
    if success and result and result.data then return result.data end; return {}
end

rejoinBtn.MouseButton1Click:Connect(function() rejoinBtn.Text = "Rejoining..."; TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player) end)
randomServerBtn.MouseButton1Click:Connect(function()
    randomServerBtn.Text = "Finding Server..."
    local servers = fetchServers(); local validServers = {}
    for _, v in pairs(servers) do if v.playing < v.maxPlayers and v.id ~= game.JobId then table.insert(validServers, v.id) end end
    if #validServers > 0 then randomServerBtn.Text = "Teleporting..."; TeleportService:TeleportToPlaceInstance(game.PlaceId, validServers[math.random(1, #validServers)], player) else randomServerBtn.Text = "No Server Found!"; task.delay(1.5, function() randomServerBtn.Text = "Join Random Server" end) end
end)
smallServerBtn.MouseButton1Click:Connect(function()
    smallServerBtn.Text = "Finding Smallest..."
    local servers = fetchServers(); local smallestId = nil; local minPlayers = math.huge
    for _, v in pairs(servers) do if v.playing < minPlayers and v.playing > 0 and v.id ~= game.JobId then minPlayers = v.playing; smallestId = v.id end end
    if smallestId then smallServerBtn.Text = "Teleporting..."; TeleportService:TeleportToPlaceInstance(game.PlaceId, smallestId, player) else smallServerBtn.Text = "No Server Found!"; task.delay(1.5, function() smallServerBtn.Text = "Join Smallest Server" end) end
end)
copyJobBtn.MouseButton1Click:Connect(function() if setclipboard then setclipboard(game.JobId); copyJobBtn.Text = "Copied to Clipboard!" else copyJobBtn.Text = "Executor Not Supported!" end; task.delay(1.5, function() copyJobBtn.Text = "Copy Server JobId" end) end)

-- ================= SỰ KIỆN DỌN DẸP SẠCH SẼ KHI TẮT SCRIPT ================= --
closeBtn.MouseButton1Click:Connect(function()
    isScriptActive = false -- Hủy các luồng ngầm (Auto Clicker)
    
    -- An toàn tắt từng chức năng nếu đang bật (Để khôi phục trạng thái ban đầu)
    if enabled then toggleSpeed() end
    if weightEnabled then toggleWeight() end
    if lowGravEnabled then toggleLowGrav() end
    if noclipEnabled then toggleNoclip() end
    if flyEnabled then toggleFly() end
    if autoClickEnabled then toggleAutoClick() end
    if espEnabled then toggleESP() end
    if fogEnabled then toggleFog() end
    if infJumpEnabled then toggleInfJump() end
    if fullBrightEnabled then toggleFullBright() end
    if timeEnabled then toggleTimeChanger() end

    -- Ngắt kết nối các sự kiện còn sót
    if loopConnection then loopConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    
    -- Dọn sạch tàn dư vật lý
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = 16 end
    local root = getTargetRoot()
    if root then
        for _, v in pairs(root:GetChildren()) do
            if v.Name == "WeightAtt" or v.Name == "LowGravAtt" or v:IsA("BodyVelocity") or v:IsA("VectorForce") then
                v:Destroy()
            end
        end
    end
    
    -- Xóa UI mượt mà
    TS:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(0.35, function() gui:Destroy() end)
end)
