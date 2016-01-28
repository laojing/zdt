package optimize

import grails.plugin.springsecurity.annotation.Secured

class WindController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def index() { }
 	def getcurdata() {
		def cur = (new Date().getTime() / 1000.0) as int
		def good = Ten.findAll ( 'from Ten as a where a.savetime>'+(cur-600)+' and a.savetime<='+cur+' order by a.turbnum')
		render(contentType:"text/json"){[total:good]}
	}

	def getwinddata() {
		def cur = (new Date().getTime() / 1000.0) as int
		def good = Ten.findAll ( 'from Ten as a where a.savetime>'+(cur-600)+' and a.savetime<='+cur+' order by a.turbnum')
		render(contentType:"text/json"){[tens:good]}
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def yaw() { }
	
	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def lost() { }

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def change() { }
}
