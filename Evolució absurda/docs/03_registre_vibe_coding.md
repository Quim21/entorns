# 📝 Registre de Vibe Coding - Evolució Absurda

Aquest document detalla el procés iteratiu de desenvolupament i la resolució de problemes tècnics mitjançant l'ús d'IA.

## 🛠️ Resolució de Problemes Tècnics

### 1. El Problema de la Visibilitat dels Models
**Descripció**: Els models personalitzats (pedra, planta) no apareixien o feien que el personatge no respawnegés perquè no tenien la jerarquia estàndard de Roblox (`HumanoidRootPart`).
**Solució**: Es va implementar un sistema de **"WeldConstraint"**. El personatge original de Roblox es fa invisible i el model personalitzat es solda dinàmicament al `HumanoidRootPart` invisible. Això permet utilitzar qualsevol model estètic com a personatge jugable.

### 2. Errors de Física (Models Voladors)
**Descripció**: En soldar els models, la col·lisió de les peces feia que el personatge sortís disparat pel mapa.
**Solució**: S'ha programat una funció que recorre totes les peces del model i els assigna les propietats `Massless = true` i `CanCollide = false` en temps d'execució. Això garanteix que el moviment sigui dictat pel personatge invisible i no per la geometria del model.

### 3. Error de PrimaryPart en Unions
**Descripció**: Les `UnionOperation` no tenen la propietat `PrimaryPart`, el que causava errors en el codi del servidor.
**Solució**: Es va canviar la lògica per utilitzar `PivotTo()` i un sistema de cerca de BaseParts que no depèn de la configuració manual del model a Studio.

## 🤖 Reflexió sobre el Vibe Coding
L'ús de la IA ha permès centrar-se en el **disseny i la jugabilitat** mentre la IA s'encarregava de la sintaxi de Lua i de la resolució d'errors complexos de l'API de Roblox. El procés ha estat un diàleg constant entre el dissenyador i l'agent per polir la fluïdesa del joc.
