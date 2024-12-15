#ifndef BLOCKOBSERVER_H
#define BLOCKOBSERVER_H

#include "block.h"

namespace godot {

class BLOCKOBSERVER : public BLOCK {
	GDCLASS(BLOCKOBSERVER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOBSERVER();
	~BLOCKOBSERVER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif