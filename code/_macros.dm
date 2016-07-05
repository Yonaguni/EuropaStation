#define Clamp(x, y, z) 	(x <= y ? y : (x >= z ? z : x))
#define CLAMP01(x) 		(Clamp(x, 0, 1))

#define isalien(A) istype(A, /mob/living/human/alien)

#define isanimal(A) istype(A, /mob/living/animal)

#define isairlock(A) istype(A, /obj/machinery/door/airlock)

#define isbrain(A) istype(A, /mob/living/brain)

#define isEye(A) istype(A, /mob/eye)

#define ishuman(A) istype(A, /mob/living/human)

#define isliving(A) istype(A, /mob/living)

#define ismouse(A) istype(A, /mob/living/animal/mouse)

#define isborer(A) 0

#define isnewplayer(A) istype(A, /mob/new_player)

#define isobj(A) istype(A, /obj)

#define isobserver(A) istype(A, /mob/dead/observer)

#define isorgan(A) istype(A, /obj/item/organ/external)

#define attack_animation(A) if(istype(A)) A.do_attack_animation(src)

#define RANDOM_BLOOD_TYPE pick(4;"O-", 36;"O+", 3;"A-", 28;"A+", 1;"B-", 20;"B+", 1;"AB-", 5;"AB+")