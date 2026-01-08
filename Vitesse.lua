-- Création de l'interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextLabel = Instance.new("TextLabel")

-- Propriétés de l'interface
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Position = UDim2.new(0.5, -75, 0.5, -50)
Frame.Size = UDim2.new(0, 150, 0, 100)
Frame.Active = true
Frame.Draggable = true -- Tu peux déplacer la fenêtre

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 30)
TextLabel.Text = "Vitesse (WalkSpeed)"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1

TextBox.Parent = Frame
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.PlaceholderText = "Ex: 50"
TextBox.Text = ""

-- Logique de changement de vitesse
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(TextBox.Text)
        if num then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
            print("Vitesse réglée sur : " .. num)
        end
    end
end)
