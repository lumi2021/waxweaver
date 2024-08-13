#ifndef BLOCKCROPPOTATO_H
#define BLOCKCROPPOTATO_H

#include "block.h"

namespace godot {

class BLOCKCROPPOTATO : public BLOCK {
	GDCLASS(BLOCKCROPPOTATO, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCROPPOTATO();
	~BLOCKCROPPOTATO();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif