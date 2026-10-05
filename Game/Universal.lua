-- VoidSnow | Universal
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "VoidSnow | Universal",
    LoadingTitle = "Universal",
    LoadingSubtitle = "module",
    ConfigurationSaving = { Enabled = false }
})

local cfg = {
    espPlayers = false,
    espNames = false,
    espHealth = false,
    espDistance = false,
    espTracers = false,
    espBox = false,
    chams = false,
    xray = false,
    ambient = false,
    fog = false,
    nightVision = false,
    speed = false,
    speedVal = 25,
    fly = false,
    flySpeed = 50,
    noclip = false,
    godmode = false,
    infJump = false,
    fullbright = false,
    freecam = false,
    antiAfk = false,
    antiKick = false,
    fov = 70,
    jumpPower = 200
}

-- АНТИ-КИК
pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

local drawings = {}
local function clearDrawings()
    for _, d in pairs(drawings) do
        if d and d.Remove then d:Remove() end
    end
    drawings = {}
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
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("Head")
            local phrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if h and phrp then
                local sp, on = Camera:WorldToViewportPoint(h.Position)
                if on then
                    if cfg.espNames then
                        local t = Drawing.new("Text")
                        t.Visible, t.Color, t.Size, t.Center, t.Outline = true, Color3.fromRGB(210,210,220), 13, true, true
                        t.Text = p.Name
                        t.Position = Vector2.new(sp.X, sp.Y - 30)
                        table.insert(drawings, t)
                    end
                    if cfg.espHealth and hum then
                        local t = Drawing.new("Text")
                        t.Visible, t.Color, t.Size, t.Center, t.Outline = true, Color3.fromRGB(0,255,0), 12, true, true
                        t.Text = tostring(math.floor(hum.Health)) .. " HP"
                        t.Position = Vector2.new(sp.X, sp.Y + 55)
                        table.insert(drawings, t)
                    end
                    if cfg.espDistance then
                        local d = (phrp.Position - hrp.Position).Magnitude
                        local t = Drawing.new("Text")
                        t.Visible, t.Color, t.Size, t.Center, t.Outline = true, Color3.fromRGB(80,180,255), 12, true, true
                        t.Text = tostring(math.floor(d)) .. "m"
                        t.Position = Vector2.new(sp.X, sp.Y + 40)
                        table.insert(drawings, t)
                    end
                    if cfg.espBox then
                        local b = Drawing.new("Square")
                        b.Visible, b.Color, b.Thickness, b.Filled = true, Color3.fromRGB(130,80,255), 1, false
                        b.Size = Vector2.new(50, 70)
                        b.Position = Vector2.new(sp.X - 25, sp.Y - 35)
                        table.insert(drawings, b)
                    end
                    if cfg.espTracers then
                        local l = Drawing.new("Line")
                        l.Visible, l.Color, l.Thickness = true, Color3.fromRGB(130,80,255), 1
                        l.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        l.To = Vector2.new(sp.X, sp.Y)
                        table.insert(drawings, l)
                    end
                end
            end
        end
    end
end

local function chams()
    if not cfg.chams then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.ForceField
                    part.Color = Color3.fromRGB(130,80,255)
                end
            end
        end
    end
end

local function xray()
    if not cfg.xray then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.LocalTransparencyModifier = 0.5
        end
    end
end

local function ambient()
    if cfg.ambient then
        Lighting.Ambient = Color3.fromRGB(100, 100, 255)
    end
end

local function fog()
    if cfg.fog then
        Lighting.FogEnd = 5000
    end
end

local function nightVision()
    if cfg.nightVision then
        Lighting.Brightness = 5
        Lighting.ClockTime = 0
    end
end

local function speed()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if cfg.speed then
        if hum.WalkSpeed ~= cfg.speedVal then
            task.wait(0.1)
            hum.WalkSpeed = cfg.speedVal
        end
    else
        hum.WalkSpeed = 16
    end
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
    if hum then hum.JumpPower = cfg.jumpPower end
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

local freecamConn = nil
local function freecam()
    if cfg.freecam and not freecamConn then
        local cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Scriptable
        freecamConn = RunService.RenderStepped:Connect(function()
            local pos = cam.CFrame
            local move = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + pos.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - pos.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - pos.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + pos.RightVector end
            cam.CFrame = CFrame.new(pos.Position + move * 2, pos.Position + move * 2 + pos.LookVector)
        end)
    elseif not cfg.freecam and freecamConn then
        freecamConn:Disconnect()
        freecamConn = nil
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
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
    if cfg.espPlayers or cfg.espNames or cfg.espHealth or cfg.espDistance or cfg.espTracers or cfg.espBox then esp() end
    speed()
    godmode()
    noclip()
    infJump()
    fly()
    fullbright()
    fov()
    freecam()
end)

RunService.Heartbeat:Connect(function()
    chams()
    xray()
    ambient()
    fog()
    nightVision()
end)

-- ТАБЫ
local ESPTab = Window:CreateTab("ESP", 4483362458)
ESPTab:CreateToggle({Name = "ESP Players", CurrentValue = false, Callback = function(v) cfg.espPlayers = v end})
ESPTab:CreateToggle({Name = "ESP Names", CurrentValue = false, Callback = function(v) cfg.espNames = v end})
ESPTab:CreateToggle({Name = "ESP Health", CurrentValue = false, Callback = function(v) cfg.espHealth = v end})
ESPTab:CreateToggle({Name = "ESP Distance", CurrentValue = false, Callback = function(v) cfg.espDistance = v end})
ESPTab:CreateToggle({Name = "ESP Box", CurrentValue = false, Callback = function(v) cfg.espBox = v end})
ESPTab:CreateToggle({Name = "ESP Tracers", CurrentValue = false, Callback = function(v) cfg.espTracers = v end})

local VisTab = Window:CreateTab("Visual", 4483362458)
VisTab:CreateToggle({Name = "Chams", CurrentValue = false, Callback = function(v) cfg.chams = v end})
VisTab:CreateToggle({Name = "X-Ray", CurrentValue = false, Callback = function(v) cfg.xray = v end})
VisTab:CreateToggle({Name = "Ambient", CurrentValue = false, Callback = function(v) cfg.ambient = v end})
VisTab:CreateToggle({Name = "No Fog", CurrentValue = false, Callback = function(v) cfg.fog = v end})
VisTab:CreateToggle({Name = "Night Vision", CurrentValue = false, Callback = function(v) cfg.nightVision = v end})
VisTab:CreateToggle({Name = "Fullbright", CurrentValue = false, Callback = function(v) cfg.fullbright = v end})
VisTab:CreateSlider({Name = "Camera FOV", Range = {50,120}, Increment = 1, CurrentValue = 70, Callback = function(v) cfg.fov = v end})
VisTab:CreateToggle({Name = "Freecam", CurrentValue = false, Callback = function(v) cfg.freecam = v end})

local MoveTab = Window:CreateTab("Movement", 4483362458)
MoveTab:CreateToggle({Name = "Speed", CurrentValue = false, Callback = function(v) cfg.speed = v end})
MoveTab:CreateSlider({Name = "Speed Value", Range = {16,300}, Increment = 1, CurrentValue = 25, Callback = function(v) cfg.speedVal = v end})
MoveTab:CreateToggle({Name = "Fly", CurrentValue = false, Callback = function(v) cfg.fly = v end})
MoveTab:CreateSlider({Name = "Fly Speed", Range = {10,300}, Increment = 5, CurrentValue = 50, Callback = function(v) cfg.flySpeed = v end})
MoveTab:CreateToggle({Name = "Noclip", CurrentValue = false, Callback = function(v) cfg.noclip = v end})
MoveTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Callback = function(v) cfg.infJump = v end})
MoveTab:CreateSlider({Name = "Jump Power", Range = {50,500}, Increment = 10, CurrentValue = 200, Callback = function(v) cfg.jumpPower = v end})

local ProtTab = Window:CreateTab("Protection", 4483362458)
ProtTab:CreateToggle({Name = "Godmode", CurrentValue = false, Callback = function(v) cfg.godmode = v end})
ProtTab:CreateToggle({Name = "Anti-Kick", CurrentValue = true, Callback = function(v) cfg.antiKick = v end})

local SrvTab = Window:CreateTab("Server", 4483362458)
SrvTab:CreateButton({Name = "Server Hop", Callback = function()
    local placeId = game.PlaceId
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    if servers and servers.data then
        for _, s in pairs(servers.data) do
            if s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(placeId, s.id, LocalPlayer)
                break
            end
        end
    end
end})
SrvTab:CreateButton({Name = "Rejoin", Callback = function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end})

local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateToggle({Name = "Anti-AFK", CurrentValue = false, Callback = function(v) cfg.antiAfk = v end})
