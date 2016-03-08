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

  	def getupdatedata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		def effi = Follow.list ( sort:'turbnum' )
		render(contentType:"text/json"){[effi:effi,real:good]}
	}
}
