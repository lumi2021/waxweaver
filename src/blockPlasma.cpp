#include "blockPlasma.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPLASMA::_bind_methods() {
}

BLOCKPLASMA::BLOCKPLASMA() {

    setTexture("res://items/blocks/natural/plasma.png");

    connectedTexture = true;
    breakTime = 999999.0;

    breakParticleID = 0;
    lightEmmission = 1.0;

}


BLOCKPLASMA::~BLOCKPLASMA() {
}

