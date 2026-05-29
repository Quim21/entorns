--[[
    NÚCLEO FIX UNION: EVOLUCIÓ ABSURDA
    Soluciona el error de PrimaryPart en UnionOperations.
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = {
	LLINDARS = {[0] = 50, [1] = 150, [2] = 300},
	MULTIPLICADORS = {
		[0] = {clic = 1, bola = 10},
		[1] = {clic = 2, bola = 20},
		[2] = {clic = 5, bola = 50},
		[3] = {clic = 10, bola = 100}
	},
	NOM_FORMES = {[0] = "pedra", [1] = "planta", [2] = "animal", [3] = "humano"}
}

local clicEvent = ReplicatedStorage:FindFirstChild("EnergiaPorClic") or Instance.new("RemoteEvent", ReplicatedStorage)
clicEvent.Name = "EnergiaPorClic"

local function actualizarCaparazon(player, character, nivel)
	local viejo = character:FindFirstChild("CuerpoVisual")
	if viejo then viejo:Destroy() end

	local nomModel = CONFIG.NOM_FORMES[nivel]
	local modelsFolder = ReplicatedStorage:WaitForChild("Models")
	local template = modelsFolder:FindFirstChild(nomModel)

	if template then
		local nuevo = template:Clone()
		nuevo.Name = "CuerpoVisual"
		nuevo.Parent = character

		-- BUSCADOR DE PIEZA SEGURO (Funciona con Uniones y Modelos)
		local piezaAncla = nil

		-- Si el objeto es una pieza, esa es el ancla
		if nuevo:IsA("BasePart") then
			piezaAncla = nuevo
		else
			-- Si es un modelo, buscamos dentro
			piezaAncla = nuevo:FindFirstChild("HumanoidRootPart")
			if not piezaAncla then
				for _, obj in pairs(nuevo:GetDescendants()) do
					if obj:IsA("BasePart") then
						piezaAncla = obj
						break
					end
				end
			end
		end

		-- Configurar física de todas las piezas
		local function limpiarFisica(obj)
			if obj:IsA("BasePart") then
				obj.Anchored = false
				obj.CanCollide = false
				obj.Massless = true
				obj.Transparency = 0
			end
		end

		limpiarFisica(nuevo)
		for _, obj in pairs(nuevo:GetDescendants()) do limpiarFisica(obj) end

		local hrp = character:WaitForChild("HumanoidRootPart")
		if piezaAncla and hrp then
			nuevo:PivotTo(hrp.CFrame)
			local weld = Instance.new("WeldConstraint", hrp)
			weld.Part0 = hrp
			weld.Part1 = piezaAncla

			-- Soldar el resto si es un modelo
			if not nuevo:IsA("BasePart") then
				for _, p in pairs(nuevo:GetDescendants()) do
					if p:IsA("BasePart") and p ~= piezaAncla then
						local w = Instance.new("WeldConstraint", piezaAncla)
						w.Part0 = piezaAncla; w.Part1 = p
					end
				end
			end
			print("? Evolucionado correctamente a " .. nomModel)
		end
	end
end

-- [GESTIÓN DE JUGADORES Y ENERGÍA]
Players.PlayerAdded:Connect(function(player)
	local stats = Instance.new("Folder", player); stats.Name = "leaderstats"
	local energia = Instance.new("IntValue", stats); energia.Name = "Energia"
	local nivell = Instance.new("IntValue", stats); nivell.Name = "Nivell"
	player.CharacterAdded:Connect(function(char)
		task.wait(0.5)
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 1 end
		end
		actualizarCaparazon(player, char, nivell.Value)
	end)
	energia.Changed:Connect(function(valor)
		local llindar = CONFIG.LLINDARS[nivell.Value]
		if llindar and valor >= llindar then
			nivell.Value += 1
			if player.Character then actualizarCaparazon(player, player.Character, nivell.Value) end
		end
	end)
end)

clicEvent.OnServerEvent:Connect(function(player)
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		local mult = CONFIG.MULTIPLICADORS[stats.Nivell.Value] or CONFIG.MULTIPLICADORS[0]
		stats.Energia.Value += mult.clic
	end
end)

task.spawn(function()
	local folder = workspace:FindFirstChild("EnergiasMapa") or Instance.new("Folder", workspace)
	folder.Name = "EnergiasMapa"
	while true do
		if #folder:GetChildren() < 15 then
			local p = Instance.new("Part", folder); p.Name = "Energia"; p.Size = Vector3.new(2,2,2); p.Shape = Enum.PartType.Ball
			p.Position = Vector3.new(math.random(-50, 50), 4, math.random(-50, 50))
			p.BrickColor = BrickColor.new("Bright yellow"); p.Material = Enum.Material.Neon
			p.Anchored = true; p.CanCollide = false
			p.Touched:Connect(function(hit)
				local plr = Players:GetPlayerFromCharacter(hit.Parent)
				if plr then
					local mult = CONFIG.MULTIPLICADORS[plr.leaderstats.Nivell.Value] or CONFIG.MULTIPLICADORS[0]
					plr.leaderstats.Energia.Value += mult.bola
					p:Destroy()
				end
			end)
		end
		task.wait(3)
	end
end)
