#ifndef BLOCKMOSS_H
#define BLOCKMOSS_H

#include "block.h"

namespace godot {

class BLOCKMOSS : public BLOCK {
	GDCLASS(BLOCKMOSS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMOSS();
	~BLOCKMOSS();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif