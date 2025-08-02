#include "lookupBlock.h"

#include "block.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void LOOKUPBLOCK::_bind_methods() {
    ClassDB::bind_method(D_METHOD("getBlockData","id"), &LOOKUPBLOCK::getBlockData);

    ClassDB::bind_method(D_METHOD("isMultitile","id"), &LOOKUPBLOCK::isMultitile);
    ClassDB::bind_method(D_METHOD("isAnimated","id"), &LOOKUPBLOCK::isMultitile);
    ClassDB::bind_method(D_METHOD("hasCollision","id"), &LOOKUPBLOCK::hasCollision);
    ClassDB::bind_method(D_METHOD("isGravityRotate","id"), &LOOKUPBLOCK::isGravityRotate);
    ClassDB::bind_method(D_METHOD("getTextureImage","id"), &LOOKUPBLOCK::getTextureImage);
    ClassDB::bind_method(D_METHOD("getMiningLevel","id"), &LOOKUPBLOCK::getMiningLevel);

    ClassDB::bind_method(D_METHOD("runOnLoad","x","y","planet","dir","blockID"), &LOOKUPBLOCK::runOnLoad);
}

// ADD BLOCKS TO ARRAY IN HERE
LOOKUPBLOCK::LOOKUPBLOCK() {
    
    penis[0] = memnew(BLOCKAIR);
    penis[1] = memnew(BLOCKCAVEAIR);
    penis[2] = memnew(BLOCKSTONE);
    penis[3] = memnew(BLOCKDIRT);
    penis[4] = memnew(BLOCKGRASS);
    penis[5] = memnew(BLOCKCORE);
    penis[6] = memnew(BLOCKPLASMA);
    penis[7] = memnew(BLOCKSAPLING);
    penis[8] = memnew(BLOCKTREELOG);
    penis[9] = memnew(BLOCKLEAVES);
    penis[10] = memnew(BLOCKTREEBRANCHLEFT);
    penis[11] = memnew(BLOCKTREEBRANCHRIGHT);
    penis[12] = memnew(BLOCKTREEBRANCHLEAF);
    penis[13] = memnew(BLOCKWOOD);
    penis[14] = memnew(BLOCKSAND);
    penis[15] = memnew(BLOCKTORCH);
    penis[16] = memnew(BLOCKFURNACE);
    penis[17] = memnew(BLOCKTALLGRASS);
    penis[18] = memnew(BLOCKORECOPPER);
    penis[19] = memnew(BLOCKCHAIR);
    penis[20] = memnew(BLOCKWORKBENCH);
    penis[21] = memnew(BLOCKGLASS);
    penis[22] = memnew(BLOCKDOORCLOSED);
    penis[23] = memnew(BLOCKDOOROPEN);
    penis[24] = memnew(BLOCKOREGOLD);
    penis[25] = memnew(BLOCKLADDER);
    penis[26] = memnew(BLOCKFLOWER);
    penis[27] = memnew(BLOCKOREIRON);
    penis[28] = memnew(BLOCKGRAVEL);
    penis[29] = memnew(BLOCKBARCOPPER);
    penis[30] = memnew(BLOCKBARGOLD);
    penis[31] = memnew(BLOCKBARIRON);
    penis[32] = memnew(BLOCKSTONEBRICK);
    penis[33] = memnew(BLOCKCHEST);
    penis[34] = memnew(BLOCKCHESTLOOT);
    penis[35] = memnew(BLOCKSOIL);
    penis[36] = memnew(BLOCKSOILDRY);
    penis[37] = memnew(BLOCKCROPPOTATO);
    penis[38] = memnew(BLOCKCROPPOTATONATURAL);
    
    penis[39] = memnew(BLOCKPAINTSTAGPLUMP); // paintings batch 1
    penis[40] = memnew(BLOCKPAINTSTAGMARSH);
    penis[41] = memnew(BLOCKPAINTSTAGCUP);
    penis[42] = memnew(BLOCKPAINTSTAGDAWN);
    penis[43] = memnew(BLOCKPAINTGAHAXA);
    penis[44] = memnew(BLOCKPAINTGAHFINE);
    penis[45] = memnew(BLOCKPAINTGAHLUL);

    penis[46] = memnew(BLOCKGRILL);
    penis[47] = memnew(BLOCKTRAPDOORCLOSED);
    penis[48] = memnew(BLOCKTRAPDOOROPEN);
    
    penis[49] = memnew(BLOCKPAINTLYNSMILE); // paintings batch 2
    penis[50] = memnew(BLOCKPAINTLYNWORN);
    penis[51] = memnew(BLOCKPAINTLYNFISH);

    penis[52] = memnew(BLOCKSTALACTITE);
    penis[53] = memnew(BLOCKWOOL);
    penis[54] = memnew(BLOCKSTRUCTURE);
    penis[55] = memnew(BLOCKBED);
    penis[56] = memnew(BLOCKSUNFLOWERSTEM);
    penis[57] = memnew(BLOCKSUNFLOWERTOP);
    penis[58] = memnew(BLOCKSUNFLOWERLEAF);
    penis[59] = memnew(BLOCKSUNFLOWERSMALL);
    penis[60] = memnew(BLOCKSUNFLOWERSAPLING);
    penis[61] = memnew(BLOCKPAPER);
    penis[62] = memnew(BLOCKLETTER);
    penis[63] = memnew(BLOCKBOSSSHIPPILLAR);
    penis[64] = memnew(BLOCKVANITYPRESENT);
    penis[65] = memnew(BLOCKBROWNBRICK);

    penis[66] = memnew(BLOCKPAINTTILTROKIWI); // paintings batch 3
    penis[67] = memnew(BLOCKPAINTCALVINNIGHTMARE);
    penis[68] = memnew(BLOCKPAINTCALVINSUNRISE);
    penis[69] = memnew(BLOCKPAINTOCTOSPIRAL);
    penis[70] = memnew(BLOCKPAINTKAIAGHOSTS);
    penis[71] = memnew(BLOCKPAINTKAIACREATURE);
    penis[72] = memnew(BLOCKPAINTKAIAWASHED);
    
    penis[73] = memnew(BLOCKJARFIREFLY);
    penis[74] = memnew(BLOCKMOSS);
    penis[75] = memnew(BLOCKMOSSVINE);
    penis[76] = memnew(BLOCKMOSSORB);
    penis[77] = memnew(BLOCKMOSSGRASS);
    penis[78] = memnew(BLOCKMAGICINFUSER);
    penis[79] = memnew(BLOCKLADDERPACK);
    penis[80] = memnew(BLOCKCALCITE);
    penis[81] = memnew(BLOCKAMECRYSTAL);
    penis[82] = memnew(BLOCKCOREGRASS);
    penis[83] = memnew(BLOCKCROPWHEAT);
    penis[84] = memnew(BLOCKSANDSTONE);
    penis[85] = memnew(BLOCKSNOW);
    penis[86] = memnew(BLOCKICE);
    penis[87] = memnew(BLOCKCACTUS);
    penis[88] = memnew(BLOCKCLAY);
    penis[89] = memnew(BLOCKBRICK);
    penis[90] = memnew(BLOCKSEAGRASS);
    penis[91] = memnew(BLOCKWIRE);
    penis[92] = memnew(BLOCKTELEPORTER);
    penis[93] = memnew(BLOCKWIREHIDDEN);
    penis[94] = memnew(BLOCKSOLDERINGIRON);
    penis[95] = memnew(BLOCKLAMPON);
    penis[96] = memnew(BLOCKLAMPOFF);
    penis[97] = memnew(BLOCKLEVER);
    penis[98] = memnew(BLOCKOBSERVER);
    penis[99] = memnew(BLOCKCLOCK);
    penis[100] = memnew(BLOCKREPEATER);
    penis[101] = memnew(BLOCKDRILL);
    penis[102] = memnew(BLOCKSPITTER);
    penis[103] = memnew(BLOCKEXTENDER);
    penis[104] = memnew(BLOCKPLACER);
    penis[105] = memnew(BLOCKCONVEYORRIGHT);
    penis[106] = memnew(BLOCKCONVEYORLEFT);
    penis[107] = memnew(BLOCKHOPPER);
    penis[108] = memnew(BLOCKICEICLE);
    penis[109] = memnew(BLOCKSNOWBRICK);
    penis[110] = memnew(BLOCKPINESAPLING);
    penis[111] = memnew(BLOCKPINELEAVES);
    penis[112] = memnew(BLOCKPINESOLIDLEAF);
    penis[113] = memnew(BLOCKOREFIBER);
    penis[114] = memnew(BLOCKMARBLE);
    penis[115] = memnew(BLOCKMARBLEBRICK);
    penis[116] = memnew(BLOCKMARBLEPILLAR);
    penis[117] = memnew(BLOCKCAMPFIRE);
    penis[118] = memnew(BLOCKSTONEMOSSY);
    penis[119] = memnew(BLOCKROCKDEBRIS);
    penis[120] = memnew(BLOCKSHELF);
    penis[121] = memnew(BLOCKBOOK);
    penis[122] = memnew(BLOCKTABLE);
    penis[123] = memnew(BLOCKFLOWERPOT);
    penis[124] = memnew(BLOCKCHAIN);
    penis[125] = memnew(BLOCKLANTERN);
    penis[126] = memnew(BLOCKGRANDFATHERCLOCK);
    penis[127] = memnew(BLOCKWINDCHIME);
    penis[128] = memnew(BLOCKOREFOSSIL);
    penis[129] = memnew(BLOCKTRINKETSTATION);
    penis[130] = memnew(BLOCKTROPHY);
    penis[131] = memnew(BLOCKGRASSDESERT);
    penis[132] = memnew(BLOCKPINKTREELOG);
    penis[133] = memnew(BLOCKPINKTREELEAVES);
    penis[134] = memnew(BLOCKPINKTREEFLOWERING);
    penis[135] = memnew(BLOCKPINKTREESAPLING);
    penis[136] = memnew(BLOCKPINKWOOD);
    penis[137] = memnew(BLOCKSANDSTONEBRICK);
    penis[138] = memnew(BLOCKSANDSTONEEYE);
    penis[139] = memnew(BLOCKSHOPCOMPUTER);
    penis[140] = memnew(BLOCKSHOPCOMPUTERON);
    penis[141] = memnew(BLOCKBLACKSTONE);
    penis[142] = memnew(BLOCKSHINGLE);
    penis[143] = memnew(BLOCKWALLPAPERBLUE);
    penis[144] = memnew(BLOCKWALLPAPERGREEN);
    penis[145] = memnew(BLOCKWALLPAPERYELLOW);
    penis[146] = memnew(BLOCKWALLPAPERGMA);
    penis[147] = memnew(BLOCKMINIBOSSSPAWNER);
    penis[148] = memnew(BLOCKCROPLETTUCE);
    penis[149] = memnew(BLOCKBRICKCACTUS);
    penis[150] = memnew(BLOCKBRICKSUNFLOWER);
    penis[151] = memnew(BLOCKOREGOLDDESERT);
    penis[152] = memnew(BLOCKINFOSCANNER);
    penis[153] = memnew(BLOCKTRAPFIREBALL);
    
    penis[154] = memnew(BLOCKPAINTEELWORKOUTGUY); // painting batch 4
    penis[155] = memnew(BLOCKPAINTORKPILL);
    penis[156] = memnew(BLOCKPAINTORKTRIBUTE);
    penis[157] = memnew(BLOCKPAINTSTAGJOURNEY);
    penis[158] = memnew(BLOCKPAINTSTAGFISH);
    penis[159] = memnew(BLOCKPAINTSTAGSEEN);

    penis[160] = memnew(BLOCKNUMBERSCANNER);
    penis[161] = memnew(BLOCKSUCKER);
    penis[162] = memnew(BLOCKITEMFRAME);
    penis[163] = memnew(BLOCKTABLEPINK);
    penis[164] = memnew(BLOCKLEAVESSTATIC);
    penis[165] = memnew(BLOCKLEAVESSTATICPINE);
    penis[166] = memnew(BLOCKRUBBER);
    penis[167] = memnew(BLOCKARMORSTAND);
    penis[168] = memnew(BLOCKPINWHEEL);

    for(BLOCK *i : penis){ // i increase automatically !
        i->setLookUp(this);
    }
}

