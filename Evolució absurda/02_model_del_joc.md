# 02_model_del_joc.md

## 1. Components principals del joc

Evolució Absurda és un joc de progressió basat en l'acumulació d'energia i l'evolució del personatge. Els components principals identificats són:

- **Jugador**: L'entitat controlada per l'usuari que evoluciona al llarg de la partida
- **Sistema d'Evolució**: El mecanisme que gestiona les transformacions i habilitats
- **Energia**: Els recursos que el jugador ha de recollir per evolucionar
- **Zones de Perill**: Obstacles i perills que afegeixen dificultat al joc
- **Mapa**: L'entorn on es desenvolupa l'acció i que conté tots els elements anteriors

---

## 2. Entitats identificades

### 2.1 Jugador
Representa el personatge controlat per l'usuari. És l'entitat central del joc.

### 2.2 SistemaEvolucio
Classe que gestiona la lògica d'evolució, incloses les condicions per canviar de forma i les habilitats disponibles.

### 2.3 Energia
Objectes col·leccionables distribuïts pel mapa que permeten al jugador progressar.

### 2.4 ZonaPerill
Regions del mapa que representen obstacles i perills (lava, trampes, etc.).

### 2.5 Mapa
Contenidor principal que gestiona l'escenari del joc i coordina tots els elements.

---

## 3. Atributs clau de cada entitat

### 3.1 Jugador
- `energiaActual: number` - Quantitat d'energia acumulada pel jugador
- `nivelEvolucio: number` - Nivell actual d'evolució (0 = Pedra, 1 = següent forma, etc.)
- `velocitat: number` - Velocitat de moviment del personatge
- `modelActual: Model` - Referència al model 3D actual del personatge a Roblox

### 3.2 SistemaEvolucio
- `llindarEvolucio: array` - Llista de valors d'energia necessaris per cada evolució (ex: [50, 150, 300])
- `habilitats: array` - Llista d'habilitats disponibles per cada nivell d'evolució
- `models: array` - Llista de models 3D corresponents a cada forma

### 3.3 Energia
- `valor: number` - Quantitat d'energia que proporciona quan es recull (normalment 10)
- `posicio: Vector3` - Posició 3D on apareix l'energia al mapa
- `activa: boolean` - Indica si l'energia està disponible per recollir o ja ha estat recollida

### 3.4 ZonaPerill
- `tipus: string` - Tipus de perill (lava, trampa, espines, etc.)
- `dany: number` - Quantitat d'energia que es perd en contacte
- `area: Region3` - Regió 3D que defineix l'àrea de perill a Roblox

### 3.5 Mapa
- `zones: array` - Llista de totes les ZonaPerill del mapa
- `energies: array` - Llista de totes les instàncies d'Energia al mapa
- `jugadors: array` - Llista de jugadors connectats (per multijugador)
- `tamany: Vector3` - Dimensions del mapa

---

## 4. Accions, mètodes o funcions principals

### 4.1 Jugador
- `moure()` - Gestiona el moviment del personatge segons l'input del jugador (WASD o tecles direccionals)
- `recollirEnergia()` - Detecta col·lisió amb Energia i incrementa energiaActual
- `utilitzarHabilitat()` - Executa l'habilitat corresponent al nivell d'evolució actual

### 4.2 SistemaEvolucio
- `comprovarEvolucio(jugador)` - Verifica si el jugador té prou energia per evolucionar
- `aplicarEvolucio(jugador)` - Incrementa el nivelEvolucio i reseteja l'energia a 0
- `desbloquearHabilitat(nivell)` - Retorna la habilitat corresponent al nivell especificat
- `canviarModel(jugador, nivell)` - Canvia el model 3D del jugador al model de la nova forma

### 4.3 Energia
- `aparixer()` - Fa visible i activa l'objecte d'energia al mapa
- `desaparixer()` - Marca l'energia com a recollida i la fa invisible

### 4.4 ZonaPerill
- `detectarJugador()` - Comprova si un jugador està dins de l'àrea de perill
- `aplicarDany(jugador)` - Resta energia del jugador quan entra en contacte

### 4.5 Mapa
- `generarEnergia()` - Crea noves instàncies d'Energia en posicions aleatòries del mapa
- `actualitzar()` - Bucle principal que crida els mètodes de detecció i actualització de tots els elements

---

## 5. Explicació del diagrama de classes

El diagrama de classes mostra les 5 entitats principals del joc i com es relacionen entre elles:

