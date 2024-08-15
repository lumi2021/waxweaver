#ifndef BLOCKGRILL_H
#define BLOCKGRILL_H

#include "block.h"

namespace godot {

class BLOCKGRILL : public BLOCK {
	GDCLASS(BLOCKGRILL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRILL();
	~BLOCKGRILL();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif