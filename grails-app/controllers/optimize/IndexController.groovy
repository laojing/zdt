package optimize

import grails.plugin.springsecurity.annotation.Secured

class IndexController {

	@Secured ( ['permitAll'] )
    def index() { 
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
    def logindex() { 
		render ( view:"index" )
	}

	def updateover() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def cur = (new Date().getTime() / 1000.0) as int
		//def real = Ten.findAll ( 'from Ten as a where a.savetime>'+(cur-600)+' and a.savetime<='+cur+' order by a.turbnum')
		def real = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		def effi1 = Effi.findAll ( 'from Effi as a where a.turbnum<=33 and a.value>-123.456 order by a.value desc' )
		def effi2 = Effi.findAll ( 'from Effi as a where a.value>-123.456 and a.turbnum>33 order by a.value desc' )

		def pitch1 = Pitch.findAll ( 'from Pitch as a where a.turbnum<=33 and a.savetime>'+(cur-60*60*24*9)+' and a.savetime<='+cur+' order by a.optgain desc' )
		def pitch2 = Pitch.findAll ( 'from Pitch as a where a.turbnum>33 and a.savetime>'+(cur-60*60*24*9)+' and a.savetime<='+cur+' order by a.optgain desc' )

		def wind1 = Wind.findAll ( 'from Wind as a where a.turbnum<=33 order by a.alpha desc' )
		def wind2 = Wind.findAll ( 'from Wind as a where a.turbnum>33 order by a.alpha desc' )

		def follow = Follow.findAll ( 'from Follow as a order by a.turbnum' )

		render(contentType:"text/json"){[lasttime:lasttime,real:real,effi1:effi1,effi2:effi2,pitch1:pitch1,pitch2:pitch2,wind1:wind1,wind2:wind2,follow:follow]}
	}
}
