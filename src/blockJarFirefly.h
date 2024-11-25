#ifndef BLOCKJARFIREFLY_H
#define BLOCKJARFIREFLY_H

#include "block.h"

namespace godot {

class BLOCKJARFIREFLY : public BLOCK {
	GDCLASS(BLOCKJARFIREFLY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKJARFIREFLY();
	~BLOCKJARFIREFLY();

};

}

#endif