/obj/structure/lootchest
	density = TRUE
	name = "lootchest"
	desc = "testlootchest"
	icon = 'icons/obj/lootchest/lootchest.dmi'
	icon_state = "idle"
	var/datum/storage/storage_type = /datum/storage

/obj/structure/lootchest/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(icon_state == "idle")
		icon_state = "opened"
	else
		icon_state = "idle"

/* /obj/structure/lootchest/ComponentInitialize()
    . = ..()
    AddComponent(/datum/component/storage)
    var/datum/component/storage/STR = GetComponent(/datum/component/storage)
    STR.max_combined_w_class = 100
    STR.max_w_class = 100
    STR.max_items = 100
    STR.locked = FALSE
	new /obj/item/chainsaw (src) */

/obj/structure/lootchest/Initialize(mapload)
	. = ..()

	create_storage(storage_type = storage_type)

	PopulateContents()

	for (var/obj/item/item in src)
		item.item_flags |= IN_STORAGE

/obj/structure/lootchest/create_storage(
	max_slots,
	max_specific_storage,
	max_total_storage,
	list/canhold,
	list/canthold,
	storage_type,
)
	// If no type was passed in, default to what we already have
	storage_type ||= src.storage_type
	return ..()

/obj/structure/lootchest/proc/PopulateContents()
	new /obj/item/chainsaw(src)

/obj/structure/lootchest/proc/emptyStorage()
	atom_storage.remove_all()

/obj/structure/lootchest/Destroy()
	for(var/obj/important_thing in contents)
		if(!(important_thing.resistance_flags & INDESTRUCTIBLE))
			continue
		important_thing.forceMove(drop_location())
	return ..()
