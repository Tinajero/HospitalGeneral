package doctor

class Doctor {
	
	String nombre
	String apellidoPat
	String apellidoMat
	String diasLaborales 	
	String cedulaProfesional
	String curp
	Integer turno 	
	Servicio tipoCita
	
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
	  
	void setNombre(String s){
		nombre = s?.toUpperCase()
	}
	void setApellidoPat(String s){
		apellidoPat = s?.toUpperCase()
	}
	void setApellidoMat(String s){
		apellidoMat = s?.toUpperCase()
	}
	void setCurp(String s){
		curp = s?.toUpperCase()
	}
}
