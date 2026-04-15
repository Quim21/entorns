# 01_idea_i_abast.md

## 1. Títol provisional del joc
**Evolució Absurda**

---

## 2. Tipus de microvideojoc escollit
Microvideojoc de simulació i progressió amb elements multijugador simples.

---

## 3. Objectiu del joc
L’objectiu del jugador és evolucionar el seu personatge acumulant energia fins arribar a la forma final, desbloquejant noves habilitats a cada evolució.

---

## 4. Rol del jugador
El jugador controla un personatge que comença com una forma bàsica (per exemple, una pedra).

Pot:
- Moure’s pel mapa
- Recollir energia
- Interactuar amb l’entorn
- Evolucionar
- Interactuar amb altres jugadors (empènyer, bloquejar)

---

## 5. Regles bàsiques
- El jugador guanya energia movent-se i recollint objectes.
- Quan arriba a certa quantitat d’energia, evoluciona.
- Cada evolució dona una nova habilitat.
- Hi ha zones del mapa amb perills (lava, trampes).
- Els jugadors poden interferir entre ells.

---

## 6. Condicions de victòria i derrota
No hi ha ni victòria ni derrota, es un joc progressiu, el que pot comptar com a derrota pot ser morir.


---

## 7. Bucle principal del joc
1. El jugador es mou pel mapa  
2. Recull energia  
3. Evita perills  
4. Evoluciona  
5. Obté noves habilitats  
6. Repeteix el procés  

---

## 8. Repte principal i dificultat
**Repte principal:**
Gestionar el moviment i les habilitats mentre s’eviten perills i altres jugadors.

**Dificultat:**
Baixa-mitjana. El joc ha de ser fàcil d’entendre però progressivament més caòtic.

---

## 9. Limitacions explícites
El joc NO inclourà:
- Història complexa
- Grans mapes oberts
- Sistemes avançats d’inventari
- IA complexa d’enemics
- Més de 3-4 evolucions inicials
- Gràfics avançats o personalització extensa

---

## 10. Riscos tècnics
1. Problemes al canviar el model del jugador en cada evolució.
2. Errors en la sincronització multijugador.
3. Dificultat en implementar habilitats diferents per cada forma.

---

## 11. Exploració amb IA

**Prompt 1:**
"Dona idees de videojocs simples i addictius per Roblox"

**Resposta resumida:**
Idees basades en mecàniques simples, bucles ràpids i multijugador, com carreres, supervivència i progressió.

---

**Prompt 2:**
"Com fer un sistema de progressió amb evolucions en Roblox Studio"

**Resposta resumida:**
Crear un sistema de punts (energia), detectar quan arriba a un llindar i canviar el model i habilitats del jugador.

---

## 12. Proposta final escollida
Un joc de progressió on el jugador evoluciona a través de formes absurdes amb habilitats úniques en un mapa petit amb altres jugadors.

---

## 13. Justificació de viabilitat
- Mecàniques simples de programar
- Escalable (es poden afegir més evolucions després)
- No requereix molts recursos gràfics
- Adequat per completar en aproximadament 10 hores

---

## 14. Mini pla de treball

**Fase 1 (2h):**
Sistema de moviment i recollida d’energia

**Fase 2 (3h):**
Sistema d’evolució (3 formes)

**Fase 3 (2h):**
Afegir habilitats bàsiques

**Fase 4 (2h):**
Disseny del mapa i perills

**Fase 5 (1h):**
Proves i ajustos finals

---

## 15. Eines previstes i justificació

- **Roblox Studio**  
Per crear el joc i programar-lo en Lua.

- **Lua (llenguatge de programació)**  
És el llenguatge natiu de Roblox.

- **IA (ChatGPT)**  
Per generar idees, solucionar problemes i ajudar amb scripts.

- **Assets de Roblox Toolbox**  
Per accelerar el desenvolupament amb models bàsics.