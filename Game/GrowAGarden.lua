-- VoidSnow | Grow a Garden (Part 1/4)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local cfg = {
    autoCollect = false, autoPlant = false, autoSell = false, autoWater = false,
    autoBuy = false, autoCraftGear = false, autoCraftSeed = false, autoCooking = false,
    autoShovel = false, autoSteal = false, stealRange = 150, stealCount = 50,
    deliverStolen = false, autoTame = false, autoFeed = false, autoEquipBest = false,
    speed = false, speedVal = 30, fly = false, flySpeed = 50, noclip = false,
    infJump = false, godmode = false, mutationESP = false, fruitESP = false,
    hidePlants = false, fullbright = false, performanceMode = false, antiAfk = false,
    collectInterval = 0.3, plantDelay = 0.1, fruitCalculator = false, teleportToNPC = false
}

local bgMain = Color3.fromRGB(18, 16, 28)
local bgSide = Color3.fromRGB(22, 20, 35)
local bgCard = Color3.fromRGB(30, 27, 45)
local accent = Color3.fromRGB(140, 90, 255)
local accent2 = Color3.fromRGB(180, 130, 255)
local textCol = Color3.fromRGB(220, 215, 240)
local LOGO_ID = "rbxassetid://16071746188"

local gui = Instance.new("ScreenGui")
gui.Name = "VoidSnowGG"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0, 20)
openBtn.BackgroundColor3 = bgMain
openBtn.Text = "V"
openBtn.TextColor3 = accent2
openBtn.TextSize = 22
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Parent = gui

local obc = Instance.new("UICorner")
obc.CornerRadius = UDim.new(1, 0)
obc.Parent = openBtn

local obs = Instance.new("UIStroke")
obs.Color = accent
obs.Thickness = 1.5
obs.Transparency = 0.3
obs.Parent = openBtn

task.spawn(function()
    while openBtn.Parent do
        local pulse = TweenService:Create(obs, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Thickness = 3, Transparency = 0})
        pulse:Play()
        task.wait(1)
        local shrink = TweenService:Create(obs, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Thickness = 1.5, Transparency = 0.3})
        shrink:Play()
        task.wait(1)
    end
end)

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 620, 0, 380)
main.Position = UDim2.new(0.5, -310, 0.5, -190)
main.BackgroundColor3 = bgMain
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = false
main.Parent = gui

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = main

local ms = Instance.new("UIStroke")
ms.Color = accent
ms.Thickness = 1.5
ms.Transparency = 0.2
ms.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = bgSide
header.BorderSizePixel = 0
header.Parent = main

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 12)
hc.Parent = header

local logoImg = Instance.new("ImageLabel")
logoImg.Size = UDim2.new(0, 35, 0, 35)
logoImg.Position = UDim2.new(0, 12, 0.5, -17.5)
logoImg.BackgroundTransparency = 1
logoImg.Image = LOGO_ID
logoImg.Parent = header

local htitle = Instance.new("TextLabel")
htitle.Size = UDim2.new(0, 300, 0, 25)
htitle.Position = UDim2.new(0, 55, 0, 5)
htitle.BackgroundTransparency = 1
htitle.Text = "VoidSnow | Grow a Garden"
htitle.TextColor3 = accent2
htitle.TextSize = 18
htitle.Font = Enum.Font.GothamBold
htitle.TextXAlignment = Enum.TextXAlignment.Left
htitle.Parent = header

local hsub = Instance.new("TextLabel")
hsub.Size = UDim2.new(0, 300, 0, 18)
hsub.Position = UDim2.new(0, 55, 0, 25)
hsub.BackgroundTransparency = 1
hsub.Text = "Optimized | v1.0.0"
hsub.TextColor3 = textCol
hsub.TextSize = 12
hsub.Font = Enum.Font.Gotham
hsub.TextXAlignment = Enum.TextXAlignment.Left
hsub.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -40, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
close.Text = "×"
close.TextColor3 = accent2
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = header

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = close

local isOpen = false
local function toggleUI()
    isOpen = not isOpen
    if isOpen then
        main.Visible = true
        main.Size = UDim2.new(0, 0, 0, 0)
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        local openTween = TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 620, 0, 380),
            Position = UDim2.new(0.5, -310, 0.5, -190)
        })
        openTween:Play()
    else
        local closeTween = TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            main.Visible = false
        end)
    end
end

close.MouseButton1Click:Connect(toggleUI)
openBtn.MouseButton1Click:Connect(toggleUI)
-- VoidSnow | Grow a Garden (Part 2/4)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -60)
sidebar.Position = UDim2.new(0, 10, 0, 55)
sidebar.BackgroundColor3 = bgSide
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 10)
sc.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 6)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -170, 1, -60)
content.Position = UDim2.new(0, 160, 0, 55)
content.BackgroundColor3 = bgSide
content.BorderSizePixel = 0
content.Parent = main

local contc = Instance.new("UICorner")
contc.CornerRadius = UDim.new(0, 10)
contc.Parent = content

local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Size = UDim2.new(1, -10, 1, -10)
contentScroll.Position = UDim2.new(0, 5, 0, 5)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 3
contentScroll.ScrollBarImageColor3 = accent
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 1400)
contentScroll.Parent = content

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentScroll

local sections = {}

local function createSectionTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = bgCard
    btn.Text = "  " .. name
    btn.TextColor3 = textCol
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = sidebar

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

    local bs = Instance.new("UIStroke")
    bs.Color = accent
    bs.Thickness = 1
    bs.Transparency = 0.8
    bs.Parent = btn

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 10)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = contentScroll

    local containerLayout = Instance.new("UIListLayout")
    containerLayout.Padding = UDim.new(0, 8)
    containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    containerLayout.Parent = container

    sections[name] = {btn = btn, container = container}

    btn.MouseButton1Click:Connect(function()
        for _, s in pairs(sections) do
            s.container.Visible = false
            s.btn.BackgroundColor3 = bgCard
        end
        container.Visible = true
        btn.BackgroundColor3 = accent
    end)

    return container
end

local function createToggle(parent, name, desc, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -5, 0, 70)
    card.BackgroundColor3 = bgCard
    card.BorderSizePixel = 0
    card.Parent = parent

    local cc2 = Instance.new("UICorner")
    cc2.CornerRadius = UDim.new(0, 10)
    cc2.Parent = card

    local cs = Instance.new("UIStroke")
    cs.Color = accent
    cs.Thickness = 1
    cs.Transparency = 0.8
    cs.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 0, 25)
    title.Position = UDim2.new(0, 12, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = textCol
    title.TextSize = 15
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -80, 0, 25)
    descLbl.Position = UDim2.new(0, 12, 0, 32)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = desc
    descLbl.TextColor3 = Color3.fromRGB(150, 140, 180)
    descLbl.TextSize = 11
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextWrapped = true
    descLbl.Parent = card

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 45, 0, 25)
    switch.Position = UDim2.new(1, -55, 0.5, -12)
    switch.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
    switch.Text = ""
    switch.BorderSizePixel = 0
    switch.Parent = card

    local swc = Instance.new("UICorner")
    swc.CornerRadius = UDim.new(1, 0)
    swc.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 19, 0, 19)
    knob.Position = UDim2.new(0, 3, 0.5, -9.5)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    knob.BorderSizePixel = 0
    knob.Parent = switch

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local state = false
    switch.MouseButton1Click:Connect(function()
        state = not state
        if state then
            switch.BackgroundColor3 = accent
            knob.Position = UDim2.new(1, -22, 0.5, -9.5)
        else
            switch.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
            knob.Position = UDim2.new(0, 3, 0.5, -9.5)
        end
        callback(state)
    end)
end

local function createSliderCard(parent, name, min, max, default, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -5, 0, 70)
    card.BackgroundColor3 = bgCard
    card.BorderSizePixel = 0
    card.Parent = parent

    local cc2 = Instance.new("UICorner")
    cc2.CornerRadius = UDim.new(0, 10)
    cc2.Parent = card

    local cs = Instance.new("UIStroke")
    cs.Color = accent
    cs.Thickness = 1
    cs.Transparency = 0.8
    cs.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 0, 25)
    title.Position = UDim2.new(0, 12, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = textCol
    title.TextSize = 15
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 60, 0, 25)
    valLbl.Position = UDim2.new(1, -70, 0, 8)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = accent2
    valLbl.TextSize = 14
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = card

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 8)
    bar.Position = UDim2.new(0, 12, 0, 45)
    bar.BackgroundColor3 = Color3.fromRGB(50, 45, 70)
    bar.BorderSizePixel = 0
    bar.Parent = card

    local bc2 = Instance.new("UICorner")
    bc2.CornerRadius = UDim.new(1, 0)
    bc2.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = accent
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0)
    fc.Parent = fill

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
            valLbl.Text = tostring(val)
            callback(val)
        end
    end)
end
-- VoidSnow | Grow a Garden (Part 3/4)
local farmSec = createSectionTab("Farm")
createToggle(farmSec, "Auto Collect (Aura)", "Собирает урожай вокруг", function(v) cfg.autoCollect = v end)
createToggle(farmSec, "Auto Plant", "Автоматически сажает семена", function(v) cfg.autoPlant = v end)
createToggle(farmSec, "Auto Sell", "Автоматически продаёт урожай", function(v) cfg.autoSell = v end)
createToggle(farmSec, "Auto Water", "Поливает растения", function(v) cfg.autoWater = v end)
createToggle(farmSec, "Auto Buy Seeds", "Покупает семена", function(v) cfg.autoBuy = v end)
createToggle(farmSec, "Auto Craft Gear", "Крафтит снаряжение", function(v) cfg.autoCraftGear = v end)
createToggle(farmSec, "Auto Craft Seed", "Крафтит семена", function(v) cfg.autoCraftSeed = v end)
createToggle(farmSec, "Auto Cooking", "Готовит еду", function(v) cfg.autoCooking = v end)
createToggle(farmSec, "Auto Shovel", "Копает лопатой", function(v) cfg.autoShovel = v end)
createSliderCard(farmSec, "Collect Interval", 0.1, 2, 0.3, function(v) cfg.collectInterval = v end)
createSliderCard(farmSec, "Plant Delay", 0, 1, 0.1, function(v) cfg.plantDelay = v end)

local stealSec = createSectionTab("Steal")
createToggle(stealSec, "Auto Steal (Night)", "Крадёт фрукты ночью", function(v) cfg.autoSteal = v end)
createSliderCard(stealSec, "Steal Range", 50, 500, 150, function(v) cfg.stealRange = v end)
createSliderCard(stealSec, "Steals Per Session", 1, 100, 50, function(v) cfg.stealCount = v end)
createToggle(stealSec, "Deliver Stolen Fruit", "Доставляет в свой сад", function(v) cfg.deliverStolen = v end)

local petSec = createSectionTab("Pets")
createToggle(petSec, "Auto Tame Wild Pets", "Приручает питомцев", function(v) cfg.autoTame = v end)
createToggle(petSec, "Auto Feed Pets", "Кормит питомцев", function(v) cfg.autoFeed = v end)
createToggle(petSec, "Auto Equip Best", "Надевает лучшего питомца", function(v) cfg.autoEquipBest = v end)

local playerSec = createSectionTab("Player")
createToggle(playerSec, "Speed", "Скорость ходьбы", function(v) cfg.speed = v end)
createSliderCard(playerSec, "Speed Value", 16, 200, 30, function(v) cfg.speedVal = v end)
createToggle(playerSec, "Fly", "Полёт", function(v) cfg.fly = v end)
createSliderCard(playerSec, "Fly Speed", 10, 200, 50, function(v) cfg.flySpeed = v end)
createToggle(playerSec, "Noclip", "Проход сквозь стены", function(v) cfg.noclip = v end)
createToggle(playerSec, "Infinite Jump", "Бесконечный прыжок", function(v) cfg.infJump = v end)
createToggle(playerSec, "Godmode", "Бессмертие", function(v) cfg.godmode = v end)

local visSec = createSectionTab("Visual")
createToggle(visSec, "Mutation ESP", "Подсвечивает мутации", function(v) cfg.mutationESP = v end)
createToggle(visSec, "Fruit ESP", "Подсвечивает фрукты", function(v) cfg.fruitESP = v end)
createToggle(visSec, "Hide Plants", "Скрывает растения (FPS)", function(v) cfg.hidePlants = v end)
createToggle(visSec, "Fullbright", "Яркое освещение", function(v) cfg.fullbright = v end)
createToggle(visSec, "Performance Mode", "Режим без лагов", function(v) cfg.performanceMode = v end)

local miscSec = createSectionTab("Misc")
createToggle(miscSec, "Anti-AFK", "Не выкидывает за неактивность", function(v) cfg.antiAfk = v end)
createToggle(miscSec, "Fruit Calculator", "Считает фрукты на сервере", function(v) cfg.fruitCalculator = v end)
createToggle(miscSec, "Teleport to NPC", "Телепорт к NPC", function(v) cfg.teleportToNPC = v end)

sections["Farm"].btn.BackgroundColor3 = accent
sections["Farm"].container.Visible = true
-- VoidSnow | Grow a Garden (Part 4/4)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function autoCollect()
    if not cfg.autoCollect then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local n = obj.Name:lower()
            if n:find("fruit") or n:find("crop") or n:find("plant") or n:find("harvest") or n:find("flower") then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part and (part.Position - hrp.Position).Magnitude < 150 then
                    hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
                    for _, v in pairs(obj:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                    end
                end
            end
        end
    end
end

local function autoPlant()
    if not cfg.autoPlant then return end
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildWhichIsA("Tool")
    if not tool then return end
    task.wait(cfg.plantDelay)
    tool:Activate()
end

local function autoSell()
    if not cfg.autoSell then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") then
            local t = v.Text:lower()
            if t:find("sell") or t:find("продать") then
                v:FireServer()
            end
        end
    end
end

local function autoBuy()
    if not cfg.autoBuy then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") then
            local t = v.Text:lower()
            if t:find("buy") or t:find("purchase") or t:find("seed") then
                v:FireServer()
            end
        end
    end
end

local function autoWater()
    if not cfg.autoWater then return end
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildWhichIsA("Tool")
    if tool and tool.Name:lower():find("water") then
        tool:Activate()
    end
end

local function autoCraftGear()
    if not cfg.autoCraftGear then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("craft") then
            v:FireServer()
        end
    end
end

local function autoCraftSeed()
    if not cfg.autoCraftSeed then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("craft") and v.Text:lower():find("seed") then
            v:FireServer()
        end
    end
end

local function autoCooking()
    if not cfg.autoCooking then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("cook") then
            v:FireServer()
        end
    end
end

local function autoShovel()
    if not cfg.autoShovel then return end
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildWhichIsA("Tool")
    if tool and tool.Name:lower():find("shovel") then
        tool:Activate()
    end
end

local function autoSteal()
    if not cfg.autoSteal then return end
    if Lighting.ClockTime > 6 then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local stolen = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local phrp = p.Character:FindFirstChild("HumanoidRootPart")
            if phrp and (phrp.Position - hrp.Position).Magnitude < cfg.stealRange then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():find("fruit") then
                        if (obj.Position - hrp.Position).Magnitude < 50 then
                            hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            stolen = stolen + 1
                            if stolen >= cfg.stealCount then return end
                        end
                    end
                end
            end
        end
    end
end

local function deliverStolen()
    if not cfg.deliverStolen then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(0, 50, 0)
end

local function autoTame()
    if not cfg.autoTame then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
            local n = obj.Name:lower()
            if n:find("pet") or n:find("animal") then
                if (obj:GetPivot().Position - hrp.Position).Magnitude < 14 then
                    for _, v in pairs(obj:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                    end
                end
            end
        end
    end
end

local function autoFeed()
    if not cfg.autoFeed then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("feed") then
            v:FireServer()
        end
    end
end

local function autoEquipBest()
    if not cfg.autoEquipBest then return end
    local guiP = LocalPlayer:FindFirstChild("PlayerGui")
    if not guiP then return end
    for _, v in pairs(guiP:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("equip") then
            v:FireServer()
        end
    end
end

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

local function mutationESP()
    if not cfg.mutationESP then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("mutat") or n:find("golden") or n:find("rainbow") or n:find("shiny") then
                local hl = obj:FindFirstChild("VoidSnowHL")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "VoidSnowHL"
                    hl.FillColor = Color3.fromRGB(255, 215, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                    hl.Parent = obj
                end
            end
        end
    end
end

local function fruitESP()
    if not cfg.fruitESP then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("fruit") or n:find("crop") then
                local hl = obj:FindFirstChild("VoidSnowFruitHL")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "VoidSnowFruitHL"
                    hl.FillColor = Color3.fromRGB(0, 255, 100)
                    hl.OutlineColor = Color3.fromRGB(0, 255, 0)
                    hl.Parent = obj
                end
            end
        end
    end
end

local function hidePlants()
    if not cfg.hidePlants then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("plant") or n:find("crop") then
                obj.Transparency = 0.9
            end
        end
    end
end

local function fullbright()
    if cfg.fullbright then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
    end
end

local function performanceMode()
    if not cfg.performanceMode then return end
    cfg.mutationESP = false
    cfg.fruitESP = false
    cfg.hidePlants = true
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100
end

local function fruitCalculator()
    if not cfg.fruitCalculator then return end
    local total = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("fruit") or n:find("crop") then
                total = total + 1
            end
        end
    end
    print("VoidSnow | Фруктов на сервере: " .. total)
end

local function teleportToNPC()
    if not cfg.teleportToNPC then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
            local n = obj.Name:lower()
            if n:find("shop") or n:find("npc") or n:find("merchant") then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(obj:GetPivot().Position + Vector3.new(0, 3, 0))
                end
                break
            end
        end
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

local farmAcc = 0
RunService.Heartbeat:Connect(function(dt)
    farmAcc = farmAcc + dt
    if farmAcc >= cfg.collectInterval then
        farmAcc = 0
        autoCollect()
        autoPlant()
        autoSell()
        autoBuy()
        autoWater()
        autoCraftGear()
        autoCraftSeed()
        autoCooking()
        autoShovel()
        autoSteal()
        deliverStolen()
        autoTame()
        autoFeed()
        autoEquipBest()
        teleportToNPC()
    end
    speed()
    godmode()
    noclip()
    infJump()
    fly()
end)

RunService.RenderStepped:Connect(function()
    if cfg.mutationESP then mutationESP() end
    if cfg.fruitESP then fruitESP() end
    if cfg.hidePlants then hidePlants() end
    fullbright()
    performanceMode()
    fruitCalculator()
end)
