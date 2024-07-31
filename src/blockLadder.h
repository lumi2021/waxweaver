#ifndef BLOCKLADDER_H
#define BLOCKLADDER_H

#include "block.h"

namespace godot {

class BLOCKLADDER : public BLOCK {
	GDCLASS(BLOCKLADDER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLADDER();
	~BLOCKLADDER();

};

}

#endif