# Game Design — Core Vision

## Identity

SkyknightsOnline is an **indie competitive flight sim** — the child of two parents:

- **Planetside 2**: VTOL hover-duel flight model, military aircraft feel, team-based air combat
- **Descent**: 6DOF combat inside geometric terrain where the space IS the game

The result: **hover duels inside terrain.** Open sky for clean skill expression, caves and canyons for spatial awareness and movement mastery. **Everyone is a pilot.** No ground players to balance around — the game is unapologetically designed for pilot enjoyment. The hover duel is the core combat ideal, deepened with EVE/MWO-style fitting decision trees, capacitor resource management, and EWAR information warfare.

## Flight Model: Hover Duels

Aircraft are **VTOL jet-helicopters** (Planetside 2 style). The intended control scheme is **mouse flight**. The "Skyknights" ideal form of combat is the **hover duel**: kill forward momentum, transition to hover, face opponent directly. It's a test of **aim and movement control**, not traditional energy dogfighting. Aircraft have very strong **vertical thrust**.

## Game Modes

Matchmaking with playlists, **not** persistent world:

| Mode | Teams | Description |
|------|-------|-------------|
| Deathmatch | 1v1, 2v2 | Pure hover duel skill |
| Team Fight | 3v3 | Coordination, every individual carries weight |
| CTF | 3v3+ | Flag capture — flag object slows carrier? Makes visible on radar? |
| Territory Control | 3v3+ | Capture and hold points, score over time |
| Free-for-All | 2v2v2v2 | Four-way chaos, shifting dynamics, third-partying |
| MOBA | 6v6 (flagship) | NPC ground units push toward objectives; pilots support and redirect them |

MOBA requires 6v6 minimum — lower counts don't have enough pilots for the strategic layer to work.

### MOBA Mode (Flagship Mode)

**Core identity constraint**: This is Skyknights Online, not Play-Risk-While-Trying-Not-To-Crash-Into-A-Tree Online. Ground units exist to make the air war more interesting — they create context and meaning for flight and combat, but they should never demand attention that competes with flying and fighting. The design filter for any ground mechanic: **does this make the air war more interesting, or does it give the pilot homework?**

**Ground units are an autonomous tide the pilot can influence but doesn't micromanage.** They auto-spawn, auto-push toward the nearest objective, auto-fight enemy ground units they encounter. The pilot's moment-to-moment gameplay is always flight and combat.

**Pilot influence on ground war (not command):**
- **Waypoint nudges**: freelook at terrain, open radial menu, place waypoint → ground units redirect toward that point. 2 seconds, back to flying. A suggestion from the air, not an RTS command interface.
- **Fire support**: shoot enemy ground units from the air — direct combat impact
- **AAA suppression**: destroy anti-air that's making it dangerous for your team to operate in an area
- **Logistics insertion**: cargo hook brings a heavy unit to the front that wouldn't have spawned there naturally

**Ground unit types (conceptual):**
- **Push units** (tanks, mechs, hover vehicles): capture and hold ground. The actual territory-taking force. Minimal animation needed — treaded/hovering = rotate and translate.
- **AA + radar units**: make it dangerous to hover in their area. Getting flagged by one broadcasts your position to the whole enemy team. Punishes pilots who camp low altitude over pushes.
- **Base structures / static defenses**: objectives and fortifications

**Pilots can directly attack ground units** — but it should be an inefficient use of resources. A2G weapons are the right tool; hovering low to strafe with noseguns burns ammo and puts you in AAA range. Spending time in one place gets you spotted by ground units and flagged for the enemy team.

**Map structure** — traditional MOBA lanes may not work. Options:
- **Planetside-style**: multiple bases/control points on an organic map. Ground units push toward objectives; pilots decide which ones to support.
- **Payload (TF2-style)**: one team pushes NPC column, other defends. Asymmetric rounds. Simple to understand.
- **Symmetrical variants**: both teams have a payload, or both push toward a central objective.
- **Lanes emerge from waypoints, not map geometry**: if pilots direct ground units via waypoints, "lanes" are wherever teams decide to push. Map can be more organic.

**Win condition** — open. Options: destroy core, territory percentage on timer, ticket system (NPC deaths cost tickets), point control (bases generate score). May vary by map/variant.

**Spawn economy** — open. Do ground units auto-spawn on timer? Do pilots spend resources to spawn them? Does cargo hook move them from nexus to front? Probably auto-spawn baseline + logistics can deliver extras.

**No mandatory roles.** The PS2 lesson: base building created mandatory unfun jobs ("drive a truck mining rocks for 40 minutes"). The support platform should be **force multiplier, not prerequisite.** A team without support can still fight and win — they just lack strategic advantages. Their minimap is spottier, their pushes are auto-only, they can't deploy guns or buoys. But they can still spot manually, still shoot ground units, still win dogfights. A team *with* support has more options. Like having a medic in TF2 — great to have, not required to function.

**Deployables are NOT restricted to support hulls.** The fitting system handles this — if a buoy fits in a pylon slot and a deployable gun fits in a mod bay, any hull can carry them. A fighter with a buoy on one pylon is a valid build. The support platform is the *best* at deployables (more bays, more pylons, shaped for utility) but not the *only* one. Restricting deployables to one hull creates mandatory roles.

**Logistics ship is decision-dense, not action-dense.** You don't do a lot of things — you do a few things that matter a lot. "Where do I put this tank?" "Where does this buoy go?" Each choice is significant. Cargo runs should be high-impact, low-frequency — one tank that tips a critical fight, not 10 tanks feeding a supply line. That's mining rocks with extra steps.

**Ground interaction happens at comfortable flight altitude.** A2G weapons should have enough range to engage ground targets from hover height. The risk of engaging ground units is spending time in one place (getting spotted, locked) not physical terrain danger. Pilots shouldn't need to do low-altitude strafing runs through trees.

**Waypoint system infrastructure already partially exists in code:**
- Radial menu addon (unused)
- Freelook camera with gimbal
- Minimap with object picking
- Full map with drag-pan/zoom

