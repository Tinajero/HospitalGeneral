package doctor

class Doctor {
	String tipoCita
	String nombre
	String apellidoPat
	String apellidoMat
	String diasLaborales 	
  String cedulaProfesional
  String curp
    static constraints = {
		tipoCita blank: false
		nombre blank: false
		apellidoPat blank: false
		apellidoMat blank:false		   
    }

  	static mapping = {
  		diasLaborales defaultvalue: "1000001"
  	}

  	public static List listUnique(){
  		//Doctor.list().unique{ it->}

  		Doctor.withCriteria {
        	projections {
            	distinct "tipoCita"
        	}	
        }.sort() 
  	}
}
