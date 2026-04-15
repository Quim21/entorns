# Diagrames UML per a *Evolució Absurda*

Aquest document recull els dos codis PlantUML necessaris per generar els diagrames del projecte. El primer correspon al diagrama de classes i el segon al diagrama de comportament. Tots dos estan pensats per ser coherents amb la idea del joc definida a `01_idea_i_abast.md`.

## Diagrama de classes

Aquest diagrama mostra les entitats principals del joc, els seus atributs, els seus mètodes i les relacions bàsiques entre elles. Serveix com a base per organitzar el codi futur de manera clara i modular.

```plantuml
@startuml
skinparam classAttributeIconSize 0

class Jugador {
  +String nom
  +int energia
  +int vida
  +int nivell_evolucio
  +String forma_actual
  +float velocitat
  +String habilitat_actual
  +Vector3 posicio

  +moure()
  +recollirEnergia()
  +rebreDany()
  +evolucionar()
  +activarHabilitat()
}

class Enemic {
  +String tipus
  +int dany
  +String zona
  +bool actiu
  +Vector3 posicio
  +float radi_accio

  +detectarColisio()
  +aplicarDany()
  +activar()
  +desactivar()
}

class Pregunta {
  +String enunciat
  +String[] opcions
  +int resposta_correcta
  +int resposta_seleccionada
  +bool completada

  +ferPregunta()
  +comprovarResposta()
  +reiniciar()
}

class ItemEnergia {
  +int valor
  +Vector3 posicio
  +bool recollit
  +String tipus
  +float temps_aparicio

  +apareixer()
  +serRecollit()
  +reapareixer()
}

class SistemaEvolucio {
  +int[] llindars_energia
  +String[] formes
  +String[] habilitats_per_forma
  +String forma_actual
  +int nivell_maxim

  +comprovarEnergia()
  +canviarForma()
  +assignarHabilitat()
  +obtenirFormaSeguent()
}

class GestorJoc {
  +String estat_joc
  +int temps_partida
  +int energia_total
  +String mapa_actual
  +String objectiu_partida

  +iniciarPartida()
  +actualitzarBucle()
  +comprovarEstat()
  +reiniciarPartida()
}

GestorJoc --> Jugador : coordina
GestorJoc --> Enemic : gestiona
GestorJoc --> ItemEnergia : administra
GestorJoc --> SistemaEvolucio : consulta
GestorJoc --> Pregunta : opcionalment usa
Jugador --> SistemaEvolucio : evoluciona amb
Jugador --> ItemEnergia : recull
Jugador --> Enemic : pateix
@enduml
```

## Diagrama de comportament

Aquest diagrama representa el bucle principal del joc i explica què passa mentre la partida està en marxa. Mostra el flux de moviment, recollida, perill, evolució i repetició.

```plantuml
@startuml
start

:Inici de partida;
:Controlar moviment del jugador;
:Recollir energia;

if (Hi ha perill a prop?) then (Sí)
  :Evitar el perill o rebre dany;
endif

:Comprovar energia acumulada;

if (S'ha arribat al llindar d'evolució?) then (Sí)
  :Evolucionar i desbloquejar habilitat;
endif

if (Vida del jugador > 0?) then (Sí)
  :Continuar amb el bucle;
  -> :Controlar moviment del jugador;
else (No)
  :Fi o reinici de la partida;
  stop
endif

@enduml
```

## Notes d’ús

Per generar les imatges, copia cadascun dels blocs en un fitxer `.puml` diferent o enganxa’ls directament a un editor compatible amb PlantUML. Després només cal exportar-los a PNG amb els noms `diagrama_classes.png` i `diagrama_comportament.png` per complir els entregables del projecte.
