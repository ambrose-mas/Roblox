local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local playerGui = player:WaitForChild("PlayerGui")

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

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 430)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
addCorner(frame, 8)

-- MINI BUTTON (Icon sấm sét khi thu nhỏ)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 40, 0, 40)
miniIcon.Position = UDim2.new(0, 100, 0, 100)
miniIcon.Text = "⚡"
miniIcon.TextSize = 20
miniIcon.Visible = false
miniIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
miniIcon.TextColor3 = Color3.new(1, 1, 1)
miniIcon.Active = true
miniIcon.Parent = gui
addCorner(miniIcon, 8)

-- TITLE (Được dùng làm thanh nắm để kéo)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "⚡ Speed Menu ⚡"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1, 1, 1)
title.Active = true
title.Parent = frame
addCorner(title, 8)

-- Sửa lỗi bo góc bị tràn xuống dưới của Title
local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 8)
titleFix.Position = UDim2.new(0, 0, 1, -8)
titleFix.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
titleFix.BorderSizePixel = 0
titleFix.Parent = title

-- CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame
addCorner(closeBtn, 8)

-- MINIMIZE
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 35, 0, 35)
miniBtn.Position = UDim2.new(1, -70, 0, 0)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Parent = frame
addCorner(miniBtn, 8)

-- ================= CÁC THÀNH PHẦN UI ================= --
-- SPEED (Y: 45)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.85, 0, 0, 30)
toggleBtn.Position = UDim2.new(0.075, 0, 0, 45)
toggleBtn.Text = "Speed: OFF"
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 13
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Parent = frame
addCorner(toggleBtn, 6)

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.85, 0, 0, 30)
speedInput.Position = UDim2.new(0.075, 0, 0, 80)
speedInput.PlaceholderText = "Speed..."
speedInput.Text = "16"
speedInput.Font = Enum.Font.Gotham
speedInput.TextSize = 12
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.ClearTextOnFocus = false
speedInput.Parent = frame
addCorner(speedInput, 6)

-- WEIGHT (Y: 125)
local weightToggle = Instance.new("TextButton")
weightToggle.Size = UDim2.new(0.85, 0, 0, 30)
weightToggle.Position = UDim2.new(0.075, 0, 0, 125)
weightToggle.Text = "Weight: OFF"
weightToggle.Font = Enum.Font.GothamSemibold
weightToggle.TextSize = 13
weightToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
weightToggle.TextColor3 = Color3.new(1, 1, 1)
weightToggle.Parent = frame
addCorner(weightToggle, 6)

local weightInput = Instance.new("TextBox")
weightInput.Size = UDim2.new(0.85, 0, 0, 30)
weightInput.Position = UDim2.new(0.075, 0, 0, 160)
weightInput.PlaceholderText = "Weight..."
weightInput.Text = "0"
weightInput.Font = Enum.Font.Gotham
weightInput.TextSize = 12
weightInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
weightInput.TextColor3 = Color3.new(1, 1, 1)
weightInput.ClearTextOnFocus = false
weightInput.Parent = frame
addCorner(weightInput, 6)

-- FLY (Y: 205)
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0.85, 0, 0, 30)
flyToggle.Position = UDim2.new(0.075, 0, 0, 205)
flyToggle.Text = "Fly: OFF"
flyToggle.Font = Enum.Font.GothamSemibold
flyToggle.TextSize = 13
flyToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyToggle.TextColor3 = Color3.new(1, 1, 1)
flyToggle.Parent = frame
addCorner(flyToggle, 6)

local flyInput = Instance.new("TextBox")
flyInput.Size = UDim2.new(0.85, 0, 0, 30)
flyInput.Position = UDim2.new(0.075, 0, 0, 240)
flyInput.PlaceholderText = "Fly Speed..."
flyInput.Text = "50"
flyInput.Font = Enum.Font.Gotham
flyInput.TextSize = 12
flyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyInput.TextColor3 = Color3.new(1, 1, 1)
flyInput.ClearTextOnFocus = false
flyInput.Parent = frame
addCorner(flyInput, 6)

