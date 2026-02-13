-- --- H3SSKA HUB V18 (SÉCURISÉ) ---
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- 1. LE LIEN VERS TA WHITELIST
local whitelistURL = "https://raw.githubusercontent.com/hesskahmdl/Script-Roblox-/refs/heads/main/whitelist.lua"

-- 2. FONCTION DE VÉRIFICATION
local function checkWhitelist()
    local success, result = pcall(function()
        -- On récupère le contenu de ta whitelist sur GitHub
        return loadstring(game:HttpGet(whitelistURL))()
    end)

    if success and type(result) == "table" then
        for _, id in ipairs(result) do
            if lp.UserId == id then
                return true -- L'ID est autorisé
            end
        end
    end
    return false -- L'ID n'est pas autorisé
end

-- 3. EXÉCUTION DE LA SÉCURITÉ
if not checkWhitelist() then
    warn("ACCÈS REFUSÉ : " .. lp.UserId)
    lp:Kick("❌ H3SSKA HUB : Tu n'es pas whitelisté ! ID: " .. lp.UserId)
    return -- ARRÊTE COMPLÈTEMENT LE SCRIPT
end

-- --- SI LE JOUEUR EST WHITELISTÉ, LE CODE CI-DESSOUS SE LANCE ---
print("✅ Accès autorisé ! Bienvenue " .. lp.Name)

local RunService = game:GetService("RunService")
if lp.PlayerGui:FindFirstChild("H3SSKA_MODERN") then lp.PlayerGui.H3SSKA_MODERN:Destroy() end

getgenv().CONFIG = {
    AUTO_STEAL = false,
    AUTO_POTION = false,
    SPEED_ENABLED = false,
    SPEED_VALUE = 34,
    STEAL_RANGE = 20
}

local InternalStealCache, IsStealing, StealProgress, circleParts, allAnimalsCache = {}, false, 0, {}, {}

-- LOGIQUE CORE
local function useStealPotion()
    if not getgenv().CONFIG.AUTO_POTION then return end
    local char, bp = lp.Character, lp:FindFirstChild("Backpack")
    local pot = char:FindFirstChild("Giant Potion") or bp:FindFirstChild("Giant Potion") or char:FindFirstChild("Steal Potion") or bp:FindFirstChild("Steal Potion")
    if pot then pot.Parent = char; task.wait(0.01); pot:Activate() end
end

local function executeSteal(p)
    if InternalStealCache[p] and not InternalStealCache[p].ready then return end
    if not InternalStealCache[p] then
        local d = {hold = {}, trig = {}, ready = true}
        local ok1, c1 = pcall(getconnections, p.PromptButtonHoldBegan)
        if ok1 then for _, v in ipairs(c1) do table.insert(d.hold, v.Function) end
