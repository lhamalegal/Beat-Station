#define isatom(A) istype(A, /atom)
#define ismovableatom(A) istype(A, /atom/movable)
#define isclient(A) istype(A, /client)

#define islist(L) (istype(L,/list))

#define in_range(source, user) (get_dist(source, user) <= 1)

// MOB HELPERS

// Human sub-species
#define isabductor(A)		(is_species((A), /datum/species/abductor))
#define isgolem(A)			(is_species((A), /datum/species/golem))
#define islizard(A)			(is_species((A), /datum/species/lizard))
#define isplasmaman(A)		(is_species((A), /datum/species/plasmaman))
#define ispodperson(A)		(is_species((A), /datum/species/podperson))
#define isflyperson(A)		(is_species((A), /datum/species/fly))
#define iszombie(A)			(is_species((A), /datum/species/zombie))
#define ishumanbasic(A)		(is_species((A), /datum/species/human))

#define islimb(A) (istype(A, /obj/item/bodypart))

//#define isobj(A) istype(A, /obj) //override the byond proc because it returns true on children of /atom/movable that aren't objs

// ASSEMBLY HELPERS

#define isassembly(O) (istype(O, /obj/item/device/assembly))

#define isigniter(O) (istype(O, /obj/item/device/assembly/igniter))

#define isinfared(O) (istype(O, /obj/item/device/assembly/infra))

#define isprox(O) (istype(O, /obj/item/device/assembly/prox_sensor))

#define issignaler(O) (istype(O, /obj/item/device/assembly/signaler))

#define istimer(O) (istype(O, /obj/item/device/assembly/timer))


#define isradio(A) istype(A, /obj/item/device/radio)