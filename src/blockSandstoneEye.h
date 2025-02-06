#ifndef BLOCKSANDSTONEEYE_H
#define BLOCKSANDSTONEEYE_H

#include "block.h"

namespace godot {

class BLOCKSANDSTONEEYE : public BLOCK {
	GDCLASS(BLOCKSANDSTONEEYE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSANDSTONEEYE();
	~BLOCKSANDSTONEEYE();

};

}

#endif