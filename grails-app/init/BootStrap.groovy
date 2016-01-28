import optimize.OptuserOptrole
import optimize.Optuser
import optimize.Optrole

class BootStrap {

    def init = { servletContext ->

		def adminRole = new Optrole('ROLE_ADMIN').save()
		def userRole = new Optrole('ROLE_USER').save()

		def adminUser = new Optuser('zdt', '121').save()
		def userUser = new Optuser('sut', '121').save()

		OptuserOptrole.create adminUser, adminRole, true
		OptuserOptrole.create userUser, userRole, true

    }

    def destroy = {
    }
}
