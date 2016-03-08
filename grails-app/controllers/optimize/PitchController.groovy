package optimize

import grails.plugin.springsecurity.annotation.Secured

class PitchController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def index() {
	}

  	def getpitchdata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		def gains = Pitch.findAll ( 'from Pitch as a where a.savetime>'+(lasttime-60*60*24*7)+' and a.savetime<='+lasttime+' order by a.turbnum')
		render(contentType:"text/json"){[tens:good,gains:gains]}
	}

  	def getupdatedata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll ( 'from Ten as a where a.savetime='+lasttime+' order by a.turbnum')
		render(contentType:"text/json"){[real:good]}
	}

	def getlinedata () {
		def start = (params.start as int)
		def end = (params.end as int)
		def total = Pitch.findAll('from Pitch as a where a.turbnum='+params.turbinenum+ ' and a.savetime>='+start+' and a.savetime<='+end+' order by savetime')
		render(contentType:"text/json"){[total:total]}
	}

	def gettypedata () {
		def ttime = (params.turbinetime as int)
		def ttype = (params.turbinetype as int)
		if( ttype == 1 ) {
			def total = Pitch.findAll('from Pitch as a where a.turbnum<=33 and a.savetime>='+(ttime-60*60*24*7)+' and a.savetime<='+ttime+' order by turbnum')
			render(contentType:"text/json"){[total:total]}
		} else {
			def total = Pitch.findAll('from Pitch as a where a.turbnum>33 and a.savetime>='+(ttime-60*60*24*7)+' and a.savetime<='+ttime+' order by turbnum')
			render(contentType:"text/json"){[total:total]}
		}
	}


	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def compare() { }
	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def fitting() { }
	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def real() { }
	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def stand() { }
	def setdefault () {
		def tt = params.turbtype as int
		def speeds = params.speeds.split('==')
		def torques = params.torques.split('==')
		def index = 3.0
		/*
		for ( item in values ) {
			def ss = Stand.findByTurbtypeAndWind ( tt, index )
			ss.Power = item as float
			ss.save ( flush:true )
			index += 0.5
		}
		*/
		render(contentType:"text/json"){[ok:'ok']}
	}

	def getdefault () {
		def tt = params.turbtype as int

		def defaults = Stand.findAll ( 'from Stand as a where a.turbtype='+tt+' order by a.wind' )
		def def1x = [9, 9, 9, 10.58, 13.77, 16.95, 17.3, 17.3, 17.3, 17.3, 17.3]
		def def1y = [32.5965, 59.0901, 91.9751, 153.269, 259.42, 392.97, 537.616, 619.411, 786.28, 872.099, 872.099]
		def def2x = [1010, 1055, 1070, 1165, 1320, 1450, 1560, 1650, 1730, 1790, 2000]
		def def2y = [-500, 903, 1565, 1847, 2372, 2862, 3312, 3700, 7767, 8742, 9029]

		def i=0
		if ( defaults.size() < 10 ) {
			if ( tt == 2 ) {
				for ( i=0; i<def1x.size(); i++ ) {
					Stand st = new Stand()
					st.turbtype = tt
					st.Wind = def1x[i]
					st.Power = def1y[i]
					st.save( flush:true )
				}
			} else {
				for ( i=0; i<def2x.size(); i++ ) {
					Stand st = new Stand()
					st.turbtype = tt
					st.Wind = def2x[i]
					st.Power = def2y[i]
					st.save( flush:true )
				}
			}
		}
		render(contentType:"text/json"){[defaults:defaults]}
	}

  	def getfittingdata() {
		def good = Pitch.findAll ( 'from Pitch as a where a.turbnum='+params.turbinenum+' order by a.savetime desc')
		def cur = 0
		def curgain = 0
		if ( good ) {
			cur = good[0].savetime
			curgain = good[0].optgain
		}
		def gains = Ten.findAll ( 'from Ten as a where a.turbnum='+params.turbinenum+' and a.savetime>'+(cur-60*60*24*7)+' and a.savetime<='+cur+' order by a.savetime')
		render(contentType:"text/json"){[curgain:curgain,gains:gains]}
	}

  	def getcmpdata() {
		def good = Pitch.findAll ( 'from Pitch as a where a.turbnum='+params.turbinenum+' and a.savetime='+params.start)
		render(contentType:"text/json"){[curgain:good]}
	}
}
