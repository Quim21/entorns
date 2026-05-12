-- MovimentClient.lua - Entrada usuari (WASD)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local tecles = {W = false, A = false, S = false, D = false}

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then tecles.W = true
    elseif input.KeyCode == Enum.KeyCode.A then tecles.A = true
    elseif input.KeyCode == Enum.KeyCode.S then tecles.S = true
    elseif input.KeyCode == Enum.KeyCode.D then tecles.D = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then tecles.W = false
    elseif input.KeyCode == Enum.KeyCode.A then tecles.A = false
    elseif input.KeyCode == Enum.KeyCode.S then tecles.S = false
    elseif input.KeyCode == Enum.KeyCode.D then tecles.D = false end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    local moveVector = Vector3.new(
        (tecles.D and 1 or 0) - (tecles.A and 1 or 0),
        0,
        (tecles.S and 1 or 0) - (tecles.W and 1 or 0)
    )
    humanoid:Move(moveVector)
end)