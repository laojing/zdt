package optimize

class PowerBin {
	public int num = 0
	public float sumw = 0
	public float sump = 0
	public float w
	public float p
	def addWind ( v ) { 
		num++
		sumw += v
	}
	def addPower ( v ) { sump += v }
	def calcBin() {
		if ( num > 0 ) {
			w = sumw / num
			p = sump / num
		}
	}
}

