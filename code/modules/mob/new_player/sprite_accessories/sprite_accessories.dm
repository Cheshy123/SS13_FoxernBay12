/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna2.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

/proc/init_sprite_accessory_subtypes(var/prototype, var/list/L, var/list/male, var/list/female, var/list/full_list)
	if(!istype(L))	L = list()
	if(!istype(male))	male = list()
	if(!istype(female))	female = list()
	if(!istype(full_list))	full_list = list()

	for(var/path in subtypesof(prototype))
		var/datum/sprite_accessory/D = new path()

		if(D.name)
			L[D.name] = D
			full_list[D.name] = D

			switch(D.gender)
				if(MALE)	male[D.name] = D
				if(FEMALE)	female[D.name] = D
				else
					male[D.name] = D
					female[D.name] = D
	return L

/datum/sprite_accessory

	var/icon			// the icon file the accessory is located in
	var/icon_state		// the icon_state of the accessory
	var/preview_state	// a custom preview state for whatever reason

	var/name			// the preview name of the accessory

	// Determines if the accessory will be skipped or included in random hair generations
	var/gender = NEUTER

	// Restrict some styles to specific species
	var/list/species_allowed = list(SPECIES_HUMAN)

	// Whether or not the accessory can be affected by colouration
	var/do_colouration = 1

/*
////////////////////////////
/  =--------------------=  /
/  == Hair Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

/datum/sprite_accessory/hair
	icon = 'icons/mob/Human_face.dmi'	  // default icon for all hairs
	var/veryshort						//doesn't need to be hidden by BLOCKHEADHAIR hats/helmets

/*
///////////////////////////////////
/  =---------------------------=  /
/  == Facial Hair Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/facial_hair
	icon = 'icons/mob/human_face.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix /w beards :P)

/datum/sprite_accessory/facial_hair/shaved
	name = "Shaved"
	icon_state = "bald"
	gender = NEUTER
	species_allowed = list(SPECIES_HUMAN,SPECIES_UNATHI,SPECIES_ETHARI,SPECIES_SKRELL,SPECIES_VOX,SPECIES_IPC)

/*
////////////////////////////
/  =--------------------=  /
/  == Head Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

/datum/sprite_accessory/head
	gender = NEUTER


//skin styles - WIP
//going to have to re-integrate this with surgery
//let the icon_state hold an icon preview for now
/datum/sprite_accessory/skin
	icon = 'icons/mob/human_races/r_human.dmi'

	human
		name = "Default human skin"
		icon_state = "default"
		species_allowed = list(SPECIES_HUMAN)

	human_tatt01
		name = "Tatt01 human skin"
		icon_state = "tatt1"
		species_allowed = list(SPECIES_HUMAN)

	etharian
		name = "Default etharian skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_etharian.dmi'
		species_allowed = list(SPECIES_ETHARI)

	unathi
		name = "Default Unathi skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_lizard.dmi'
		species_allowed = list(SPECIES_UNATHI)

	skrell
		name = "Default skrell skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_skrell.dmi'
		species_allowed = list(SPECIES_SKRELL)
