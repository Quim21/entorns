-- Configuracio.lua - Valors globals del joc
local Configuracio = {}

Configuracio.energiaPerOrbe = 10
Configuracio.energiaPerEvolucio = {
    [0] = 50,  -- Pedra -> Planta
    [1] = 100, -- Planta -> Animal (futur)
}
Configuracio.velocitatBase = 16
Configuracio.distanciaRecollida = 5
Configuracio.tempsRespawnOrbe = 3

-- Taula evolucions (colors per ara, models futurs)
Configuracio.colorsEvolucio = {
    [0] = BrickColor.new("Dark stone grey"),  -- Pedra
    [1] = BrickColor.new("Bright green")      -- Planta
}

return Configuracio