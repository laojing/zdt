package optimize

class Localten implements Serializable {

	static mapping = {
		version false
		id composite:['savetime','turbnum']
	}

    int savetime
    int turbnum
    Float Wind
    Float Power
    Float Var
    Float Voltagea
    Float Voltageb
    Float Voltagec
    Float Currenta
    Float Currentb
    Float Currentc
    Float Speed
    Float Pitch1
    Float Pitch2
    Float Pitch3
    Float Direct
    Float Position

    static constraints = {
    }
	boolean equals(other) {
		if ( !(other instanceof Ten) ) {
			return false;
		}
		other.savetime == savetime && other.turbnum == turbnum
	}
}


