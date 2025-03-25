# Daniel-LastLocation

## Overview
This resource handles player spawning in FiveM, allowing players to either:
- Spawn at their last known location.
- Spawn at a predefined location.

---

## Features
- Spawn at last known location.
- Configurable location for new or first-time players.

---

## Configuration
### Settings
```lua
Config = {
    FirstSpawnCoords = vector4(-256.63, -970.49, 31.22, 210.81),
    SpawnAlwaysInLastLocation = true, -- If False set coords for auto spawn
    AutoSpawnCoords = vector4(0,0,0,0) -- Coords if last location is false

    -- Same as in refreshchar, if you want to customize the function make sure to change its call aswell in Client-Lua/client.lua:16
    ClothingLoad = function() 
        TriggerServerEvent('qb-clothing:client:get_character_current')
        TriggerServerEvent("raid_clothes:get_character_face")
    end
}
```

---

## Installation
1. Place the resource folder in your `resources` directory.
2. Add the following line to your `server.cfg`:
   ```cfg
   ensure Daniel-LastLocation
   ```

---

## Database Setup
Create a table to store player last locations:
```sql
CREATE TABLE player_locations (
    citizenid VARCHAR(50) PRIMARY KEY,
    last_location VARCHAR(255)
);
```

---

## Usage
- If `SpawnAlwaysInLastLocation` is `true`, players will spawn at their last known location.
- If `SpawnAlwaysInLastLocation` is `false`, players will spawn at the configured location specified in `AutoSpawnCoords`.

### Example Workflow
1. When a player disconnects, their last location is automatically saved in the database.
2. When a player reconnects:
   - If `SpawnAlwaysInLastLocation` is `true`, their saved location will be loaded.
   - If `SpawnAlwaysInLastLocation` is `false`, they will spawn at the fallback location.
