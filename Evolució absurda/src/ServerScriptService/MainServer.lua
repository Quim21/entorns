-- MainServer.lua - Bucle principal servidor
local CONFIG = require(ReplicatedStorage.Configuracio)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Taula jugadors actius
local jugadorsActius = {}

-- Configuració global (simplificada)
local CONFIG = {
    energiaPerOrbe = 10,
    energiaPerEvolucio = 50
}

-- Inicialitzar jugador
local function inicialitzarJugador(player)
    local jugador = {
        player = player,
        energiaActual = 0,
        nivelEvolucio = 0,
        modelActual = player.Character
    }
    jugadorsActius[player] = jugador
    print(player.Name .. " ha entrat al joc!")
end

Players.PlayerAdded:Connect(inicialitzarJugador)

-- Bucle principal (cada frame)
RunService.Heartbeat:Connect(function()
    for player, jugador in pairs(jugadorsActius) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            
            -- Detectar energia propera (orbe a 5 studs)
            local orbEnergia = workspace:FindFirstChild("OrbeEnergia")
            if orbEnergia and (orbEnergia.Position - pos).Magnitude < 5 then
                jugador.energiaActual = jugador.energiaActual + CONFIG.energiaPerOrbe
                orbEnergia:Destroy()
                print(player.Name .. " recull energia! Total: " .. jugador.energiaActual)
                
                -- Recrear orbe cada 3 segons
                wait(3)
                local nouOrbe = Instance.new("Part")
                nouOrbe.Name = "OrbeEnergia"
                nouOrbe.Size = Vector3.new(2,2,2)
                nouOrbe.Position = Vector3.new(math.random(-20,20), 5, math.random(-20,20))
                nouOrbe.BrickColor = BrickColor.new("Bright green")
                nouOrbe.Parent = workspace
            end
            
            -- Comprovar evolució
            if jugador.energiaActual >= CONFIG.energiaPerEvolucio and jugador.nivelEvolucio == 0 then
                jugador.nivelEvolucio = 1
                jugador.energiaActual = 0
                print(player.Name .. " ha evolucionat a Planta!")
                -- Canvi visual simple: color verd
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.BrickColor = BrickColor.new("Bright green")
                    end
                end
            end
        end
    end
end)