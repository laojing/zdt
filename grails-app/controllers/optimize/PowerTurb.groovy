package optimize

class PowerTurb {
	public int turbnum
	public float effi
	public bins = [];
	public def1 = [20.85,45.34,75.55,111.15,154.9,209.2,274.26,351.19,440.93,544.81,663.46,794.22,929.41,1070.26,1212.07,1353.78,1491.7,1500,1500]
	public def2 = [4,27,50,86,126,181,243,315,402,502,620,739,886,1027,1187,1326,1435,1478,1500]
	def isGood( cur ) {
		def index = (cur.Wind - 3)*2
		def start = Math.floor((cur.Wind - 3)*2).toInteger()
		def curpower = 0.0
		// 小于3m/s风速时
		if( start < 0 ) {
			curpower = 0.0
		}else if( start+1 >= def1.size() ) {
			curpower = 1500.0
		}else {
			curpower = def1[start] + (def1[start+1] - def1[start])*2*(cur.Wind-3-start/2)
		}
		if( cur.Power < curpower*0.9 || cur.Power > curpower*1.1 ) {
			return false
		} else {
			return true
		}
	}

	def init ( ) {
		for ( int i=0; i<50; i++ ) {
			def b = new PowerBin()
			b.num = 0
			b.w = i*0.5
			b.p = 0
			bins.add(b)
		}
	}

	def calcBin ( data ) {
		data.each { it ->
			if( turbnum == it.turbnum ) {
				def index = (it.Wind*2) as int
				if( index < 50 && isGood(it) ) {
					bins[index].addWind ( it.Wind )
					bins[index].addPower ( it.Power )
				}
			}
		}
		bins.each { it ->
			it.calcBin()
		}
	}

	def calcAvg ( avg ) {
		for ( int i=0; i<50; i++ ) {
			if ( bins[i].num > 0 ) {
				avg.bins[i].num++
				avg.bins[i].w += bins[i].w
				avg.bins[i].p += bins[i].p
			}
		}
	}
	def genAvg () {
		for ( int i=0; i<50; i++ ) {
			if ( bins[i].num > 0 ) {
				bins[i].w /= bins[i].num
				bins[i].p /= bins[i].num
			}
		}
	}

	def calcEffi ( avg ) {
		float num = 0
		effi = 0.0
		for ( int i=0; i<50; i++ ) {
			if ( bins[i].num > 0 ) {
				effi += (bins[i].p - avg.bins[i].p) / avg.bins[i].p
				num += 1.0
			}
		}
		if ( num > 0.5 ) effi /= num
	}
}