**Remaining open questions for MOBA mode:**
- Final map structure (lanes vs organic vs payload)
- Win condition
- Ground unit spawn economy
- How many/what types of ground units
- NPC auto-behavior rules (how smart are they?)

## Hull Classes

The primary axis is **size class** — light hulls (fighters) and heavy hulls (platforms). Within each class, hulls differ by flight feel and role identity, not by raw stat scaling. A "heavy fighter" is still a light hull. Don't want a massive number of hulls — they start to feel less distinct. Three fighters + two platforms to start; room for maybe 5 fighters total if identities emerge naturally.

### Light Hulls (Fighters)

All fighters are duel machines. The differences between them are about *how* they duel, not *whether* they duel. Like PS2's three ESFs — all dogfighters, but the Mosquito was speed, the Reaver was hammer, the Scythe was hover. Same weight class, different fight identities.

Every fighter can hover — that's non-negotiable for a Skyknight. But each one is *differently comfortable* when stopped. The differentiator is **what happens when they stop hovering.**

#### Hover Specialist — The Pure Duelist

**Flight feel**: Strongest vertical thrust, best air brakes, most stable hover. When it stops, it's *home.* Deliberate movement — strong thrust in any direction but not the fastest top speed. Everything happens on its terms.

**Silhouette**: Broad wing, wide stance — a flying wing or delta with engine nacelles spread far apart. Wide from below, thin edge from the side. When it rolls, you see almost nothing. Reads as "built to hover" — wide base suggests stability, spread engines suggest vertical thrust authority.

**Dodge profile**: Dodge by **rolling** — present the thin edge. Natural advantage in vertical dodge; pitching up/down keeps the thin edge toward the enemy. In a canyon, rolling against vertical walls makes it very hard to hit.

**Duel rhythm**: Sits still, shoots straight. Wants a clean aim contest. Punishes passes, punishes mistakes.

#### Speed Specialist — The Flanker

**Flight feel**: Fastest acceleration, highest top speed. It can hover, but the hover is less stable — maybe it drifts, softer brakes, has to work harder to hold still. When it decides to go, it *goes.* The hover duel is a tool it uses, not its natural state. Wants to make passes and dictate range.

**Silhouette**: Sleek dart, sharply swept wings pinned close to the body. Narrow fuselage. Lowest frontal cross-section — built to punch through air. Thin from front and behind, broad from the side when banking. Reads as "built to go fast" — the sweep says speed, the minimal profile says penetration.

**Dodge profile**: Dodge by **pointing** — keep the thin nose toward the threat. Nearly invulnerable head-on. Vulnerable during turns when the broad side opens up. In a tunnel, threading it point-first is nearly invulnerable from behind.

**Duel rhythm**: Makes passes, forces range transitions, tries to catch you during your turn. Hover is a brief stop between runs, not a home. The zoom-and-boomer.

#### Agility Specialist — The Dancer

**Flight feel**: Fastest yaw and roll response by a wide margin. Doesn't need to be stable in hover because it can reorient instantly. Weakest raw hover stability — it's uncomfortable standing still. Wins by keeping its nose on you while you're trying to get angles. Always rotating, always adjusting, never sitting still.

**Silhouette**: Compact and angular — short fuselage, canards or X-wing layout, surfaces at aggressive angles. Smallest overall volume. Consistent profile from every angle — no dramatically thin edge but also no big face. Reads as "built to turn" — stubby shape says agility, angled surfaces say it's always pointing somewhere new.

**Dodge profile**: Dodge by **rotating** — always changing angle, profile is small anyway. No free dodges from profile manipulation, but consistently hard to hit because of size and constant reorientation. Raw accuracy is the only counter — there's no weak angle to exploit.

**Duel rhythm**: Never stops moving. Constantly adjusting angle, constantly reorienting. Gets close and stays there, keeping guns on target while the opponent struggles to track. The closer the fight, the more yaw speed matters.

#### Fighter Matchup Dynamics

- **Hover vs Hover**: purest duel. Both stable, both accurate. Aim contest.
- **Hover vs Speed**: speed makes passes, hover punishes each pass. Speed wants to dictate range and timing. Hover wants to catch them during the turn.
- **Hover vs Agility**: hover sits still and shoots straight. Agility dances around them. If hover can track, they win. If agility can make them miss, they win.
- **Speed vs Agility**: both moving, both less comfortable in pure hover. Speed wants passes the agility can't rotate fast enough to track. Agility wants to get close enough that yaw speed beats linear speed.

All fighters share: small RCS, low HP, minimal base armor, small mod bays, 1 main gun + 2 pylon hardpoints, low PG budget, solo (1 seat). Every fitting choice is painful — no safety net. You ARE the aim.

### Heavy Hulls (Platforms)

Platforms exist to do a *job* that isn't just dueling. They can fight, but that's not what makes them valuable. Like PS2's Liberator and Galaxy — bigger, slower, purpose-built.

| Hull | Role | Flight Character | RCS | Fitting | Notes |
|------|------|-----------------|-----|---------|-------|
| Gunship | Combat platform — projects firepower | Slow, stable, big | Large | Large mod bay + multiple side bays + turret hardpoint, 2 main guns?, 2 pylons, high PG | Two-seater: pilot flies + forward weapons, gunner operates turret. Chunky base subtractive armor. A problem that demands coordination. |
| Support | Utility platform — projects information and logistics | Slow, stable, big | Large | Mod bays shaped for utility (2x4 bays for long thin items), pylons for buoys/hooks/cargo, EWACS-capable, can land and deploy | Not toothless but not a gunship. Worth protecting, worth hunting. |

All heavies share: large RCS, high HP, substantial base armor, large mod bays, more hardpoints, high PG budget, slower and less agile. They have defensive freedom — fitting space to carry shield AND autorepair AND ewar. Vulnerable to alpha because subtractive armor doesn't stop big hits.

### Multi-Crew

Seat switching system already implemented. Gunship is two-seater — key tension in 6v6: 5 hulls vs 6. Approach: **don't be afraid to make large aircraft truly powerful.** A two-player gunship should be a *problem* that demands coordination. Value comes from **action economy** — pilot flies + forward weapons, gunner operates independent-aim turret.

### Support Depth

- Advanced radar / EWACS (reveal enemy positions at long range)
- Repair/ammo supply (extend team endurance)
- **Land and deploy**: trade mobility for firepower/utility — becomes a static asset the enemy must divert to deal with
- **Cargo hooks**: pick up NPC units from nexus, deposit on front lines (directly influences MOBA mode pushes)

### Development Path

Build light hull first (get flight feel right), then heavy hull (get flight feel right). Two flight identities to tune. Role variants come later as content. The Marauder is the starting light hull — needs to be reclassified/tuned into one of the three fighter identities.

## Item Roster

### Weapons — Noseguns (Main Gun Hardpoint)

Ballistic, ammo-based, sustained damage. Always-on cycling damage.

| Item | ROF | Per-Hit | Magazine | Armor Pen | Notes |
|------|-----|---------|----------|-----------|-------|
| Colt | High | Low | Large | None | Rapid-fire, spray specialist. Good vs unarmored, struggles vs subtractive armor. |
| Vortek | Low | High | Small | Moderate | Heavy hitter. Better vs subtractive armor (big shots bypass more flat reduction). |

Future noseguns will expand the roster — different ROF/damage/pen tradeoffs. Possible variants: high-pen low-damage, moderate everything, etc.

### Weapons — Pylons (Wing Hardpoint)

Ballistic, ammo-based, burst/conditional damage. Finite resource — gone when spent. Fitting one means NOT fitting another.

| Item | Velocity | Damage | Ammo | Armor Pen | Cap Interaction | Notes |
|------|----------|--------|------|-----------|-----------------|-------|
| Rocket pods | Moderate | Moderate | Good count | Low/None | None | Generalist. Works against air and ground. The safe pylon pick. |
| A2A missiles | Moderate + tracking | Low per hit | 4-6 | None | None | Air pressure tool. Force hover breaks, finish runners. Lock requires soft-aim (~1.5s crosshair near target). Breaks on hard maneuver / countermeasures. |
| A2G missiles | Slow | High | Limited | High | None | MOBA specialist. Anti-NPC-tank, anti-AAA, anti-static-defense. Inefficient vs aircraft. |
| Railgun | Very high | Very high | 2-3 | Very high | Charges from cap | Precision pick. Mind-game weapon — charge gives visual/audio warning to enemy. Can release early, hold full, or bluff. Small variant: short charge, moderate cap, moderate damage. Large variant: long charge, massive cap, devastating damage. |
| Radar buoy | N/A | N/A | 1-3 | N/A | None | Deployable pylon item. Drop at location, team gains radar coverage in area. Enemy can see and destroy. Not a weapon — team utility on a pylon slot. |

### Weapons — Turret (Gunship Hardpoint Only)

Operated by second crew member with independent aim.

| Item | Notes |
|------|-------|
| Heavy turret | Independent-aim weapon for gunner. High damage, wide arc. Makes the gunship a threat from angles the pilot can't cover. |

Turret variants TBD — could include different damage profiles, arcs, fire rates.

### Modules — Defense (Mod Bay)

| Item | Grid Shape | Effect | Cap Cost | PG Cost | Notes |
|------|-----------|--------|----------|---------|-------|
| Shield | 1x3 or 2x2 | Regenerable barrier on top of HP. Absorbs damage while active. | Active drain — costs cap to maintain. Stops paying, shield drops. | Moderate | Active tank. High cap commitment, vulnerable when dry. |
| Auto-repair | 1x2 | Converts cap to HP recovery. Slow. Heals damage that already got through. | Slow sustained drain | Moderate | Different from shield — undoes damage instead of preventing it. Good for long engagements. |
| Subtractive armor | 1x2 or 2x2 | Flat damage reduction per hit. Always on. | None (passive) | Low-Moderate | Counters spray weapons (Colt, rocket pods). Barely matters vs alpha. The "I don't want to manage cap for defense" option. |
| % armor | 1x2 or 2x2 | Percentage damage reduction. Always on. | None (passive) | Moderate | Equally effective proportionally. Saves more raw HP vs big hits. The safe defense pick — always does something. |

### Modules — Capacitor (Mod Bay)

| Item | Grid Shape | Effect | Cap Cost | PG Cost | Notes |
|------|-----------|--------|----------|---------|-------|
| Aux capacitor | 1x2 or 2x1 | Increases total cap capacity. Curve shape stays same but absolute recharge/sec is bigger at sweet spot. | None (passive) | Moderate | Bigger gas tank. Sustain longer before danger zone. |
| Recharge mod | 1x2 | Raises peak regen rate or shifts sweet spot. Faster recovery from deep expenditure. | None (passive) | Moderate | Better fuel pump. Good for prowler/skirmisher playstyles. |
| Cap booster | 2x2 or 1x3 | Limited ammo charges that dump flat cap amount instantly. Breaks the EVE curve. | Free (gives cap) | High | Nitrous oxide. Timing skill — pop too early = wasted, too late = dead. Flanker/zoom-and-boomer safety net. |

### Modules — EWAR / Sensors (Mod Bay)

| Item | Grid Shape | Effect | Cap Cost | PG Cost | Notes |
|------|-----------|--------|----------|---------|-------|
| Omni radar | 1x2 | 360° coverage, shorter range. Detects contacts for team minimap (RCS vs sensor_strength). | Low passive | Moderate | Situational awareness for 6v6. Essential for team play. |
| Directional radar | 1x2 | Forward cone, much longer range. Only detects what you're facing. | Low passive | Moderate | Perfect for hover duel — you're facing the enemy. Terrible for flank awareness. |
| Engagement radar | 1x1 | Very short range, 360°. Shows bearing of nearby threats only (no distance, identity, or heading). | Low passive | Low | "Something's close, look that way." Twitch on the HUD. Short-range tactical awareness. |
| Stealth (RCS reduction) | 1x3 | Reduces your RCS. Harder to detect on enemy radar. More impactful on already-small hulls. | None (passive) | Moderate | Beats automated detection, not spotting. You still show up if a human sees you. |
| Sensor strength mod | 1x2 | Increases your sensor_strength. Extends detection range against all targets. | None (passive) | Moderate | Counter to stealth. Sees low-RCS hulls from farther out. |
| EWACS module | 2x4 | Massive sensor strength. Team-wide enhanced radar picture. | Moderate sustained | High | Support hull apex fitting. Airborne command center. Kill it and team goes blind. |
| Target painter | 1x1 | Marks an enemy for your team. Highlighted on everyone's map even through jamming/stealth. | Low per use | Low | Inverse of stealth. Manual, requires line of sight. |

### Modules — Countermeasures (Mod Bay)

| Item | Grid Shape | Effect | Cap Cost | PG Cost | Notes |
|------|-----------|--------|----------|---------|-------|
| Countermeasures | 1x1 | Defeat lock-on missiles. Chaff/flares/decoys. | Low per use | Low | Specific counter to A2A missiles. Small fitting footprint but still competes for grid space. |

### Modules — Utility / Deployables (Mod Bay)

| Item | Grid Shape | Effect | Cap Cost | PG Cost | Notes |
|------|-----------|--------|----------|---------|-------|
| Deployable gun | 2x2 | Land and deploy a static weapon emplacement. Trade mobility for firepower. | Deploy cost | High | Creates a problem the enemy must divert to deal with. Any hull can carry it if it fits. |
| Repair/ammo supply | 1x3 | Extend team endurance. Repair and rearm nearby allies. | Active drain | Moderate | Support identity item. Team sustain. |

### Pylon Utility Items

These go on pylon hardpoints instead of weapons. Not in mod bays — they're exterior-mounted equipment.

| Item | Pylon Slots | Effect | Notes |
|------|-------------|--------|-------|
| Radar buoy | 1 | Deployable radar. Drop at location for team coverage. | Already listed in pylon weapons table. |
| Cargo hook | 1 | Pick up and carry NPC ground units. Fly them from nexus to front. | Support hull staple. High-impact, low-frequency deliveries — one tank that tips a fight, not 10 tanks feeding a supply line. |

### Items Not Yet Placed (Need Design)

- **Sensor disruption**: corrupt HUD elements (fuzz pitch ladder, desync minimap). Mod bay? What shape/PG?
- **Targeting interference**: increase enemy cone of fire, slow lock acquisition. Mod bay? 
- **Thruster/stability mods**: tune flight characteristics via mod bay instead of separate airframe slot. What do they modify? What's the fitting cost vs a defense mod?
- **Damage threshold mitigation**: could be a hull intrinsic or a mod. If a mod, what shape/PG/cap cost?

## Loadout & Fitting System

### Design Philosophy

- **Not EVE** — too spreadsheet, too many currencies (CPU + power grid + slot types + hardpoint types)
- **Not Planetside** — too restrictive (primary, secondary, defense, utility, airframe — no room for choices)
- **Split the difference** — hardpoints for weapons, grid for internals, power grid as secondary constraint, airframe as dedicated slot

### Three Fitting Domains

**1. Hardpoints (exterior, physical, skeuomorphic)**

Fixed mounting locations on the hull model. Weapons go here. Type-restricted per location — you can't put a pod on the nose. Already partially implemented in code (`slots.weapons.nosegun`, `slots.weapons.pylons`).

| Hardpoint Type | Example Locations | What Fits |
|----------------|-------------------|-----------|
| Main gun | Nose, chin | Noseguns (ballistic, ammo-based) |
| Weapon pod | Wing pylons | Rocket pods, missiles, railguns |
| Turret | Belly, tail (gunship only) | Heavy turret for second crew member |

**2. Mod Bays (interior, grid-based, spatial)**

Internal systems are fitted into **mod bays** — a tetris-style inventory grid inside the aircraft. This is where utility, defense, and support modules go. The grid is visual-spatial: you *see* what fits.

Key properties:
- Items have **shape and size** — both are tuning factors. Autorepair is 2x2, shield generator is 1x3, countermeasures are 1x1, aux capacitor is 2x1. Same area can have completely different fitting implications.
- Bays are **not necessarily contiguous**. One hull could have a single large 4x4 main bay. Another could have a 3x3 main bay plus two 2x1 side bays. The side bays physically limit what fits — a 1x3 ewar suite won't go in a 2x1 slot — without needing stats or tooltips.
- Shape-based constraints create **spatial reasoning**, not numerical comparison. No spreadsheets.

Hull differentiation through bay layout:
- **Interceptor**: One 3x3 bay. Lean, purposeful — pick one or two things, that's your identity. No room to generalize.
- **Heavy Fighter**: 3x4 main bay + couple 2x1 side bays. Side bays for small utilities (countermeasures, small cap boost). Main bay for the big choice: shield, autorepair, or advanced radar.
- **Gunship**: Large main bay + multiple side bays + dedicated turret hardpoint. Room for shield AND autorepair AND ewar — but you're a big slow target paying for that flexibility.
- **Logistics**: Bays shaped for utility — 2x4 bays perfect for long thin shapes (cargo hook system, advanced radar array, deployable gun package). Not much room for defense mods — you're supposed to be protected by your team.

**3. Airframe (dedicated slot, modifies Engine)**

Separate pick that modifies flight characteristics. A **playstyle declaration**, not a side effect. "I am a hover duelist" vs "I am a speed demon." Not necessarily the PS2 trio (Hover/Racer/Agility) — could be custom set. Changes Engine parameters (the existing modifier system already supports this).

Flight feel changes must be **deliberate choices**, not implicit penalties. Equipping a heavy gun shouldn't subtly worsen your hover. Choosing an airframe is *how* you duel; everything else is *what you do* during the duel.

