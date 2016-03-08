package optimize

import grails.plugin.springsecurity.annotation.Secured

class PowerController {

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def index() {
	}
	def getstand () {
		render(contentType:"text/json"){[stand1:Stand.findAll('from Stand as a where a.turbtype=0'),stand2:Stand.findAll('from Stand as a where a.turbtype=1')]}
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def stand() { }
	def setdefault () {
		def tt = params.turbtype as int
		def values = params.values.split('==')
		def index = 3.0
		for ( item in values ) {
			def ss = Stand.findByTurbtypeAndWind ( tt, index )
			ss.Power = item as float
			ss.save ( flush:true )
			index += 0.5
		}
		render(contentType:"text/json"){[ok:'ok']}
	}

	def getdefault () {
		def tt = params.turbtype as int

		def defaults = Stand.findAll ( 'from Stand as a where a.turbtype='+tt+' order by a.wind' )
		def def1 = [0,0,20.85,45.34,75.55,111.15,154.9,209.2,274.26,351.19,440.93,544.81,663.46,794.22,929.41,1070.26,1212.07,1353.78,1491.7,1500,1500,1500]
		def def2 = [0,0,4,27,50,86,126,181,243,315,402,502,620,739,886,1027,1187,1326,1435,1478,1500,1500]

		def i=0
		if ( defaults.size() < 10 ) {
			if ( tt == 0 ) {
				for ( i=0; i<22; i++ ) {
					Stand st = new Stand()
					st.turbtype = tt
					st.Wind = 2.0 + i*0.5
					if( i==0 ) st.Wind = 0
					if( i==1 ) st.Wind = 2.9
					if( i==21 ) st.Wind = 25
					st.Power = def1[i]
					st.save( flush:true )
				}
			} else {
				for ( i=0; i<22; i++ ) {
					Stand st = new Stand()
					st.turbtype = tt
					st.Wind = 2.0 + i*0.5
					if( i==0 ) st.Wind = 0
					if( i==1 ) st.Wind = 2.9
					if( i==21 ) st.Wind = 25
					st.Power = def2[i]
					st.save( flush:true )
				}
			}
		}
		render(contentType:"text/json"){[defaults:defaults]}
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def effi() {
		def effi = Effi.findAll ( 'from Effi as a order by a.value desc' )
		def state = 1;
		if ( effi.size() <= 0 ) {		
			for ( int i=0; i<66; i++ ) {
				effi[i] = [turbnum:i+1,value:0.4-i*0.01];
			}
			state = 0;
		}
		render( view:"effi", model:[effi:effi,state:state] )
	}

	@Secured ( ['ROLE_ADMIN','ROLE_USER'] )
  	def check() {
	}

  	def getupdatedata() {
		def lasttime = Ten.findAll( 'from Ten as a order by a.savetime desc', [max:1] )[0].savetime
		def good = Ten.findAll('from Ten as a where a.turbnum=0 and a.savetime>='+(lasttime-3600*24)+' and a.savetime<='+lasttime+' order by a.savetime')
		def effi = Effi.findAll ( 'from Effi as a where a.value>-123.456 order by a.value desc' )
		if ( effi.size() > 2 ) {
			def bad = Ten.findAll('from Ten as a where a.turbnum='+effi[effi.size()-1].turbnum+ ' and a.savetime>'+(lasttime-3600*24)+' and a.savetime<='+lasttime+' order by a.savetime')
			def mid = effi.size()/2 as int
			def middle = Ten.findAll('from Ten as a where a.turbnum='+effi[mid].turbnum+ ' and a.savetime>'+(lasttime-3600*24)+' and a.savetime<='+lasttime+' order by a.savetime')
			render(contentType:"text/json"){[effi:effi,real:good,bad:bad,mid:middle,badturb:effi[effi.size()-1].turbnum]}
		} else {
			render(contentType:"text/json"){[effi:effi,real:good]}
		}
	}

	def getlinedata () {
		def start = (params.start as int)
		def end = (params.end as int)

		def total = Ten.findAll('from Ten as a where a.turbnum='+params.turbinenum+ ' and a.savetime>='+start+' and a.savetime<='+end)
		def turb = new PowerTurb()
		turb.turbnum = params.turbinenum as int
		turb.init()
		turb.calcBin(total)

		render(contentType:"text/json"){[total:turb.bins]}
	}
}
