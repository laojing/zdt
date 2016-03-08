package optimize

import grails.plugin.springsecurity.annotation.Secured

class WindController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def index() { }
 	def getcurdata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		render(contentType:"text/json"){[total:good]}
	}

	def getwinddata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		render(contentType:"text/json"){[tens:good]}
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def yaw() { }
	
	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def lost() { }

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def change() { }
}
