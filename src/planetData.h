#ifndef PLANETDATA_H
#define PLANETDATA_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/dictionary.hpp>




namespace godot {

class PLANETDATA : public Node {
	GDCLASS(PLANETDATA, Node)

private:
    int *tileData;
    int *bgData;
    int *lightData;
    int *timeData;
	
protected:
	static void _bind_methods();

public:

    //Data
    

	PLANETDATA();
	~PLANETDATA();

    void createEmptyArrays(int size);
    
};

}

#endif