LOOKUPBLOCK::~LOOKUPBLOCK() {
}

Dictionary LOOKUPBLOCK::getBlockData(int id){
    Dictionary data ={};

    BLOCK* g = penis[id];
    data["texture"] = g->texture;
    data["rotateTextureToGravity"] = g->rotateTextureToGravity;
    data["connectTexturesToMe"] = g->connectTexturesToMe;
    data["connectedTexture"] = g->connectedTexture;
    data["hasCollision"] = g->hasCollision;
    data["itemToDrop"] = g->itemToDrop;
    data["breakParticleID"] = g->breakParticleID;
    data["breakTime"]= g->breakTime;
    data["lightMultiplier"] = g->lightMultiplier;
    data["lightEmmission"] = g->lightEmmission;
    data["multitile"] = g->multitile;
    data["animated"] = g->animated;
    data["miningLevel"] = g->miningLevel;
    data["soundMaterial"] = g->soundMaterial;
    data["natural"] = g->natural;
    data["bgimmune"] = g->backgroundColorImmune;

    return data;
}

bool LOOKUPBLOCK::hasCollision(int id){
    BLOCK* g = penis[id];

    return g->hasCollision;
}

bool LOOKUPBLOCK::isGravityRotate(int id){
    BLOCK* g = penis[id];

    return g->rotateTextureToGravity;
}

