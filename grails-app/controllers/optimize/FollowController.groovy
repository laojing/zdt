package optimize

import grails.plugin.springsecurity.annotation.Secured

class FollowController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def index() { }

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def data() {
		def effi = Follow.list(sort:'turbnum');
		render( view:"data", model:[effi:effi] )
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def dist() { }

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def temp() { }


	@Secured ( ['ROLE_ADMIN'] )
  	def getupdatedata() {
		def cur = (new Date().getTime() / 1000.0) as int
		def effi = Follow.list ( sort:'turbnum' )
		def good = Ten.findAll ( 'from Ten as a where a.turbnum=0 and a.savetime>'+(cur-3600*24)+' and a.savetime<='+cur+' order by a.savetime')
		render(contentType:"text/json"){[effi:effi,real:good]}
	}
}
