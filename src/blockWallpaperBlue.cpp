#include "blockWallpaperBlue.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWALLPAPERBLUE::_bind_methods() {
}

BLOCKWALLPAPERBLUE::BLOCKWALLPAPERBLUE() {

    setTexture("res://items/walls/wallpaper/blueWallpaper.png");

    itemToDrop = 143;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    backgroundColorImmune = true;

}


BLOCKWALLPAPERBLUE::~BLOCKWALLPAPERBLUE() {
}