-- NOCLIP (Y: 285)
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0.85, 0, 0, 30)
noclipToggle.Position = UDim2.new(0.075, 0, 0, 285) 
noclipToggle.Text = "Noclip: OFF"
noclipToggle.Font = Enum.Font.GothamSemibold
noclipToggle.TextSize = 13
noclipToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipToggle.TextColor3 = Color3.new(1, 1, 1)
noclipToggle.Parent = frame
addCorner(noclipToggle, 6)

-- DROPDOWN TELEPORT (Y: 335)
local tpDropdownBtn = Instance.new("TextButton")
tpDropdownBtn.Size = UDim2.new(0.85, 0, 0, 30)
tpDropdownBtn.Position = UDim2.new(0.075, 0, 0, 335)
tpDropdownBtn.Text = "Chọn người chơi..."
tpDropdownBtn.Font = Enum.Font.Gotham
tpDropdownBtn.TextSize = 12
tpDropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpDropdownBtn.TextColor3 = Color3.new(1, 1, 1)
tpDropdownBtn.Parent = frame
addCorner(tpDropdownBtn, 6)

-- NÚT REFRESH (Y: 380, bên trái)
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.4, 0, 0, 30)
refreshBtn.Position = UDim2.new(0.075, 0, 0, 380)
refreshBtn.Text = "Refresh"
refreshBtn.Font = Enum.Font.GothamSemibold
refreshBtn.TextSize = 12
refreshBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
refreshBtn.TextColor3 = Color3.new(1, 1, 1)
refreshBtn.Parent = frame
addCorner(refreshBtn, 6)

-- NÚT TELEPORT (Y: 380, bên phải)
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.4, 0, 0, 30)
tpBtn.Position = UDim2.new(0.525, 0, 0, 380)
tpBtn.Text = "Teleport"
tpBtn.Font = Enum.Font.GothamSemibold
tpBtn.TextSize = 12
tpBtn.BackgroundColor3 = Color3.fromRGB(150, 80, 50)
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.Parent = frame
addCorner(tpBtn, 6)

-- KHUNG DANH SÁCH CUỘN (SCROLLING FRAME)
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(0.85, 0, 0, 100)
playerListFrame.Position = UDim2.new(0.075, 0, 0, 368)
playerListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.ZIndex = 10
playerListFrame.ScrollBarThickness = 4
playerListFrame.Parent = frame
addCorner(playerListFrame, 6)

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = playerListFrame
listLayout.SortOrder = Enum.SortOrder.Name

-- ================= LOGIC BIẾN & HÀM ================= --
local enabled = false
local speedValue = 16

local weightEnabled = false
local weightValue = 0
local weightForce = nil

local flyEnabled = false
local flySpeed = 50
local flyVelocity = nil
local moveY = 0

local noclipEnabled = false

local function getHumanoid()
    local char = player.Character
    if char then
        return char:FindFirstChild("Humanoid")
    end
end

-- Lấy gốc tọa độ vật thể nếu đang ngồi
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
    if weightForce then
        weightForce:Destroy()
        weightForce = nil
    end
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
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
end

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
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
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
            targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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
    if hum then
        hum.WalkSpeed = enabled and speedValue or 16
    end
    
    if weightEnabled then applyWeight() else removeWeight() end
    
    if flyEnabled then
        startFly() 
        if flyVelocity then
            local root = getTargetRoot()
            if root then
                local cam = workspace.CurrentCamera
                local dir = Vector3.zero
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                
                dir += Vector3.new(0, moveY, 0)
                
                if dir.Magnitude > 0 then
                    dir = dir.Unit * flySpeed
                end
                
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
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- ================= ĐIỀU KHIỂN & SỰ KIỆN ================= --
UIS.InputBegan:Connect(function(input, gameProcessed)
    -- Thêm F5 bên cạnh Pause để tắt/bật bảng menu
    if (input.KeyCode == Enum.KeyCode.F5 or input.KeyCode == Enum.KeyCode.Pause) and not gameProcessed then
        if frame.Visible then
            miniIcon.Position = frame.Position
            frame.Visible = false
            miniIcon.Visible = true
        else
            frame.Position = miniIcon.Position
            frame.Visible = true
            miniIcon.Visible = false
        end
    end

    if input.KeyCode == Enum.KeyCode.Space then moveY = 1 end
    if input.KeyCode == Enum.KeyCode.LeftShift then moveY = -1 end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
        moveY = 0
    end
end)

local function toggleColor(btn, state)
    btn.BackgroundColor3 = state and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(70, 70, 70)
end

toggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggleBtn.Text = enabled and "Speed: ON" or "Speed: OFF"
    toggleColor(toggleBtn, enabled)
end)

weightToggle.MouseButton1Click:Connect(function()
    weightEnabled = not weightEnabled
    weightToggle.Text = weightEnabled and "Weight: ON" or "Weight: OFF"
    toggleColor(weightToggle, weightEnabled)
end)

flyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyToggle.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    toggleColor(flyToggle, flyEnabled)
    if flyEnabled then startFly() else stopFly() end
end)

noclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipToggle.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    toggleColor(noclipToggle, noclipEnabled)
    
    if not noclipEnabled then
        local char = player.Character
        if char then
            local partsToReset = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso"}
            for _, name in ipairs(partsToReset) do
                local part = char:FindFirstChild(name)
                if part and part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            
            local hum = char:FindFirstChild("Humanoid")
            if hum and hum.SeatPart then
                for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end)

-- LOGIC NHẬP NUMBER (GIỚI HẠN TỪ 0 ĐẾN 1,000,000) -------
speedInput.FocusLost:Connect(function()
    local num = tonumber(speedInput.Text)
    if num then
        speedValue = math.clamp(math.floor(num), 0, 1000000)
    end
    speedInput.Text = tostring(speedValue)
end)

weightInput.FocusLost:Connect(function()
    local num = tonumber(weightInput.Text)
    if num then
        weightValue = math.clamp(math.floor(num), 0, 1000000)
    end
    weightInput.Text = tostring(weightValue)
end)

flyInput.FocusLost:Connect(function()
    local num = tonumber(flyInput.Text)
    if num then
        flySpeed = math.clamp(math.floor(num), 0, 1000000)
    end
    flyInput.Text = tostring(flySpeed)
end)
-----------------------------------------------------------

-- LOGIC DROPDOWN TELEPORT ĐƯỢC TỐI ƯU HÓA ----------------
local function updatePlayerList()
    for _, child in pairs(playerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local yOffset = 0
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 25)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.Text = "  " .. p.Name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.BorderSizePixel = 0
            btn.ZIndex = 11
            btn.Parent = playerListFrame
            
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

-- Thực thi lệnh Teleport
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
-----------------------------------------------------------

-- ĐỒNG BỘ VỊ TRÍ NÚT MINI VÀ BẢNG MENU -----------
miniBtn.MouseButton1Click:Connect(function()
    miniIcon.Position = frame.Position
    frame.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    frame.Position = miniIcon.Position
    frame.Visible = true
    miniIcon.Visible = false
end)
-----------------------------------------------------------

closeBtn.MouseButton1Click:Connect(function()
    enabled = false
    weightEnabled = false
    flyEnabled = false
    noclipEnabled = false
    
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = 16 end
    removeWeight()
    stopFly()
    
    local char = player.Character
    if char then
        local partsToReset = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso"}
        for _, name in ipairs(partsToReset) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        
        if hum and hum.SeatPart then
            for _, part in pairs(hum.SeatPart:GetConnectedParts()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
    
    if loopConnection then loopConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    gui:Destroy()
end)