**Jugador** és la classe central. Té una relació d'ús amb **SistemaEvolucio** (el jugador utilitza aquest sistema per evolucionar), una relació de recollida amb **Energia** (el jugador recull energia del mapa), i una relació d'evitar amb **ZonaPerill** (el jugador ha d'evitar aquestes zones).

**Mapa** és el contenidor que gestiona tots els elements. Conté múltiples instàncies de **ZonaPerill** i **Energia**, i també gestiona els jugadors connectats. Genera energia periòdicament i actualitza l'estat de tots els elements.

**SistemaEvolucio** és independent i pot ser utilitzat per qualsevol jugador. Emmagatzema els llindars d'evolució, les habilitats i els models per a cada forma.

**Organització per colors:**
- Morat (Jugador): L'entitat principal controlada per l'usuari
- Turquesa (SistemaEvolucio): Sistema de gestió i lògica
- Ambre (Energia): Recursos col·leccionables
- Coral (ZonaPerill): Elements de risc i dificultat
- Blau (Mapa): Entorn i contenidor general

Aquest model permet una separació clara de responsabilitats: el Jugador gestiona l'estat individual, el Mapa coordina l'escenari global, i el SistemaEvolucio encapsula tota la lògica de progressió.

---

## 6. Explicació del diagrama de comportament

El diagrama d'activitat representa el **bucle principal del joc**, és a dir, el flux d'accions que es repeteix contínuament durant una partida.

**Seqüència d'execució:**

1. **Inici de partida**: El jugador apareix al mapa en la forma inicial (Pedra)

2. **Bucle principal** (es repeteix fins que el jugador mor):
   - **Moure's pel mapa**: El jugador controla el moviment amb WASD o tecles direccionals
   - **Decisió: Energia a prop?**
     - **Sí**: Recull energia (+10 energia)
     - **No**: Continua
   - **Decisió: Zona de perill?**
     - **Sí**: Rep dany i perd energia
       - **Decisió: Mort?**
         - **Sí**: Fi de partida
         - **No**: Continua jugant
     - **No**: Continua
   - **Decisió: Energia ≥ llindar?**
     - **Sí**: Evoluciona (nova forma + nova habilitat)
     - **No**: Continua jugant
   - Torna al principi del bucle

Aquest diagrama reflecteix les mecàniques descrites a la fase 1:
- Moviment constant
- Recollida d'energia
- Evitar perills
- Sistema de progressió per evolució

El jugador té control continu del seu personatge i ha de prendre decisions sobre on moure's per maximitzar la recollida d'energia i evitar perills.

---

## 7. Correspondència entre diagrames i codi futur

### 7.1 Del diagrama de classes al codi Lua

Cada classe del diagrama es traduirà en un **ModuleScript** independent a Roblox Studio:

```
ServerScriptService/
├── Jugador.lua
├── SistemaEvolucio.lua
├── Energia.lua
├── ZonaPerill.lua
└── Mapa.lua
```

**Exemple de traducció - Jugador.lua:**

```lua
local Jugador = {}
Jugador.__index = Jugador

function Jugador.new(player)
    local self = setmetatable({}, Jugador)
    self.player = player
    self.energiaActual = 0
    self.nivelEvolucio = 0
    self.velocitat = 16
    self.modelActual = nil
    return self
end

function Jugador:moure()
    -- Gestiona el moviment segons UserInputService
end

function Jugador:recollirEnergia(valorEnergia)
    self.energiaActual = self.energiaActual + valorEnergia
end

function Jugador:utilitzarHabilitat()
    -- Executa l'habilitat del nivell actual
end

return Jugador
```

Els atributs del diagrama es converteixen en propietats de la taula `self`, i els mètodes es converteixen en funcions dins del mòdul.

### 7.2 Del diagrama d'activitat al codi

El diagrama d'activitat es tradueix en el **bucle principal del servidor** que s'executa contínuament:

```lua
-- Script principal al ServerScriptService
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    for _, jugador in pairs(jugadorsActius) do
        -- Comprovar si hi ha energia a prop
        local energiaProxima = Mapa:detectarEnergia(jugador)
        if energiaProxima then
            jugador:recollirEnergia(energiaProxima.valor)
            energiaProxima:desaparixer()
        end
        
        -- Comprovar si està en zona de perill
        local zonaPerill = Mapa:detectarPerill(jugador)
        if zonaPerill then
            zonaPerill:aplicarDany(jugador)
            if jugador.energiaActual <= 0 then
                -- Fi de partida per aquest jugador
                fiPartida(jugador)
            end
        end
        
        -- Comprovar si pot evolucionar
        if SistemaEvolucio:comprovarEvolucio(jugador) then
            SistemaEvolucio:aplicarEvolucio(jugador)
        end
    end
end)
```

Cada decisió del diagrama es converteix en una condició `if`, i els processos es converteixen en crides a funcions.

### 7.3 Correspondència amb Roblox Studio

- **Jugador.modelActual** → Farà referència a un objecte `Model` dins de `ReplicatedStorage` o al propi `Character` del player
- **Energia.posicio** → Serà un `Vector3` que defineix la posició de la `Part` o `Model` de l'energia
- **ZonaPerill.area** → Es crearà com una `Part` invisible amb `CanCollide = false` i un event `.Touched`
- **Mapa.zones** → Array que contindrà referències a les `Part` de les zones de perill creades a l'editor

---

## 8. Estructura inicial del repositori

```
evolucio-absurda/
│
├── README.md                    # Descripció del projecte
├── .gitignore                   # Arxius a ignorar (rbxl.lock, etc.)
│
├── docs/                        # Documentació del projecte
│   ├── 01_idea_i_abast.md
│   ├── 02_model_del_joc.md
│   └── diagrames/
│       ├── diagrama_classes.png
│       └── diagrama_comportament.png
│
├── src/                         # Codi font del joc
│   ├── ServerScriptService/     # Scripts del servidor
│   │   ├── Jugador.lua
│   │   ├── SistemaEvolucio.lua
│   │   ├── Energia.lua
│   │   ├── ZonaPerill.lua
│   │   ├── Mapa.lua
│   │   └── MainServer.lua
│   │
│   ├── ReplicatedStorage/       # Recursos compartits
│   │   ├── Models/              # Models 3D de les formes
│   │   │   ├── Pedra.rbxm
│   │   │   ├── Planta.rbxm
│   │   │   └── Animal.rbxm
│   │   └── Configuracio.lua     # Configuració global
│   │
│   └── StarterPlayer/           # Scripts del client
│       └── StarterPlayerScripts/
│           ├── MovimentClient.lua
│           └── UIClient.lua
│
└── assets/                      # Recursos addicionals
    ├── mapes/                   # Arxius .rbxl del mapa
    └── sons/                    # Efectes de so (si s'afegeixen)
```

**Justificació de l'estructura:**

- **docs/**: Conté tota la documentació generada durant el desenvolupament
- **src/**: Reflecteix l'estructura de Roblox Studio per facilitar la sincronització
  - **ServerScriptService**: Scripts que s'executen al servidor (lògica del joc)
  - **ReplicatedStorage**: Recursos accessibles tant des del servidor com del client
  - **StarterPlayer**: Scripts que s'executen al client de cada jugador
- **assets/**: Materials que no s'importen directament al joc però són part del projecte

Aquesta estructura facilita:
- Versionat de codi amb Git
- Separació clara entre client i servidor
- Organització modular (cada entitat és un arxiu independent)
- Escalabilitat futura (fàcil afegir noves formes, habilitats, etc.)

---

## 9. Primer commit i README inicial

### 9.1 Contingut del primer commit

El primer commit inclou:
- README.md amb la descripció bàsica del projecte
- Estructura de carpetes inicial
- Arxius de documentació de les fases 1 i 2
- Diagrames exportats en format PNG
- .gitignore configurat per a projectes Roblox

### 9.2 README inicial

El README.md conté:

```markdown
# Evolució Absurda

Microvideojoc de simulació i progressió per a Roblox.

## Descripció

Evolució Absurda és un joc on el jugador comença com una forma bàsica (pedra) i evoluciona a través de diferents formes absurdes acumulant energia. Cada evolució desbloqueja noves habilitats úniques.

## Objectiu

Evolucionar el teu personatge recollint energia, evitant perills i interactuant amb altres jugadors en un entorn multijugador simple.

## Estat del projecte

🚧 **En desenvolupament** - Fase 2: Model del joc

## Tecnologies

- **Motor**: Roblox Studio
- **Llenguatge**: Lua
- **Control de versions**: Git/GitHub

## Documentació

- [Idea i abast](docs/01_idea_i_abast.md)
- [Model del joc](docs/02_model_del_joc.md)

## Autor

[El teu nom]

## Llicència

Aquest projecte és amb finalitats educatives.
```

Aquest README proporciona una visió general ràpida del projecte i enllaços a la documentació detallada.

---

## Resum

Aquest document defineix el model complet del joc "Evolució Absurda":

- **5 entitats principals** amb atributs i mètodes ben definits
- **Diagrama de classes** que mostra les relacions entre entitats
- **Diagrama d'activitat** que representa el bucle de joc
- **Correspondència clara** entre model conceptual i implementació en Lua
- **Estructura de repositori** organitzada i escalable
- **Primer commit** amb README i documentació inicial

Aquest model serveix com a base sòlida per començar la implementació del joc a la fase 3, assegurant que totes les mecàniques estan ben planificades i estructurades.
