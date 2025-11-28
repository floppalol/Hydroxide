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
local TracersEnabled = true
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
