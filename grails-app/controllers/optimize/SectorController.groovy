package optimize

import grails.plugin.springsecurity.annotation.Secured

class SectorController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def index() { }

 	def getcurdata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		render(contentType:"text/json"){[total:good]}
	}

}
