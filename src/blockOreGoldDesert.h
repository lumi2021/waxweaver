#ifndef BLOCKOREGOLDDESERT_H
#define BLOCKOREGOLDDESERT_H

#include "block.h"

namespace godot {

class BLOCKOREGOLDDESERT : public BLOCK {
	GDCLASS(BLOCKOREGOLDDESERT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOREGOLDDESERT();
	~BLOCKOREGOLDDESERT();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif