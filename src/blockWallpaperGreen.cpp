#include "blockWallpaperGreen.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWALLPAPERGREEN::_bind_methods() {
}

BLOCKWALLPAPERGREEN::BLOCKWALLPAPERGREEN() {

    setTexture("res://items/walls/wallpaper/greenWallpaper.png");

    itemToDrop = 144;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    backgroundColorImmune = true;

}


BLOCKWALLPAPERGREEN::~BLOCKWALLPAPERGREEN() {
}

