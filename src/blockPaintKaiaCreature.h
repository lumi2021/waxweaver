#ifndef BLOCKPAINTKAIACREATURE_H
#define BLOCKPAINTKAIACREATURE_H

#include "block.h"

namespace godot {

class BLOCKPAINTKAIACREATURE : public BLOCK {
	GDCLASS(BLOCKPAINTKAIACREATURE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTKAIACREATURE();
	~BLOCKPAINTKAIACREATURE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif