#ifndef PLANETDATA_H
#define PLANETDATA_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/classes/packed_scene.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/dictionary.hpp>
#include <godot_cpp/variant/string.hpp>
#include <godot_cpp/variant/packed_string_array.hpp>

#include <godot_cpp/variant/utility_functions.hpp>


namespace godot {

class LOOKUPBLOCK;
class PLANETDATA : public Node {
	GDCLASS(PLANETDATA, Node)

private:
    int *tileData;      // block tile data
    int *bgData;        // background tile data
    double *lightData;  // light value data
    int *timeData;      // global tick data
    double *waterData;  // water liquid data
    int *infoData;      // misc int info data

    int *positionLookup;

    int globalTick;

	
protected:
	static void _bind_methods();

public:

    //Data
    int planetSize;

	PLANETDATA();
	~PLANETDATA();

    void createEmptyArrays(int size, Vector2 centerPoint);
    
    int getTileData(int x,int y);
    int getBGData(int x,int y);
    double getLightData(int x,int y);
    double getWaterData(int x,int y);
    int getTimeData(int x,int y);
    int getInfoData(int x,int y);

    int getPositionLookup(int x, int y);

    bool setTileData(int x,int y, int newValue);
    bool setBGData(int x,int y, int newValue);
    bool setLightData(int x,int y,double newValue);
    bool setWaterData(int x,int y,double newValue);
    bool setTimeData(int x,int y,int newValue);
    bool setInfoData(int x,int y,int newValue);

    bool setPositionLookup(int x, int y, int newValue);

    void setGlobalTick(int tick);
    int getGlobalTick();

    Array createAllChunks(PackedScene *chunkScene, Node *chunkContainer, int sizeInChunks);

    Vector2i findSpawnPosition(LOOKUPBLOCK *lookup);
    int getBlockPosition(int x,int y,Vector2 centerPoint);

    void savePlanet();
    Vector2i findFloor(int x, int y, LOOKUPBLOCK *lookup);
    PackedStringArray getSaveString();
    void loadFromString(String tileString,String bgString,String infoString,String timeString,String waterString);

    int getTileRow(int i);
    int getBGRow(int i);
    int getInfoRow(int i);
    int getTimeRow(int i);
    float getWaterRow(int i);

    void copyLightFromShip(PLANETDATA *planet,int planetX, int planetY, int dir, LOOKUPBLOCK *lookup);
    int getBiome(int x,int y);

    float biomeDistanceDetect(Vector2 source, Vector2 pos);

    Dictionary energize(int x, int y,PLANETDATA *planet, LOOKUPBLOCK *lookup);

    Dictionary pregenerateStrucutres(LOOKUPBLOCK *lookup);

};

}

#endif