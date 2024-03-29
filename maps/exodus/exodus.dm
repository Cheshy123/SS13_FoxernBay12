#if !defined(USING_MAP_DATUM)

	#include "exodus_announcements.dm"
	#include "exodus_areas.dm"
	#include "exodus_effects.dm"
	#include "exodus_elevator.dm"
	#include "exodus_holodecks.dm"
	#include "exodus_presets.dm"
	#include "exodus_shuttles.dm"

	#include "exodus_unit_testing.dm"
	#include "exodus_zas_tests.dm"

	#include "loadout/loadout_accessories.dm"
	#include "loadout/loadout_eyes.dm"
	#include "loadout/loadout_head.dm"
	#include "loadout/loadout_shoes.dm"
	#include "loadout/loadout_suit.dm"
	#include "loadout/loadout_uniform.dm"
	#include "loadout/loadout_xeno.dm"

	#include "../shared/exodus_torch/_include.dm"

	#include "exodus-s1.dmm"
	#include "exodus-s2.dmm"
	#include "exodus-z1.dmm"
	#include "exodus-z2.dmm"
	#include "exodus-z3.dmm"
	#include "exodus-z4.dmm"
	#include "exodus-z5.dmm"

	#include "../../code/modules/lobby_music/absconditus.dm"
	#include "../../code/modules/lobby_music/clouds_of_fire.dm"
	#include "../../code/modules/lobby_music/endless_space.dm"
	#include "../../code/modules/lobby_music/dilbert.dm"
	#include "../../code/modules/lobby_music/space_oddity.dm"

	#define USING_MAP_DATUM /datum/map/exodus

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Exodus

#endif
