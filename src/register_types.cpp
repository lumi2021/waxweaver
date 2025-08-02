#include "register_types.h"

#include "gdexample.h"
#include "chunkdraw.h"
#include "lightmap.h"
#include "lookupBlock.h"
#include "planetData.h"
#include "planetGen.h"

//ADD BLOCKS HERE
#include "block.h"
// We don't necessarily NEED these, it will still work without but it will print ERRORS without them.
#include "blockAir.h"
#include "blockCaveAir.h"
#include "blockStone.h"
#include "blockDirt.h"
#include "blockGrass.h"
#include "blockCore.h"
#include "blockPlasma.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

using namespace godot;

//ADD BLOCKS HERE
void i_hate_my_life() {
	ClassDB::register_class<BLOCKAIR>();
	ClassDB::register_class<BLOCKCAVEAIR>();
	ClassDB::register_class<BLOCKSTONE>();
	ClassDB::register_class<BLOCKDIRT>();
	ClassDB::register_class<BLOCKGRASS>();
	ClassDB::register_class<BLOCKCORE>();
	ClassDB::register_class<BLOCKPLASMA>();
	ClassDB::register_class<BLOCKSAPLING>();
	ClassDB::register_class<BLOCKTREELOG>();
    ClassDB::register_class<BLOCKLEAVES>();
    ClassDB::register_class<BLOCKTREEBRANCHLEFT>();
    ClassDB::register_class<BLOCKTREEBRANCHRIGHT>();
    ClassDB::register_class<BLOCKTREEBRANCHLEAF>();
    ClassDB::register_class<BLOCKWOOD>();
    ClassDB::register_class<BLOCKSAND>();
    ClassDB::register_class<BLOCKTORCH>();
    ClassDB::register_class<BLOCKFURNACE>();
    ClassDB::register_class<BLOCKTALLGRASS>();
    ClassDB::register_class<BLOCKORECOPPER>();
    ClassDB::register_class<BLOCKCHAIR>();
    ClassDB::register_class<BLOCKWORKBENCH>();
    ClassDB::register_class<BLOCKGLASS>();
    ClassDB::register_class<BLOCKDOORCLOSED>();
    ClassDB::register_class<BLOCKDOOROPEN>();
    ClassDB::register_class<BLOCKOREGOLD>();
    ClassDB::register_class<BLOCKLADDER>();
    ClassDB::register_class<BLOCKFLOWER>();
    ClassDB::register_class<BLOCKOREIRON>();
    ClassDB::register_class<BLOCKGRAVEL>();
    ClassDB::register_class<BLOCKBARCOPPER>();
    ClassDB::register_class<BLOCKBARGOLD>();
    ClassDB::register_class<BLOCKBARIRON>();
    ClassDB::register_class<BLOCKSTONEBRICK>();
    ClassDB::register_class<BLOCKCHEST>();
    ClassDB::register_class<BLOCKCHESTLOOT>();
    ClassDB::register_class<BLOCKSOIL>();
    ClassDB::register_class<BLOCKSOILDRY>();
    ClassDB::register_class<BLOCKCROPPOTATO>();
    ClassDB::register_class<BLOCKCROPPOTATONATURAL>();
    ClassDB::register_class<BLOCKPAINTSTAGPLUMP>();
    ClassDB::register_class<BLOCKPAINTSTAGMARSH>();
    ClassDB::register_class<BLOCKPAINTSTAGCUP>();
    ClassDB::register_class<BLOCKPAINTSTAGDAWN>();
    ClassDB::register_class<BLOCKPAINTGAHAXA>();
    ClassDB::register_class<BLOCKPAINTGAHFINE>();
    ClassDB::register_class<BLOCKPAINTGAHLUL>();
    ClassDB::register_class<BLOCKGRILL>();
    ClassDB::register_class<BLOCKTRAPDOORCLOSED>();
    ClassDB::register_class<BLOCKTRAPDOOROPEN>();
    ClassDB::register_class<BLOCKPAINTLYNSMILE>();
    ClassDB::register_class<BLOCKPAINTLYNWORN>();
    ClassDB::register_class<BLOCKPAINTLYNFISH>();
    ClassDB::register_class<BLOCKSTALACTITE>();
    ClassDB::register_class<BLOCKWOOL>();
    ClassDB::register_class<BLOCKSTRUCTURE>();
    ClassDB::register_class<BLOCKBED>();
    ClassDB::register_class<BLOCKSUNFLOWERSTEM>();
    ClassDB::register_class<BLOCKSUNFLOWERTOP>();
    ClassDB::register_class<BLOCKSUNFLOWERLEAF>();
    ClassDB::register_class<BLOCKSUNFLOWERSMALL>();
    ClassDB::register_class<BLOCKSUNFLOWERSAPLING>();
    ClassDB::register_class<BLOCKPAPER>();
    ClassDB::register_class<BLOCKLETTER>();
    ClassDB::register_class<BLOCKBOSSSHIPPILLAR>();
    ClassDB::register_class<BLOCKVANITYPRESENT>();
    ClassDB::register_class<BLOCKBROWNBRICK>();
    ClassDB::register_class<BLOCKPAINTTILTROKIWI>();
    ClassDB::register_class<BLOCKPAINTCALVINNIGHTMARE>();
    ClassDB::register_class<BLOCKPAINTCALVINSUNRISE>();
    ClassDB::register_class<BLOCKPAINTOCTOSPIRAL>();
    ClassDB::register_class<BLOCKPAINTKAIAGHOSTS>();
    ClassDB::register_class<BLOCKPAINTKAIACREATURE>();
    ClassDB::register_class<BLOCKPAINTKAIAWASHED>();
    ClassDB::register_class<BLOCKJARFIREFLY>();
    ClassDB::register_class<BLOCKMOSS>();
    ClassDB::register_class<BLOCKMOSSVINE>();
    ClassDB::register_class<BLOCKMOSSORB>();
    ClassDB::register_class<BLOCKMOSSGRASS>();
    ClassDB::register_class<BLOCKMAGICINFUSER>();
    ClassDB::register_class<BLOCKLADDERPACK>();
    ClassDB::register_class<BLOCKCALCITE>();
    ClassDB::register_class<BLOCKAMECRYSTAL>();
    ClassDB::register_class<BLOCKCOREGRASS>();
    ClassDB::register_class<BLOCKCROPWHEAT>();
    ClassDB::register_class<BLOCKSANDSTONE>();
    ClassDB::register_class<BLOCKSNOW>();
    ClassDB::register_class<BLOCKICE>();
    ClassDB::register_class<BLOCKCACTUS>();
    ClassDB::register_class<BLOCKCLAY>();
    ClassDB::register_class<BLOCKBRICK>();
    ClassDB::register_class<BLOCKSEAGRASS>();
    ClassDB::register_class<BLOCKWIRE>();
    ClassDB::register_class<BLOCKTELEPORTER>();
    ClassDB::register_class<BLOCKWIREHIDDEN>();
    ClassDB::register_class<BLOCKSOLDERINGIRON>();
    ClassDB::register_class<BLOCKLAMPON>();
    ClassDB::register_class<BLOCKLAMPOFF>();
    ClassDB::register_class<BLOCKLEVER>();
    ClassDB::register_class<BLOCKOBSERVER>();
    ClassDB::register_class<BLOCKCLOCK>();
    ClassDB::register_class<BLOCKREPEATER>();
    ClassDB::register_class<BLOCKDRILL>();
    ClassDB::register_class<BLOCKSPITTER>();
    ClassDB::register_class<BLOCKEXTENDER>();
    ClassDB::register_class<BLOCKPLACER>();
    ClassDB::register_class<BLOCKCONVEYORRIGHT>();
    ClassDB::register_class<BLOCKCONVEYORLEFT>();
    ClassDB::register_class<BLOCKHOPPER>();
    ClassDB::register_class<BLOCKICEICLE>();
    ClassDB::register_class<BLOCKSNOWBRICK>();
    ClassDB::register_class<BLOCKPINESAPLING>();
    ClassDB::register_class<BLOCKPINELEAVES>();
    ClassDB::register_class<BLOCKPINESOLIDLEAF>();
    ClassDB::register_class<BLOCKOREFIBER>();
    ClassDB::register_class<BLOCKMARBLE>();
    ClassDB::register_class<BLOCKMARBLEBRICK>();
    ClassDB::register_class<BLOCKMARBLEPILLAR>();
    ClassDB::register_class<BLOCKCAMPFIRE>();
    ClassDB::register_class<BLOCKSTONEMOSSY>();
    ClassDB::register_class<BLOCKROCKDEBRIS>();
    ClassDB::register_class<BLOCKSHELF>();
    ClassDB::register_class<BLOCKBOOK>();
    ClassDB::register_class<BLOCKTABLE>();
    ClassDB::register_class<BLOCKFLOWERPOT>();
    ClassDB::register_class<BLOCKCHAIN>();
    ClassDB::register_class<BLOCKLANTERN>();
    ClassDB::register_class<BLOCKGRANDFATHERCLOCK>();
    ClassDB::register_class<BLOCKWINDCHIME>();
    ClassDB::register_class<BLOCKOREFOSSIL>();
    ClassDB::register_class<BLOCKTRINKETSTATION>();
    ClassDB::register_class<BLOCKTROPHY>();
    ClassDB::register_class<BLOCKGRASSDESERT>();
    ClassDB::register_class<BLOCKPINKTREELOG>();
    ClassDB::register_class<BLOCKPINKTREELEAVES>();
    ClassDB::register_class<BLOCKPINKTREEFLOWERING>();
    ClassDB::register_class<BLOCKPINKTREESAPLING>();
    ClassDB::register_class<BLOCKPINKWOOD>();
    ClassDB::register_class<BLOCKSANDSTONEBRICK>();
    ClassDB::register_class<BLOCKSANDSTONEEYE>();
    ClassDB::register_class<BLOCKSHOPCOMPUTER>();
    ClassDB::register_class<BLOCKSHOPCOMPUTERON>();
    ClassDB::register_class<BLOCKBLACKSTONE>();
    ClassDB::register_class<BLOCKSHINGLE>();
    ClassDB::register_class<BLOCKWALLPAPERBLUE>();
    ClassDB::register_class<BLOCKWALLPAPERGREEN>();
    ClassDB::register_class<BLOCKWALLPAPERYELLOW>();
    ClassDB::register_class<BLOCKWALLPAPERGMA>();
    ClassDB::register_class<BLOCKMINIBOSSSPAWNER>();
    ClassDB::register_class<BLOCKCROPLETTUCE>();
    ClassDB::register_class<BLOCKBRICKCACTUS>();
    ClassDB::register_class<BLOCKBRICKSUNFLOWER>();
    ClassDB::register_class<BLOCKOREGOLDDESERT>();
    ClassDB::register_class<BLOCKINFOSCANNER>();
    ClassDB::register_class<BLOCKTRAPFIREBALL>();
    ClassDB::register_class<BLOCKPAINTEELWORKOUTGUY>();
    ClassDB::register_class<BLOCKPAINTORKPILL>();
    ClassDB::register_class<BLOCKPAINTORKTRIBUTE>();
    ClassDB::register_class<BLOCKPAINTSTAGJOURNEY>();
    ClassDB::register_class<BLOCKPAINTSTAGFISH>();
    ClassDB::register_class<BLOCKPAINTSTAGSEEN>();
    ClassDB::register_class<BLOCKNUMBERSCANNER>();
    ClassDB::register_class<BLOCKSUCKER>();
    ClassDB::register_class<BLOCKITEMFRAME>();
    ClassDB::register_class<BLOCKTABLEPINK>();
    ClassDB::register_class<BLOCKLEAVESSTATIC>();
    ClassDB::register_class<BLOCKLEAVESSTATICPINE>();
    ClassDB::register_class<BLOCKRUBBER>();
    ClassDB::register_class<BLOCKARMORSTAND>();
    ClassDB::register_class<BLOCKPINWHEEL>();
}

void initialize_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}

	ClassDB::register_class<GDExample>();
	ClassDB::register_class<CHUNKDRAW>();
	ClassDB::register_class<LIGHTMAP>();
	ClassDB::register_class<LOOKUPBLOCK>();
	ClassDB::register_class<PLANETDATA>();
	ClassDB::register_class<PLANETGEN>();
	ClassDB::register_class<BLOCK>();

	i_hate_my_life();

}

void uninitialize_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
}

extern "C" {
// Initialization.
GDExtensionBool GDE_EXPORT lib_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, const GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization) {
	godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);

	init_obj.register_initializer(initialize_module);
	init_obj.register_terminator(uninitialize_module);
	init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);

	return init_obj.init();
}
}