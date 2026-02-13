-- --- SECURITÉ WHITELIST ---
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local whitelistURL = "https://raw.githubusercontent.com/hesskahmdl/Script-Roblox-/refs/heads/main/whitelist.lua"

local function check()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(whitelistURL))()
    end)
    if success and type(result) == "table" then
        for _, id in ipairs(result) do
            if lp.UserId == id then return true end
        end
    end
    return false
end

if not check() then
    lp:Kick("ACCÈS REFUSÉ. Ton ID: " .. lp.UserId)
    return
end

-- --- CODE DU HUB (V18) ---
local RunService = game:GetService("RunService")
if lp.PlayerGui:FindFirstChild("H3SSKA_MODERN") then lp.PlayerGui.H3SSKA_MODERN:Destroy() end

getgenv().CONFIG = {AUTO_STEAL = false, AUTO_POTION = false, SPEED_ENABLED = false, SPEED_VALUE = 34, STEAL_RANGE = 20}
local InternalStealCache, IsStealing, StealProgress = {}, false, 0

local sg = Instance.new("ScreenGui", lp.PlayerGui); sg.Name = "H3SSKA_MODERN"; sg.ResetOnSpawn = false
local main = Instance.new("Frame", sg); main.Size = UDim2.new(0, 400, 0, 260); main.Position = UDim2.new(0.5, -200, 0.5, -130); main.BackgroundColor3 = Color3.fromRGB(15, 12, 12); main.Active = true; main.Draggable = true
Instance.new("UICorner", main)
local title = Instance.new("TextLabel", main); title.Size = UDim2.new(1, 0, 0, 40); title.Text = "H3SSKA HUB V18"; title.TextColor3 = Color3.new(1,1,1); title.BackgroundTransparency = 1; title.Font = "GothamBold"
local close = Instance.new("TextButton", main); close.Size = UDim2.new(0, 30, 0, 30); close.Position = UDim2.new(1, -35, 0, 5); close.Text = "X"; close.TextColor3 = Color3.new(1,1,0); close.BackgroundTransparency = 1; close.MouseButton1Click:Connect(function() sg:Destroy() end)
print("H3SSKA HUB CHARGÉ AVEC SUCCÈS")
