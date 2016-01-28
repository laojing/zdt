package optimize

import grails.plugin.springsecurity.annotation.Secured

class SectorController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def index() { }

 	def getcurdata() {
		def cur = (new Date().getTime() / 1000.0) as int
		def good = Ten.findAll ( 'from Ten as a where a.savetime>'+(cur-600)+' and a.savetime<='+cur+' order by a.turbnum')
		render(contentType:"text/json"){[total:good]}
	}

}
