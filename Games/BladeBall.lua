-- VoidSnow | Blade Ball (Extended)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local cfg = {
    autoParry = false,
    parryRange = 20,
    autoBlock = false,
    autoDash = false,
    autoJump = false,
    autoRespawn = false,
    autoBuy = false,
    espBall = false,
    espPlayers = false,
    espNames = false,
    espDistance = false,
    espTracers = false,
    speed = false,
    speedVal = 25,
    fly = false,
    flySpeed = 50,
    noclip = false,
    godmode = false,
    infJump = false,
    fullbright = false,
    antiAfk = false,
    antiAntiCheat = true,
    fov = 70
}

local bg = Color3.fromRGB(15, 15, 22)
local accent = Color3.fromRGB(130, 80, 255)
local accent2 = Color3.fromRGB(80, 180, 255)
local textCol = Color3.fromRGB(210, 210, 220)
local btnOff = Color3.fromRGB(28, 28, 38)

local gui = Instance.new("ScreenGui")
gui.Name = "VoidSnow"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- КНОПКА ОТКРЫТИЯ
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, 0)
openBtn.BackgroundColor3 = bg
openBtn.Text = "V"
openBtn.TextColor3 = accent2
openBtn.TextSize = 22
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = gui

local obCorner = Instance.new("UICorner")
obCorner.CornerRadius = UDim.new(1, 0)
obCorner.Parent = openBtn

local obStroke = Instance.new("UIStroke")
obStroke.Color = accent
obStroke.Thickness = 1.5
obStroke.Transparency = 0.3
obStroke.Parent = openBtn

-- ОКНО
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 240, 0, 360)
main.Position = UDim2.new(0, 80, 0.5, -180)
main.BackgroundColor3 = bg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = false
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = accent
stroke.Thickness = 1.5
stroke.Transparency = 0.2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
title.BorderSizePixel = 0
title.Text = "VoidSnow | Blade Ball"
title.TextColor3 = accent2
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = main

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 12)
tCorner.Parent = title

local tStroke = Instance.new("UIStroke")
tStroke.Color = accent
tStroke.Thickness = 1
tStroke.Transparency = 0.4
tStroke.Parent = title

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 26, 0, 26)
close.Position = UDim2.new(1, -32, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
close.Text = "×"
close.TextColor3 = accent2
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = main

local cCorner = Instance.new("UICorner")
cCorner.CornerRadius = UDim.new(0, 6)
cCorner.Parent = close

close.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -48)
scroll.Position = UDim2.new(0, 5, 0, 42)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = accent
scroll.CanvasSize = UDim2.new(0, 0, 0, 1200)
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- СЕКЦИЯ
local function createSection(name)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -5, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = "— " .. name .. " —"
    lbl.TextColor3 = accent2
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Parent = scroll
end

-- ТУМБЛЕР
local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 36)
    btn.BackgroundColor3 = btnOff
    btn.Text = name
    btn.TextColor3 = textCol
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.Parent = scroll

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

    local bs = Instance.new("UIStroke")
    bs.Color = accent
    bs.Thickness = 1
    bs.Transparency = 0.7
    bs.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
            bs.Transparency = 0.2
        else
            btn.BackgroundColor3 = btnOff
            bs.Transparency = 0.7
        end
        callback(state)
    end)
end

-- СЛАЙДЕР
local function createSlider(name, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -5, 0, 52)
    frame.BackgroundColor3 = btnOff
    frame.BorderSizePixel = 0
    frame.Parent = scroll

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame

    local fs = Instance.new("UIStroke")
    fs.Color = accent
    fs.Thickness = 1
    fs.Transparency = 0.7
    fs.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default
    label.TextColor3 = textCol
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.9, 0, 0, 6)
    bar.Position = UDim2.new(0.05, 0, 0, 32)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local barc = Instance.new("UICorner")
    barc.CornerRadius = UDim.new(1, 0)
    barc.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = accent
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fc2 = Instance.new("UICorner")
    fc2.CornerRadius = UDim.new(1, 0)
    fc2.Parent = fill

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
            rel = math.clamp(rel, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            local val = math.floor(min + (max - min) * rel)
            label.Text = name .. ": " .. val
            callback(val)
        end
    end)
end

-- АНТИ-АНТИЧИТ
if cfg.antiAntiCheat then
    pcall(function()
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" then return nil end
            if method == "FireServer" and self.Name == "Kick" then return nil end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end)
end

-- ESP
local drawings = {}
local function clearDrawings()
    for _, d in pairs(drawings) do
        if d and d.Remove then d:Remove() end
    end
    drawings = {}
end

local ballCache = nil
local function getBall()
    if ballCache and ballCache.Parent then return ballCache end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("ball") or n:find("orb") then
                ballCache = obj
                return obj
            end
        end
    end
    return nil
end

local espCounter = 0
local function esp()
    espCounter = espCounter + 1
    if espCounter % 2 ~= 0 then return end
    clearDrawings()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if cfg.espBall then
        local ball = getBall()
        if ball then
            local sp, on = Camera:WorldToViewportPoint(ball.Position)
            if on then
                local t = Drawing.new("Text")
                t.Visible = true
                t.Color = accent2
                t.Size = 16
                t.Center = true
                t.Outline = true
                t.Text = "BALL"
                t.Position = Vector2.new(sp.X, sp.Y)
                table.insert(drawings, t)
                if cfg.espTracers then
                    local l = Drawing.new("Line")
                    l.Visible = true
                    l.Color = accent
                    l.Thickness = 1
                    l.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    l.To = Vector2.new(sp.X, sp.Y)
                    table.insert(drawings, l)
                end
            end
        end
    end

    if cfg.espPlayers or cfg.espNames or cfg.espDistance or cfg.espTracers then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Head")
                local phrp = p.Character:FindFirstChild("HumanoidRootPart")
                if h and phrp then
                    local sp, on = Camera:WorldToViewportPoint(h.Position)
                    if on then
                        if cfg.espNames then
                            local t = Drawing.new("Text")
                            t.Visible = true
                            t.Color = textCol
                            t.Size = 13
                            t.Center = true
                            t.Outline = true
                            t.Text = p.Name
                            t.Position = Vector2.new(sp.X, sp.Y - 30)
                            table.insert(drawings, t)
                        end
                        if cfg.espDistance then
                            local d = (phrp.Position - hrp.Position).Magnitude
                            local t = Drawing.new("Text")
                            t.Visible = true
                            t.Color = accent2
                            t.Size = 12
                            t.Center = true
                            t.Outline = true
                            t.Text = tostring(math.floor(d)) .. "m"
                            t.Position = Vector2.new(sp.X, sp.Y + 40)
                            table.insert(drawings, t)
                        end
                        if cfg.espPlayers then
                            local b = Drawing.new("Square")
                            b.Visible = true
                            b.Color = accent
                            b.Thickness = 1
                            b.Filled = false
                            b.Size = Vector2.new(50, 70)
                            b.Position = Vector2.new(sp.X - 25, sp.Y - 35)
                            table.insert(drawings, b)
                        end
                        if cfg.espTracers then
                            local l = Drawing.new("Line")
                            l.Visible = true
                            l.Color = accent
                            l.Thickness = 1
                            l.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            l.To = Vector2.new(sp.X, sp.Y)
                            table.insert(drawings, l)
                        end
                    end
                end
            end
        end
    end
end

-- AUTO PARRY
local parryConn = nil
local function autoParry()
    if cfg.autoParry and not parryConn then
        parryConn = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local ball = getBall()
            if ball and (ball.Position - hrp.Position).Magnitude < cfg.parryRange then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2))
            end
        end)
    elseif not cfg.autoParry and parryConn then
        parryConn:Disconnect()
        parryConn = nil
    end
end

-- AUTO BLOCK / DASH / JUMP
local function autoBlock()
    if not cfg.autoBlock then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 0 end
end

local function autoDash()
    if not cfg.autoDash then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Velocity = dir * 80 end
        end
    end
end

local function autoJump()
    if not cfg.autoJump then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum:GetState() == Enum.HumanoidStateType.Landed then
        hum.Jump = true
    end
end

-- AUTO RESPAWN
local function autoRespawn()
    if not cfg.autoRespawn then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
        LocalPlayer:LoadCharacter()
    end
end

-- AUTO BUY
local function autoBuy()
    if not cfg.autoBuy then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") then
            local t = v.Text:lower()
            if t:find("buy") or t:find("purchase") or t:find("купить") then
                v:FireServer()
            end
        end
    end
end

-- ДВИЖЕНИЕ
local function speed()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = cfg.speed and cfg.speedVal or 16 end
end

local function godmode()
    if not cfg.godmode then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
end

local function noclip()
    if not cfg.noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end

local function infJump()
    if not cfg.infJump then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 200 end
end

local flyBV = nil
local function fly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not cfg.fly then
        if flyBV then flyBV:Destroy() flyBV = nil end
        return
    end
    if not flyBV then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBV.Parent = hrp
    end
    local move = Vector3.new(0, 0, 0)
    local cam = Camera.CFrame
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
    flyBV.Velocity = move * cfg.flySpeed
end

local function fullbright()
    if cfg.fullbright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
    end
end

local function fov()
    Camera.FieldOfView = cfg.fov
end

LocalPlayer.Idled:Connect(function()
    if cfg.antiAfk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    godmode()
end)

RunService.RenderStepped:Connect(function()
    if cfg.espBall or cfg.espPlayers or cfg.espNames or cfg.espDistance or cfg.espTracers then esp() end
    speed()
    godmode()
    noclip()
    infJump()
    fly()
    fullbright()
    fov()
    autoBlock()
    autoDash()
    autoJump()
    autoRespawn()
end)

RunService.Heartbeat:Connect(function()
    autoParry()
    autoBuy()
end)

-- СЕКЦИИ И КНОПКИ
createSection("PARry")
createToggle("Auto Parry", function(v) cfg.autoParry = v end)
createSlider("Parry Range", 5, 100, 20, function(v) cfg.parryRange = v end)

createSection("Combat")
createToggle("Auto Block", function(v) cfg.autoBlock = v end)
createToggle("Auto Dash", function(v) cfg.autoDash = v end)
createToggle("Auto Jump", function(v) cfg.autoJump = v end)
createToggle("Auto Respawn", function(v) cfg.autoRespawn = v end)
createToggle("Auto Buy", function(v) cfg.autoBuy = v end)

createSection("ESP")
createToggle("ESP Ball", function(v) cfg.espBall = v end)
createToggle("ESP Players", function(v) cfg.espPlayers = v end)
createToggle("ESP Names", function(v) cfg.espNames = v end)
createToggle("ESP Distance", function(v) cfg.espDistance = v end)
createToggle("ESP Tracers", function(v) cfg.espTracers = v end)

createSection("Movement")
createToggle("Speed", function(v) cfg.speed = v end)
createSlider("Speed Value", 16, 150, 25, function(v) cfg.speedVal = v end)
createToggle("Fly", function(v) cfg.fly = v end)
createSlider("Fly Speed", 10, 200, 50, function(v) cfg.flySpeed = v end)
createToggle("Noclip", function(v) cfg.noclip = v end)
createToggle("Infinite Jump", function(v) cfg.infJump = v end)

createSection("Protection")
createToggle("Godmode", function(v) cfg.godmode = v end)
createToggle("Anti-AntiCheat", function(v) cfg.antiAntiCheat = v end)

createSection("Visual")
createToggle("Fullbright", function(v) cfg.fullbright = v end)
createSlider("Camera FOV", 50, 120, 70, function(v) cfg.fov = v end)

createSection("Misc")
createToggle("Anti-AFK", function(v) cfg.antiAfk = v end)
