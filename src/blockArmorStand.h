#ifndef BLOCKARMORSTAND_H
#define BLOCKARMORSTAND_H

#include "block.h"

namespace godot {

class BLOCKARMORSTAND : public BLOCK {
	GDCLASS(BLOCKARMORSTAND, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKARMORSTAND();
	~BLOCKARMORSTAND();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onLoad(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif