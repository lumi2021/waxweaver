#ifndef BLOCKBROWNBRICK_H
#define BLOCKBROWNBRICK_H

#include "block.h"

namespace godot {

class BLOCKBROWNBRICK : public BLOCK {
	GDCLASS(BLOCKBROWNBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBROWNBRICK();
	~BLOCKBROWNBRICK();

};

}

#endif