### Power Grid (Secondary Constraint)

A single numerical budget. Every item — hardpoint weapon and mod bay module — has a PG cost. Your hull has a PG maximum. You might have grid space but not PG, or vice versa. Two constraints create the satisfying "almost fits" moment: you're 3 PG over budget, drop the small countermeasures for a weaker one, suddenly everything clicks.

Example tradeoff: two main guns uses enough PG that you can't have an aux capacitor AND an autorepair module.

### Saved Loadouts

Name them, save them, quick-swap between matches. Stored as JSON (same pattern as existing settings system).

### Capacitor/Energy System (Core Micro-Loop Resource)

Finite energy pool for **ship systems**, not weapons (no energy weapons — see Weapons section). Players decide how to spend it in real-time:
- Afterburners (improve position)
- Shield activation
- Auto-repair
- Countermeasures
- EWAR
- Railgun charge (the one weapon that interacts with cap — see Weapons)

**Fitting determines what's on your panel to power.** The hull always flies the same per airframe choice; you're choosing what to power right now. Capacitor is the tactical layer; fitting is the strategic layer.

**Single shared pool** — everything draws from the same cap. One bar, one resource to manage. This is what makes the micro-loop a decision — you can't afterburner and shield simultaneously without draining fast. Compartmentalized pools would let you avoid that tension.

**Full on spawn** — no meta-resource between lives. You start every life with a full capacitor. Cap is a per-life tactical resource, not a strategic persistence layer.

**EVE-style recharge curve** — cap/s is fastest around ~33% capacity and slows in either direction. Creates natural pacing without manual input:
- **Near 100%**: topped up, slow recharge, "wasting" potential regen — the game wants you to spend
- **Around 33-50%**: sweet spot — fast recharge, sustainable spending. This is where hover duels live
- **Below 33%**: danger zone — slow recharge, every point spent costs more because you're further from efficient regen. Disengage or be conservative

### Capacitor Mods (Mod Bay Items)

| Mod | Effect | Fitting Profile | Tradeoff |
|-----|--------|-----------------|----------|
| Aux capacitor | Increases total capacity. Curve shape stays same but absolute recharge numbers are bigger — more cap/sec at the sweet spot | Moderate grid, moderate PG | Bigger gas tank — sustain longer, but less room for defense/utility |
| Recharge mod | Raises peak regen rate or shifts the sweet spot. Recover faster from deep expenditure | Moderate grid, moderate PG | Better fuel pump — but less room for reactive tools |
| Cap booster | Limited ammo charges that dump a flat cap amount instantly. Breaks the curve — pop a charge from 15% to 50% | Large grid (2x2 or 1x3), high PG | Nitrous oxide — powerful, expensive, finite. Creates timing skill: pop too early = wasted, too late = dead |

### Emergent Playstyles

The cap system generates playstyles naturally — not classes, but different relationships with the capacitor curve. Fitting biases you toward one, but nothing locks you in. Playstyle is a choice in the moment, not a selection on a menu.

- **Prowling hunter**: Minimal cap spending, cruises at high %, always ready. Picks engagements, enters duels at 100%. Fitted for sustain (recharge mod). Patience player — lets the enemy exhaust themselves.
- **Harassing skirmisher**: Lives at the sweet spot. Constant moderate spending — afterburner flickers, short shield pulses, ewar pokes. Never commits hard enough to dip below 33%. Fitted for regen efficiency (aux cap + recharge). Annoying, always present, hard to pin down.
- **Flanker**: Spends heavy to get into position. Afterburner around terrain, arriving depleted but with surprise. Needs the fight to end fast — in danger zone on arrival. Cap booster as safety net. High risk, high reward.
- **Zoom and boomer**: Maximum burst, minimum sustain. Afterburner in hard, railgun charge during approach, fire, afterburner out. Entire engagement is one pass — 70% cap in 5 seconds. If it works, devastating. If not, floating at 15% with no options. Cap booster as crutch for escape.

## Weapons

### All Weapons Are Physics-Based Ballistic

The aesthetic is **military aircraft** — attack helicopters, warthogs, modern jets. No plasma cannons, no beam lasers, no sci-fi energy weapons. The railgun is the one exception and it's still a kinetic weapon (electromagnetically launched slug), not a laser. Every weapon has velocity, travel time, and physical projectiles. You lead your target.

### Noseguns (Ballistic, Ammo-Based, Sustained Damage)

Noseguns are your **always-on damage** — you always have them, they're always cycling. Ammo-based with magazine/reload mechanics (already implemented for Colt/Vortek).

| Type | Profile | Example |
|------|---------|---------|
| Fast/low-damage | High ROF, low per-shot, large magazine | Colt |
| Slow/high-damage | Low ROF, high per-shot, small magazine | Vortek |

Additional noseguns will expand the roster as more hulls are added.

### Pylons (Ballistic, Ammo-Based, Burst/Conditional Damage)

Pylons are your **limited resource, bigger moment** — finite ammo, bigger impact per shot, gone when spent. Fitting a pylon weapon means you're NOT fitting one of the others — this is the natural tradeoff.

| Weapon | Velocity | Damage | Ammo | Role |
|--------|----------|--------|------|------|
| Rocket pods | Moderate | Moderate | Good count | Generalist — works against air and ground |
| A2A missiles | Moderate + tracking | Low per hit | 4-6 | Air-to-air pressure tool; force breaks, finish runners |
| A2G missiles | Slow | High | Limited | MOBA specialist — anti-NPC-tank, anti-AAA, anti-static-defense |
| Railgun | Very high | Very high | 2-3 | Precision pick — charge-from-cap, long commitment, devastating on hit |

### Lock-On Missiles — The PS2 Lesson

**PS2's problem**: Lock-on effectiveness scaled with numbers while gun skill didn't. One pilot with lock-ons was harmless; a squad's worth made the airspace inescapable. Low skill requirement + high scaling = worst of both worlds for game health.

**Why it's solvable in Skyknights**: Max 6 opponents. The "25 noobs with Tomcats" scenario is literally impossible. Lock-ons can exist if:
- **Limited ammo** (4-6, NOT 20) — missiles are a rhythm tool, not primary damage
- **Lock acquisition requires aim** — soft lock: keep crosshair within X degrees of target for ~1.5 seconds. Not "hold still while circle fills"
- **Lock breaks on hard maneuver** — target breaking hover and evading resets lock. Missile creates pressure (forces them out of stable hover) but kill is conditional
- **Lock breaks on countermeasures** — and countermeasures cost mod bay space, so carrying them is a fitting tradeoff
- **Pylon opportunity cost** — bringing lock-ons means NOT bringing A2G missiles, rocket pods, or railguns. Those weapons are needed for ground targets (NPC tanks, AAA, static defenses in MOBA mode)

### Railgun — Charge Mechanic

The railgun is the only weapon that interacts with the capacitor. Instead of a long reload, it has a **charge**: you spend cap in advance before firing.

- Start charging → capacitor drains → you're committed but haven't fired yet
- Visual/audio indicator warns the enemy ("this person is about to hit you very hard")
- Creates a **mind game inside the hover duel**: both players make decisions during the charge window
  - Charger: release early for less damage + conserve cap? Hold full charge for max impact + stay vulnerable longer? Cancel entirely — bluff the charge, make enemy break hover, dump cap into afterburner to reposition?
  - Target: break hover and evade? Try to kill the charger before they fire?
- **Self-balancing through capacitor economy**: small railgun = short charge, moderate cap, moderate damage. Large railgun = long charge, massive cap drain, devastating damage. Need to create space to charge — maybe teammate pressure helps.
- Fitting implications: railgun build wants aux capacitor (mod bay) to afford the charge, and maybe a stability airframe for precise aiming while burning cap

## EWAR

### Core Design Constraint

**EWAR should never let you win a duel you couldn't have won anyway.** It determines who knows where the fight will happen — not who wins the fight. Once you're in hover duel range, you're looking at each other and the information advantage evaporates. EWAR owns the space *between* fights, not the fights themselves.

The F-22 example: a stealth fighter can appear beside an unsuspecting pilot and wave. That's funny in real life but it's misery in a game — the other player had zero counterplay. **Stealth advantages should never be so massive that an enemy is effectively invisible.** Large distances, beyond-visual-range weapons, and huge speed differentials make real-life stealth overwhelming; none of those apply in Skyknights' close-range hover duel environment.

### Radar vs RCS Model

Borrowed from EVE: **effective detection range = base_range × (your sensor_strength / target_RCS)**. A continuous interaction, not PS2's binary stealth on/off.

**Radar Cross Section (RCS)** — intrinsic to hull, modifiable by equipment:
- Interceptor: **small RCS** — only detectable at close range by basic sensors
- Gunship: **huge RCS** — shows up on everything from across the map
- Stealth mods reduce RCS, but more impactful on already-small hulls. A stealth fighter is very hard to find; a stealth platform is still pretty obvious

**Sensor Strength** — determines your radar detection range against all targets:
- Strong sensors see stealth fighters from farther out
- EWACS (support platform) has massive sensor strength — sees everything at very long range, making it the most valuable and most vulnerable information asset

**Minimum detection range** — within a certain distance (~200m? hover duel range), everyone sees everyone on the minimap regardless of RCS/sensors. Proximity overrides stealth. You can't hide in someone's face.

### Radar Types

| Type | Coverage | Range | Fitting |
|------|----------|-------|---------|
| Omni | 360° | Shorter | Mod bay — situational awareness, essential for 6v6 |
| Directional | Forward cone | Much longer | Mod bay — perfect for hover duel (you're facing them), terrible for flank awareness |
| Engagement radar | 360° | Very short, bearing only | Mod bay — "something's close, look that way" — no exact distance, identity, or heading. Just threat bearing. |

Pilots could fit both omni + directional and switch between them, or a single module with a mode toggle. Either way, it's mod bay space spent on information instead of defense.

### Deployable Radar Buoys

A **pylon item** — giving up a weapon slot for team information. Fly to position, drop the buoy, team gains radar coverage in that area.

- MOBA mode applications: drop on flank approaches to detect rotations, drop on lane approaches for early warning on NPC pushes
- Enemy can see and destroy buoys — creates a **radar war** on top of the territory war
- Sending someone to kill buoys means a pilot not on the front line
- Logistics ship could carry multiple buoys on pylons instead of weapons — pure information build

### EWACS Module

Logistics ship apex fitting. Airborne command center — massive sensor strength feeding the team's minimap. Kill it and the team's picture degrades dramatically. Protecting it or hunting it becomes a strategic objective.

### Spotting (Always Available, No Fitting Cost)

Press a key while looking at an enemy to **ping** their position to your whole team. The ping decays after a few seconds — it's a momentary snapshot ("enemy here, right now"), not a continuous track.

- **Free, always available, no fitting cost** — the baseline information tool
- **Requires attention** — a second spent spotting is a second not aiming
- **Overrides stealth** — if a human can see you and spots you, you show up. Stealth beats machines, not eyeballs. But the ping decays, so a stealthed enemy is only exposed for a few seconds before disappearing again
- **No tracking** — your team knows where they were 2 seconds ago, not heading, speed, or altitude

### Information Hierarchy

| Tier | Information Quality | Cost |
|------|---------------------|------|
| Direct visual | Best — you see them, full information | Free, requires line of sight + attention |
| Spotted | Ping — momentary position, decays in seconds | Free, requires teammate attention |
| Radar/buoy detected | Continuous tracking, range and RCS limited | Mod bay or pylon slot |
| EWACS | Team-wide enhanced radar, longest range | Entire hull choice (support platform) |

### Freelook → Spotting Pipeline

Freelook already implemented in code (FirstPersonCamera gimbal with yaw/pitch limits). Freelook lets you scan without turning your ship — and spot what you see. The tradeoff: you're freelooking, you're not aiming.

- **Attention economy**: In 6v6, do you spend a moment spotting the enemy you see? That's a second you're not shooting. Team player vs selfish with attention — neither is wrong.
- **Airframe affects information gathering**: Agility airframe turns fast to scan. Hover airframe might have wider freelook gimbal to scan without turning. Different answers to "how do I find the enemy."
- **Support scanning**: A support platform hovering in the back, freelooking constantly, pinging enemy movements — a real role. Not as good as EWACS but costs zero fitting resources, just pilot attention.
- **Mid-duel dilemma**: In a fight, engagement radar says something's approaching from behind. Break hover to turn and spot? Call it on voice? Trust your team? No clean answer — that's where good gameplay lives.

### Tactical EWAR (In-Duel Effects)

These affect the duel directly — secondary to the radar/spotting strategic layer:
- **Sensor disruption**: corrupt HUD elements — fuzz pitch ladder, desync minimap, break weapon info. You're not hiding, you're *disorienting*
- **Targeting interference**: increase enemy cone of fire, slow lock-on acquisition, delay reload indicator
- **Countermeasures**: decoys, flares, chaff — primarily to defeat lock-on missiles

### RCS and Missile Locks

Lock-on acquisition speed is also a function of **sensor_strength / target_RCS**. High RCS targets get locked fast; low RCS targets resist locks. This ties the entire EWAR system together under one continuous mechanic instead of PS2's binary "stealth makes locks slower."

### Radar Infrastructure in Code

Already half-built: MapIcon component on render layers 6/7, minimap with object picking, full map with drag-pan/zoom. The foundations for RCS-based detection visibility exist.

## Damage & Defense

### Core Principle: No Typed Damage

No PS2-style 20x15 modifier tables. All weapons deal raw HP damage. Interactions emerge from math — subtractive vs % armor, alpha vs sustained, rate of fire vs per-hit damage. The pilot never needs a wiki to understand why something works or doesn't.

### Damage Is Untyped, Properties Create Interactions

Weapons have numeric properties (damage, ROF, velocity, armor pen) that interact with defense properties naturally:

| Defense | How It Works | Countered By |
|---------|-------------|--------------|
| Subtractive armor | Flat damage reduction per hit | Armor pen, high per-hit damage (bypasses a smaller % of each shot), sustained volume (overwhelm it) |
| % armor | Percentage reduction on all damage | Sustained fire (everyone pays same %, more bullets = more total damage through) |
| Threshold mitigation | Reduces hits above X damage | Rapid small hits (don't trigger the threshold), sustained fire |
| Shield | Active cap-drain barrier, absorbs damage instead of HP | Alpha damage (chunk it), cap pressure (make them pay to maintain it), sustained fire (drain cap faster than they drain ammo) |
| Auto-repair | Cap-to-HP conversion, slow recovery | Burst/alpha (outdamage the repair), cap pressure (spending cap to heal instead of shield/afterburn) |
| Evasion/positioning | Not getting hit | — |

Every defense has multiple counters. Every weapon has a situation where it's the right tool. No hard counters, just gradients.

### Subtractive vs % Armor

Two fundamentally different defenses that create organic weapon interactions:

**Subtractive armor** (flat reduction per hit): Better against high-ROF weapons. A 50-damage Colt hit minus 10 subtractive = 40 damage dealt. A 200-damage Vortek hit minus 10 subtractive = 190 damage dealt. The Colt loses 20% of its damage; the Vortek loses 5%. Subtractive *hard-counters spray, barely matters against alpha.*

**% armor** (percentage reduction): Scales with incoming damage. 20% reduction saves 10 HP on a 50-damage hit, 40 HP on a 200-damage hit, 100 HP on a 500-damage railgun shot. Equally effective proportionally, but raw value saved is bigger against big hits. % armor *is always useful, but especially against alpha.*

No type table needed. Two sentences of understanding: "sub stops spray, % stops big hits."

### Armor Penetration

A flat amount that bypasses subtractive armor. Not a type system — just a property some weapons have.

- Can scale naturally with per-hit damage (big guns punch through more plating because they're big)
- Or be explicit as a weapon differentiator — two noseguns with similar DPS, one has lower damage/high ROF, one has higher damage/low ROF + armor pen. Same DPS vs unarmored, but the high-damage one performs better vs subtractive armor
- Armor pen only interacts with subtractive armor — doesn't affect % armor or threshold mitigation
- Examples: railgun with massive armor pen (designed to punch through heavy hull plating), A2G missiles with high pen (anti-tank), rocket pods with low/no pen (general purpose, soft targets)

### Shield Mechanics

Active defense that costs capacitor. A regenerable barrier sitting on top of HP — takes damage instead of HP while you're paying cap to maintain it. Stop paying cap, shield drops, HP exposed.

- **Shield + cap booster**: active tank. High cap commitment, vulnerable when dry
- Shield naturally struggles against alpha — a full railgun charge can punch straight through
- Cap pressure is a counter: make the shield user spend cap maintaining it while also spending cap on afterburner/ewar. Drain them out.

### Auto-Repair

Converts cap to HP recovery. Slow. You're healing damage that already got through, not preventing it. The "I can survive long engagements" option. Different from shield — shield prevents damage, auto-repair undoes it.

### Armor (Passive, No Cap Cost)

- **Subtractive armor module**: permanent flat reduction. No cap cost. The "I don't want to manage cap for defense" option
- **% armor module**: permanent percentage reduction. No cap cost. Always-on protection
- Both compete with shield, auto-repair, and utility mods for mod bay space

### Damage Threshold Mitigation

Reduces any hit above X damage by some amount. Specifically counters alpha/burst — rapid small hits don't trigger it. A hull intrinsic that makes a craft tough against big shots but not against spray. Creates interesting asymmetric matchups (e.g., a light hull with threshold mitigation that's naturally resilient to gunship turret fire but vulnerable to rapid-fire spray).

### Hull Base Defensive Profiles

Every hull has base HP, shield, subtractive armor, % armor, and RCS *before fitting*. The hull expresses defensive identity before any mod bay choices:

- **Light hulls (fighters)**: low HP, minimal base armor. Needs to fit defense or it's paper
- **Heavy hulls (platforms)**: high HP, chunky base subtractive armor. Already naturally resistant to spray. Mod bays free for offense/utility
- Individual hulls can be tuned for specific resistance (e.g., a light hull with high base % armor for heavy-hunting, or threshold mitigation for anti-alpha identity)

Fitting biases the hull further toward one extreme, or patches the weakness. A fighter fitting subtractive armor is patching its spray vulnerability. A gunship fitting % armor is patching its alpha vulnerability. The fitting question changes per hull — "how do I survive at all?" vs "what do I do with this defensive freedom?"

### Self-Correcting Meta

No designer intervention needed. If subtractive armor is dominant, big hits / armor pen weapons become attractive. If % armor is dominant, sustained fire becomes efficient. If alpha is dominant, threshold mitigation and % armor become valuable. The meta corrects itself through math.

### Current Code Implementation

`Health.gd`: flat HP pool with `current`/`maximum`, `do_damage()` subtracts, zero = dead. Marauder has 3000 HP. Bullets deal raw damage with falloff over range. No shield, no armor, no defense layers yet.

## Art Direction: Abstract/Digital Arena

### The Problem

Three years blocked on visual art. Taste exceeds grasp — greybox placeholders are hated, concept art commission hasn't happened. The block is real and has killed momentum on new hulls and maps.

### The Solution: Own the Geometry

An abstract TRON/digital arena aesthetic where geometric ships are *the point*, not a compromise. Glowing edges, wireframe hulls, neon flight paths, clean dark backgrounds. The hover duel becomes a ritual in a digital colosseum.

This isn't just an art shortcut — it's a coherent vision the mechanics already support:

- **Matchmaking, not persistent world** — entering an arena, not a battlefield
- **Hover duels as ideal combat** — a 1v1 honor duel, not a furball. Knights in a digital sky
- **Capacitor as fighting game resource** — a fighting game meter, not a fuel gauge
- **EWAR as information warfare** — hacking the arena's sensors, not jamming military radar
- **HUD fits naturally** — pitch ladders and heading indicators look like they belong in a digital interface, not a cockpit

### Practical Implications

- **Ships are geometric solids** — a sleek tetrahedron fighter, a blocky gunship platform, a wedge support hull. Edges glow in team color. 50-100 polygons instead of thousands.
- **Terrain is abstract** — floating platforms, light bridges, neon grid floors. Not trees and rivers. Could build ten arena layouts in an afternoon.
- **HUD belongs** — the existing HUD elements already read as digital interface, not military cockpit
- **NPC ground units are simple shapes** — a glowing cube on the floor is unambiguously a ground unit. Doesn't need to look like a tank.
- **Effects are easier and better** — trails, glows, particles look *more* at home in this style than realistic smoke and fire
- **Performance is better** — fewer polygons, simpler materials, more room for physics and networking

### The Question

Does it still *feel* like the flight game you want to play? The hover duel physics are the same regardless of visual style, but the vibe is different. Landing a railgun charge in a neon geometric duel hits differently than in a military sim. Might be worse. Might be way better. Needs to be felt, not theorized.

## Level Design: Terrain Is the Game

### Descent Lineage

Descent's identity was flight combat where the terrain IS the game — not open sky dogfighting, *indoor* dogfighting. Every wall is a decision, every corridor is a threat. The best pilots knew the map and could move through it without dying.

Skyknights is the child of Descent and Planetside 2. Not full 6DOF — you have strong vertical thrust and hover, not true six-axis freedom. But that constraint is *good* for the game's identity. Full 6DOF is disorienting for most players. Skyknights keeps you in a familiar orientation (up is up) while still giving vertical play and tight-space navigation.

The hover mechanic creates something Descent didn't have — the *choice* to stop moving. You can kill your momentum, plant yourself in a doorway, and dare someone to come through. A fundamentally different kind of territorial fight inside terrain.

### Level Vocabulary

- **Open arenas**: clean hover duels, no terrain, pure skill. The competitive standard.
- **Canyons**: narrow vertical gaps, favor pilots who can hold a hover in tight spaces. Canyon walls are your shield.
- **Caverns**: wide spaces underground. Ceiling hover duels. No sky to run to — you're trapped, fight.
- **Pillars and arches**: break line of sight, create cover, force angle play. Like a 3D FPS map but you're flying through it.
- **Tunnels**: threading the needle. Light hull fits, heavy hull barely fits. Chase mechanics become lethal for the chaser — "threading a needle while the guy chasing you smashes into a rock."
- **Floating platforms**: verticality. Land and deploy a gun on a platform nobody can reach without hovering up.

### Maps and Modes

Different maps support different modes naturally:
- Open arena → deathmatch
- Canyon network → CTF
- Three-lane cave system → MOBA with NPC ground units pushing through tunnels
- The geometry *is* the game mode

The abstract art style makes these spaces trivial to build. A realistic underground cavern is a modeling nightmare. A geometric cave with angular crystal formations and grid floors is a handful of boxes and emissive materials.

### Verticality Is Key

Hover duels in open sky are the clean skill test. Hover duels *inside terrain* are where the flight model becomes expressive — using walls, hugging ceilings with vertical thrust, dropping through gaps to shake pursuers. The terrain turns the flight model from a physics system into a *language*.

## Why This Works

The Planetside 2 problem: air combat fun for pilots was often *not* fun for tank/infantry players, and vice versa. Skyknights removes that constraint entirely — **only pilots exist**, so balance can serve pilot enjoyment without compromise.

---

*This document captures the design intent. Open questions are marked — we will return to them. See also: [../ships/summary.md](../ships/summary.md) | [../network/summary.md](../network/summary.md)*