bool LOOKUPBLOCK::isConnectedTexture(int id){
    BLOCK* g = penis[id];

    return g->connectedTexture;
}

Ref<Image> LOOKUPBLOCK::getTextureImage(int id){
    BLOCK* g = penis[id];

    return g->texImage;
}


bool LOOKUPBLOCK::isTextureConnector(int id){
    BLOCK* g = penis[id];

    return g->connectTexturesToMe;
}

bool LOOKUPBLOCK::isMultitile(int id){
    BLOCK* g = penis[id];

    return g->multitile;
}

bool LOOKUPBLOCK::isAnimated(int id){
    BLOCK* g = penis[id];

    return g->animated;
}

double LOOKUPBLOCK::getLightMultiplier(int id){
    BLOCK* g = penis[id];

    return g->lightMultiplier;
}

double LOOKUPBLOCK::getLightEmmission(int id){
    BLOCK* g = penis[id];

    return g->lightEmmission;
}

bool LOOKUPBLOCK::isTransparent(int id){
    BLOCK* g = penis[id];

    return g->isTransparent;
}

int LOOKUPBLOCK::getMiningLevel(int id){
    BLOCK* g = penis[id];

    return g->miningLevel;
}

bool LOOKUPBLOCK::isBGImmune(int id){
    BLOCK* g = penis[id];

    return g->backgroundColorImmune;
}

bool LOOKUPBLOCK::isOnlyConnectToSelf(int id){
    BLOCK* g = penis[id];

    return g->connectToSelfOnly;
}

Dictionary LOOKUPBLOCK::runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID){
   
    return penis[blockID]->onTick(x,y,planet,dir);

}

Dictionary LOOKUPBLOCK::runOnBreak(int x, int y, PLANETDATA *planet, int dir, int blockID){
   
    return penis[blockID]->onBreak(x,y,planet,dir);

}

Dictionary LOOKUPBLOCK::runOnEnergize(int x, int y, PLANETDATA *planet, int dir, int blockID){
   
    return penis[blockID]->onEnergize(x,y,planet,dir);

}

Dictionary LOOKUPBLOCK::runOnLoad(int x, int y, PLANETDATA *planet, int dir, int blockID){
   
    return penis[blockID]->onLoad(x,y,planet,dir);

}

