-- --- SÉCURITÉ WHITELIST ---
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Whitelist = {
    ["Lacostedu12"] = true, -- Ton pseudo
    -- ["AutrePseudo"] = true, (Exemple pour ajouter quelqu'un)
}

if not Whitelist[LocalPlayer.Name] then
    LocalPlayer:Kick([[u are not whitelisted go buy the access in https://discord.gg/sFmfhdt3V2

SMVLLHUB OT]])
    task.wait(9e9)
    return -- Arrête le script ici
end

print("✅ Accès accordé, bienvenue "..LocalPlayer.Name)

-- --- DÉBUT DU H3SSKA HUB V18 ---
local RunService = game:GetService("RunService")
if LocalPlayer.PlayerGui:FindFirstChild("H3SSKA_MODERN") then LocalPlayer.PlayerGui.H3SSKA_MODERN:Destroy() end

getgenv().CONFIG = {
    AUTO_STEAL = false,
    AUTO_POTION = false,
    SPEED_ENABLED = false,
    SPEED_VALUE = 34,
    STEAL_RANGE = 20
}

local InternalStealCache, IsStealing, StealProgress, allAnimalsCache = {}, false, 0, {}

-- FONCTION POTION
local function useStealPotion()
    if not getgenv().CONFIG.AUTO_POTION then return end
    local char, bp = LocalPlayer.Character, LocalPlayer:FindFirstChild("Backpack")
    local pot = char:FindFirstChild("Giant Potion") or bp:FindFirstChild("Giant Potion") or char:FindFirstChild("Steal Potion") or bp:FindFirstChild("Steal Potion")
    if pot then pot.Parent = char; task.wait(0.01); pot:Activate() end
end

-- FONCTION VOL
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
        local start, dur = tick(), (p.HoldDuration > 0 and p.HoldDuration or 1.3)
        while tick() - start < (dur - 0.01) do StealProgress = (tick() - start) / dur; task.wait() end
        useStealPotion(); task.wait(0.01); StealProgress = 1
        for _, f in ipairs(data.trig) do task.spawn(f) end
        task.wait(0.1); data.ready = true; IsStealing = false; StealProgress = 0
    end)
end

-- --- INTERFACE GRAPHIQUE ---
local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui); sg.Name = "H3SSKA_MODERN"; sg.ResetOnSpawn = false
local main = Instance.new("Frame", sg)
main.Size, main.Position = UDim2.new(0, 400, 0, 260), UDim2.new(0.5, -200, 0.5, -130)
main.BackgroundColor3, main.Active, main.Draggable = Color3.fromRGB(15, 12, 12), true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

-- CONTOUR
