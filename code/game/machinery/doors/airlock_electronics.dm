//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/item/weapon/airlock_electronics
	name = "airlock electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	w_class = ITEM_SIZE_SMALL //It should be tiny! -Agouri

	matter = list(MATERIAL_STEEL = 50,MATERIAL_GLASS = 50)

	req_access = list(access_engine)

	var/secure = 0 //if set, then wires will be randomized and bolts will drop if the door is broken
	var/list/conf_access = list()
	var/one_access = 0 //if set to 1, door would receive req_one_access instead of req_access
	var/last_configurator = null
	var/locked = 1
	var/lockable = 1

/obj/item/weapon/airlock_electronics/attack_self(mob/user)
	if (!ishuman(user) && !istype(user,/mob/living/silicon/robot))
		return ..(user)

	ui_interact(user)


/obj/item/weapon/airlock_electronics/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, datum/topic_state/state = hands_state)
	var/list/data = ui_data()

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "airlock_electronics.tmpl", src.name, 1000, 500, null, null, state)
		ui.set_initial_data(data)
		ui.open()

/obj/item/weapon/airlock_electronics/ui_data()
	var/list/data = list()
	var/list/regions = list()

	for(var/i in ACCESS_REGION_SECURITY to ACCESS_REGION_SUPPLY) //code/game/jobs/_access_defs.dm
		var/list/region = list()
		var/list/accesses = list()
		for(var/j in get_region_accesses(i))
			var/list/access = list()
			access["name"] = get_access_desc(j)
			access["id"] = j
			access["allowed"] = (j in src.conf_access) ? 1 : 0
			accesses[++accesses.len] = access
		region["name"] = get_region_accesses_name(i)
		region["accesses"] = accesses
		regions[++regions.len] = region
	data["regions"] = regions
	data["oneAccess"] = one_access
	data["locked"] = locked
	data["lockable"] = lockable

	return data

/obj/item/weapon/airlock_electronics/Topic(var/href, var/list/href_list)
	if(..())
		return 1
	if(lockable)
		if(href_list["unlock"])
			if(!req_access || istype(usr, /mob/living/silicon))
				locked = FALSE
				last_configurator = usr.name
			else
				var/obj/item/weapon/card/id/I = usr.get_active_hand()
				I = I ? I.GetIdCard() : null
				if(!istype(I, /obj/item/weapon/card/id))
					to_chat(usr, "<span class='warning'>[\src] flashes a yellow LED near the ID scanner. Did you remember to scan your ID or PDA?</span>")
					return
				if (check_access(I))
					locked = FALSE
					last_configurator = I.registered_name
				else
					to_chat(usr, "<span class='warning'>[\src] flashes a red LED near the ID scanner, indicating your access has been denied.</span>")
					return
			return 1
		else if(href_list["lock"])
			locked = TRUE
			return 1

	if(href_list["clear"])
		conf_access = list()
		one_access = FALSE
		return 1
	if(href_list["one_access"])
		one_access = !one_access
		return 1
	if(href_list["allowed"])
		var/access_type = text2num(href_list["access_target"])
		var/access_allowed = text2num(href_list["allowed"])
		if(!access_allowed)
			conf_access += access_type
		else
			conf_access -= access_type
		return 1

/obj/item/weapon/airlock_electronics/secure
	name = "secure airlock electronics"
	desc = "designed to be somewhat more resistant to hacking than standard electronics."
	origin_tech = list(TECH_DATA = 2)
	secure = TRUE

/obj/item/weapon/airlock_electronics/brace
	name = "airlock brace access circuit"
	req_access = list()
	locked = FALSE
	lockable = FALSE

/obj/item/weapon/airlock_electronics/brace/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, datum/topic_state/state = deep_inventory_state)
	var/list/data = ui_data()

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "airlock_electronics.tmpl", src.name, 1000, 500, null, null, state)
		ui.set_initial_data(data)
		ui.open()
