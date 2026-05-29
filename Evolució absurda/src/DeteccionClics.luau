--[[
    CLICS CLIENTE: EVOLUCIÓ ABSURDA
    Instrucciones: Pon este LocalScript en StarterPlayer > StarterPlayerScripts.
--]]

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local clicEvent = ReplicatedStorage:WaitForChild("EnergiaPorClic")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end -- No contar clics en botones de la UI

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		clicEvent:FireServer() -- Avisar al servidor para ganar +1 energía
	end
end)
