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
    double *lightData;
    int *timeData;

    int *positionLookup;

    int globalTick;

	
protected:
	static void _bind_methods();

public:

    //Data
    int planetSize;

	PLANETDATA();
	~PLANETDATA();

    void createEmptyArrays(int size);
    
    int getTileData(int x,int y);
    int getBGData(int x,int y);
    double getLightData(int x,int y);
    int getTimeData(int x,int y);

    int getPositionLookup(int x, int y);

    bool setTileData(int x,int y, int newValue);
    bool setBGData(int x,int y, int newValue);
    bool setLightData(int x,int y,double newValue);
    bool setTimeData(int x,int y,int newValue);

    bool setPositionLookup(int x, int y, int newValue);

    void setGlobalTick(int tick);
    int getGlobalTick();

};

}

#endif