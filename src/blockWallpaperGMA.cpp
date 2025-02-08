#include "blockWallpaperGMA.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWALLPAPERGMA::_bind_methods() {
}

BLOCKWALLPAPERGMA::BLOCKWALLPAPERGMA() {

    setTexture("res://items/walls/wallpaper/grandmaWallpaper.png");

    itemToDrop = 146;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    backgroundColorImmune = true;

}


BLOCKWALLPAPERGMA::~BLOCKWALLPAPERGMA() {
}

