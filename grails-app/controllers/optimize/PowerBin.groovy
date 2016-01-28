package optimize

class PowerBin {
	public float num
	public float w
	public float p
	public winds = []
	public powers = []
	def addWind ( v ) { 
		winds.add (v) 
	}
	def addPower ( v ) { powers.add (v) }
	def calcBin() {
		num = winds.size()
		float sumw = 0
		float sump = 0
		winds.each { it ->
			sumw += it
		}
		powers.each { it ->
			sump += it
		}
		if ( num > 0 ) {
			w = sumw / num
			p = sump / num
		}
	}
}
