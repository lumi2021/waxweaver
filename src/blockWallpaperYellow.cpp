#include "blockWallpaperYellow.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWALLPAPERYELLOW::_bind_methods() {
}

BLOCKWALLPAPERYELLOW::BLOCKWALLPAPERYELLOW() {

    setTexture("res://items/walls/wallpaper/yellowWallpaper.png");

    itemToDrop = 145;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    backgroundColorImmune = true;

}


BLOCKWALLPAPERYELLOW::~BLOCKWALLPAPERYELLOW() {
}

