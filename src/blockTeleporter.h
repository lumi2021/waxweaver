#ifndef BLOCKTELEPORTER_H
#define BLOCKTELEPORTER_H

#include "block.h"

namespace godot {

class BLOCKTELEPORTER : public BLOCK {
	GDCLASS(BLOCKTELEPORTER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTELEPORTER();
	~BLOCKTELEPORTER();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif