# Game Scenes

## VRTraining (`src/scenes/VRTraining/`)

Test/training level with terrain and collision. Has a `VRTrainingBlenderImport.gd` for material assignment and trimesh collision.

## Hangar (`src/scenes/Hangar/`)

Ship selection and weapon outfitting UI:
- Ship selector (dropdown)
- Primary weapon selector (nosegun)
- Secondary weapon selector (pylons)
- Camera interpolation between overview and weapon detail views
- Rotating pedestal for the ship model
- Emits loadout data to `ShipManager` for spawning

## City (`src/scenes/City/`)

Large city map (10x scaled). Features buildings, domain blocks, and a river. Has `CityBlenderImport.gd` for material/trimesh processing.

## Props (shared across scenes)

| Prop | Description |
|------|-------------|
| SpawnPoint | `Marker3D` spawn position |
| AmmoSource | `Area3D` trigger that resupplies ammo |
| Target | Destructible target (3 or 4 rings), respawns after delay |
| Biolab | Structure prop (Deck + Dome + LandingPads, trimesh collision) |
| Tower | Tower structure prop |

See also: [../system/scenes.md](../system/scenes.md) | [../components/summary.md](../components/summary.md)
