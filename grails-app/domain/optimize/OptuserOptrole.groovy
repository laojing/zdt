package optimize

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class OptuserOptrole implements Serializable {

	private static final long serialVersionUID = 1

	Optuser optuser
	Optrole optrole

	OptuserOptrole(Optuser u, Optrole r) {
		this()
		optuser = u
		optrole = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof OptuserOptrole)) {
			return false
		}

		other.optuser?.id == optuser?.id && other.optrole?.id == optrole?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (optuser) builder.append(optuser.id)
		if (optrole) builder.append(optrole.id)
		builder.toHashCode()
	}

	static OptuserOptrole get(long optuserId, long optroleId) {
		criteriaFor(optuserId, optroleId).get()
	}

	static boolean exists(long optuserId, long optroleId) {
		criteriaFor(optuserId, optroleId).count()
	}

	private static DetachedCriteria criteriaFor(long optuserId, long optroleId) {
		OptuserOptrole.where {
			optuser == Optuser.load(optuserId) &&
			optrole == Optrole.load(optroleId)
		}
	}

	static OptuserOptrole create(Optuser optuser, Optrole optrole, boolean flush = false) {
		def instance = new OptuserOptrole(optuser, optrole)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(Optuser u, Optrole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = OptuserOptrole.where { optuser == u && optrole == r }.deleteAll()

		if (flush) { OptuserOptrole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(Optuser u, boolean flush = false) {
		if (u == null) return

		OptuserOptrole.where { optuser == u }.deleteAll()

		if (flush) { OptuserOptrole.withSession { it.flush() } }
	}

	static void removeAll(Optrole r, boolean flush = false) {
		if (r == null) return

		OptuserOptrole.where { optrole == r }.deleteAll()

		if (flush) { OptuserOptrole.withSession { it.flush() } }
	}

	static constraints = {
		optrole validator: { Optrole r, OptuserOptrole ur ->
			if (ur.optuser == null || ur.optuser.id == null) return
			boolean existing = false
			OptuserOptrole.withNewSession {
				existing = OptuserOptrole.exists(ur.optuser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['optuser', 'optrole']
		version false
	}
}
