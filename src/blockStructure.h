#ifndef BLOCKSTRUCTURE_H
#define BLOCKSTRUCTURE_H

#include "block.h"

namespace godot {

class BLOCKSTRUCTURE : public BLOCK {
	GDCLASS(BLOCKSTRUCTURE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSTRUCTURE();
	~BLOCKSTRUCTURE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

	// structures
	Dictionary generateHouse(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateCavernHouse(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateBossShipPlatform(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary genetatePond(int worldx, int worldy, PLANETDATA *planet, int dir);

	// igloo parts
	Dictionary generateIglooBase(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateIglooDoor(int worldx, int worldy, PLANETDATA *planet, int dir);

	// underground random
	Dictionary selectRandomUGStructure(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateUGDecorHouse(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateUGDecorWell(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateUGDecorWindchime(int worldx, int worldy, PLANETDATA *planet, int dir);
	
	// pillar
	Dictionary generatePillarTop(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generatePillarMid(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generatePillarBottom(int worldx, int worldy, PLANETDATA *planet, int dir);

	Dictionary generateMarbleThing(int worldx, int worldy, PLANETDATA *planet, int dir);
	Dictionary generateDesertTemple(int worldx, int worldy, PLANETDATA *planet, int dir);
};

}

#endif