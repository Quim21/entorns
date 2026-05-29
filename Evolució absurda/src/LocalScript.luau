--[[
    UI MEJORADA: EVOLUCIÓ ABSURDA
    Instrucciones: Reemplaza el LocalScript en StarterGui > EvolucioGui por este.
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local stats = player:WaitForChild("leaderstats")

local screenGui = script.Parent

-- Crear Contenedor Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainContainer"
mainFrame.Size = UDim2.new(0, 350, 0, 80)
mainFrame.Position = UDim2.new(0.5, -175, 0.05, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Esquinas redondeadas
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Texto de Evolución
local evoLabel = Instance.new("TextLabel")
evoLabel.Size = UDim2.new(1, -20, 0, 30)
evoLabel.Position = UDim2.new(0, 10, 0, 5)
evoLabel.BackgroundTransparency = 1
evoLabel.Font = Enum.Font.GothamBold
evoLabel.TextColor3 = Color3.new(1, 1, 1)
evoLabel.TextSize = 18
evoLabel.TextXAlignment = Enum.TextXAlignment.Left
evoLabel.Parent = mainFrame

-- Texto de Energía
local energyLabel = Instance.new("TextLabel")
energyLabel.Size = UDim2.new(1, -20, 0, 20)
energyLabel.Position = UDim2.new(0, 10, 0, 30)
energyLabel.BackgroundTransparency = 1
energyLabel.Font = Enum.Font.Gotham
energyLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
energyLabel.TextSize = 14
energyLabel.TextXAlignment = Enum.TextXAlignment.Left
energyLabel.Parent = mainFrame

-- Barra de Progreso (Fondo)
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -20, 0, 10)
barBg.Position = UDim2.new(0, 10, 0, 55)
barBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
barBg.BorderSizePixel = 0
barBg.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

-- Barra de Progreso (Relleno)
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

-- Lógica de actualización
local NOM_FORMES = {[0] = "PIEDRA", [1] = "PLANTA", [2] = "ANIMAL", [3] = "FINAL"}
local LLINDARS = {[0] = 50, [1] = 150, [2] = 300}

local function updateUI()
	local nivell = stats.Nivell.Value
	local energia = stats.Energia.Value
	local maxEnergia = LLINDARS[nivell] or 1000 -- Si es el final, ponemos un tope alto

	evoLabel.Text = "FORMA ACTUAL: " .. (NOM_FORMES[nivell] or "???")
	energyLabel.Text = "ENERGÍA: " .. energia .. " / " .. maxEnergia

	-- Animar la barra de progreso
	local porcentaje = math.clamp(energia / maxEnergia, 0, 1)
	barFill:TweenSize(UDim2.new(porcentaje, 0, 1, 0), "Out", "Quad", 0.3, true)
end

stats.Nivell.Changed:Connect(updateUI)
stats.Energia.Changed:Connect(updateUI)
updateUI()
