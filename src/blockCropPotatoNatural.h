#ifndef BLOCKCROPPOTATONATURAL_H
#define BLOCKCROPPOTATONATURAL_H

#include "block.h"

namespace godot {

class BLOCKCROPPOTATONATURAL : public BLOCK {
	GDCLASS(BLOCKCROPPOTATONATURAL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCROPPOTATONATURAL();
	~BLOCKCROPPOTATONATURAL();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif