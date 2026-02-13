-- --- SÉCURITÉ WHITELIST PAR PSEUDO ---
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Whitelist = {
    ["Lacostedu12"] = true, -- Ton pseudo autorisé
}

if not Whitelist[LocalPlayer.Name] then
    LocalPlayer:Kick([[u are not whitelisted go buy the access in https://discord.gg/sFmfhdt3V2

SMVLLHUB OT]])
    task.wait(9e9)
    return -- Sécurité pour empêcher le chargement du reste du script
end

-- --- H3SSKA HUB V18 (ROTATING NEON BORDER) ---
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Nettoyage si déjà ouvert
if LocalPlayer.PlayerGui:FindFirstChild("H3SSKA_MODERN") then 
    LocalPlayer.PlayerGui.H3SSKA_MODERN:Destroy() 
end

-- --- CONFIG ---
getgenv().CONFIG = {
    AUTO_STEAL = false,
    AUTO_POTION = false,
    SPEED_ENABLED = false,
    SPEED_VALUE = 34,
    STEAL_RANGE = 20
}

local InternalStealCache = {}
local IsStealing = false
local StealProgress = 0
local circleParts = {}
local allAnimalsCache = {}

-- --- LOGIQUE CORE ---
local function useStealPotion()
    if not getgenv().CONFIG.AUTO_POTION then return end
    local char = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local pot = char:FindFirstChild("Giant Potion") or bp:FindFirstChild("Giant Potion") or char:FindFirstChild("Steal Potion") or bp:FindFirstChild("Steal Potion")
    if pot then pot.Parent = char; task.wait(0.01); pot:Activate() end
end

local function executeSteal(p)
    if InternalStealCache[p] and not InternalStealCache[p].ready then return end
    if not InternalStealCache[p] then
        local d = {hold = {}, trig = {}, ready = true}
        local ok1, c1 = pcall(getconnections, p.PromptButtonHoldBegan)
        if ok1 then for _, v in ipairs(c1) do table.insert(d.hold, v.Function) end end
        local ok2, c2 = pcall(getconnections, p.Triggered)
        if ok2 then for _, v in ipairs(c2) do table.insert(d.trig, v.Function) end end
        InternalStealCache[p] = d
    end
    
    local data = InternalStealCache[p]
    data.ready = false; IsStealing = true
    task.spawn(function()
        for _, f in ipairs(data.hold) do task.spawn(f) end
        local start = tick()
        local dur = p.HoldDuration > 0 and p.HoldDuration or 1.3
        while tick() - start < (dur - 0.01) do
            StealProgress = (tick() - start) / dur
            task.wait()
        end
        useStealPotion()
        task.wait(0.01)
        StealProgress = 1
        for _, f in ipairs(data.trig) do task.spawn(f) end
        task.wait(0.1)
        data.ready = true; IsStealing = false; StealProgress = 0
    end)
end

-- --- UI ---
local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui); sg.Name = "H3SSKA_MODERN"; sg.ResetOnSpawn = false

-- Bouton H (Déplaçable)
local openBtn = Instance.new("TextButton", sg)
openBtn.Size = UDim2.new(0, 45, 0, 45); openBtn.Position = UDim2.new(0, 15, 0.5, -22)
openBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 12); openBtn.Text = "H"; openBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
openBtn.Font = "GothamBlack"; openBtn.TextSize = 25; openBtn.Visible = false; openBtn.Active = true; openBtn.Draggable = true
Instance.new("UICorner", openBtn); Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(255, 255, 0)

-- Fenêtre principale
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 400, 0, 260); main.Position = UDim2.new(0.5, -200, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(15, 12, 12); main.Active = true; main.Draggable = true
local mainCorner = Instance.new("UICorner", main); mainCorner.CornerRadius = UDim.new(0, 8)

-- CONTOUR TOURNANT
local borderStroke = Instance.new("UIStroke", main)
borderStroke.Thickness = 2.5
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local borderGrad = Instance.new("UIGradient", borderStroke)
borderGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
})

task.spawn(function()
    local rot = 0
    while RunService.RenderStepped:Wait() do
        rot = rot + 2.5
        borderGrad.Rotation = rot % 360
    end
end)

-- Titre
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40); title.Text = "H3SSKA HUB"; title.TextColor3 = Color3.new(1,1,1); title.Font = "GothamBold"; title.TextSize = 16; title.BackgroundTransparency = 1
local titleGrad = Instance.new("UIGradient", title)
titleGrad.Color = borderGrad.Color
task.spawn(function()
    local off = -1
    while RunService.RenderStepped:Wait() do
        titleGrad.Offset = Vector2.new(off, 0)
        off = off + 0.018
        if off > 1 then off = -1 end
    end
end)

-- Barre fixe
local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, -10, 0, 1); line.Position = UDim2.new(0, 5, 0, 38); line.BackgroundColor3 = Color3.new(1,1,0); line.BorderSizePixel = 0

-- Bouton Fermer
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -35, 0, 5); closeBtn.BackgroundTransparency = 1; closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.new(1,1,0); closeBtn.Font = "GothamBold"; closeBtn.TextSize = 18

-- Liste options
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -55); container.Position = UDim2.new(0, 10, 0, 45); container.BackgroundTransparency = 1; container.ScrollBarThickness = 0
Instance.new("UIListLayout", container).Padding = UDim.new(0, 8)

-- GRAB HUD
local grabHud = Instance.new("Frame", sg); grabHud.Size = UDim2.new(0, 300, 0, 40); grabHud.Position = UDim2.new(0.5, -150, 0, 45); grabHud.BackgroundTransparency = 1; grabHud.Visible = false; grabHud.Active = true; grabHud.Draggable = true
local barBack = Instance.new("Frame", grabHud); barBack.Size = UDim2.new(0.7, 0, 0, 10); barBack.Position = UDim2.new(0, 0, 0.5, -5); barBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local barFill = Instance.new("Frame", barBack); barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.new(1,1,0)

-- SPEED OVERLAY
local speedOverlay = Instance.new("Frame", sg); speedOverlay.Size = UDim2.new(0, 90, 0, 70); speedOverlay.Position = UDim2.new(1, -110, 0.5, 0); speedOverlay.BackgroundColor3 = Color3.fromRGB(15, 12, 12); speedOverlay.Visible = false; speedOverlay.Active = true; speedOverlay.Draggable = true
Instance.new("UIStroke", speedOverlay).Color = Color3.new(1,1,0); Instance.new("UICorner", speedOverlay)
local sVal = Instance.new("TextBox", speedOverlay); sVal.Size = UDim2.new(1, 0, 0.5, 0); sVal.Text = "34"; sVal.TextColor3 = Color3.new(1,1,1); sVal.BackgroundTransparency = 1; sVal.Font = "GothamBold"
sVal.FocusLost:Connect(function() getgenv().CONFIG.SPEED_VALUE = tonumber(sVal.Text) or 34 end)

local function createToggle(name, callback)
    local frame = Instance.new("Frame", container); frame.Size = UDim2.new(1, -10, 0, 40); frame.BackgroundColor3 = Color3.fromRGB(25, 22, 22); Instance.new("UICorner", frame)
    local label = Instance.new("TextLabel", frame); label.Size = UDim
