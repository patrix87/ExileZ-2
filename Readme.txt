ExileZ 2.0

by Patrix87 of http:\\multi-jeux.quebec

Forked from Original project named EXILE-Z created by SAM, Otto and CaptionJack of RelentlessServers.com based on Civilian Life by code34

Concept :

ExileZ 2.0 is an add-on created for ExileServer and RyanZombies

It creates multiple triggers on the map and spawn zombies when those triggers are activated.

Details :
If a player comes in the activations zone of the triggers this one will start spawning zombies, to a maximum determined in the configs.

If the player goes out of the zones the zombie will stop spawning and will eventually delete them.

If a player kill all the zombies they will keep spawning at a slow rate.

It is possible to configure the script to spawn the zombies on an headless client.

The maximum number of zombies can be set dynamically based on a ration of the number of available spawn positions.

Installation :

1. Unpack exilez.pbo
2. Edit settings in init\fn_init.sqf 
3. Repack exilez.pbo  
4. Place exilez.pbo in @ExileServer\addons 
5. Start server!