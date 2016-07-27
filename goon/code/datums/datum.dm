/datum/var/tmp/disposed = 0
/datum/var/tmp/qdeled = 0
// override this in children for your type specific disposing implementation, make sure to call ..() so the root disposing runs too
/datum/proc/disposing()

// don't override this one, just call it instead of delete to get rid of something cheaply
/datum/proc/dispose()
	if (!disposed)
		disposing()
		disposed = 1

// for caching/reusing
/datum/proc/pooled(var/pooltype)
	dispose()
	// If this thing went through the delete queue and was rescued by the pool mechanism, we should reset the qdeled flag.
	qdeled = 0

/datum/proc/unpooled(var/pooltype)
	disposed = 0

/datum/Del()
	if (!disposed)
		dispose()
	..()