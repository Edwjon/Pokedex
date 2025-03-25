# 🧬 Pokédex 151

Una mini aplicación desarrollada como parte de un desafío técnico cuyo objetivo es demostrar buenas prácticas, arquitectura limpia (MVVM), uso de red asincrónica, persistencia y testing.

## 🚀 Objetivo del Proyecto

Construir una Pokédex que:

- 🔍 Muestra los primeros **151 Pokémon**.
- 📄 Permite ver el detalle de cada Pokémon (tipo, movimientos y evolución).
- 🔎 Incluye barra de búsqueda por nombre.
- ⚡️ Carga de forma **asincrónica** todos los datos desde la [PokeAPI](https://pokeapi.co/).
- 💾 Almacena los datos localmente para permitir búsquedas offline.
- 🧪 Incluye **tests unitarios** para toda la capa de red, servicios y viewmodels.

## 🧱 Estructura

- `Application/`: Controladores de vista, celdas y lógica visual.
- `Models/`: Modelos de datos decodificables (`Pokemon`, `Species`, `Evolution`, etc.).
- `Networking/`: `APIClient`, `Endpoints`, servicios (`PokemonService`, `EvolutionService`).
- `ViewModels/`: Lógica de presentación desacoplada de la UI.
- `Tests/`: Tests unitarios con cobertura alta (idealmente cercana al 100%).

## 🧪 Ejecución de Tests

Puedes ejecutar los tests con:

```bash
Cmd + U
