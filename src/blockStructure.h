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
};

}

#endif