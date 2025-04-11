package doctor

import java.util.Date;

class Doctor {
	
	String nombre
	String apellidoPat
	String apellidoMat
	String diasLaborales 	
	String cedulaProfesional
	String curp
	Integer turno 	
	Servicio tipoCita
	
	Date fechaBaja
	Date fechaModificacion
	Date fechaCreacion
	
	Integer usuarioBajaId
	Integer usuarioModificacionId
	Integer usuarioCreacionId
	
    static constraints = {
		tipoCita blank: false
		nombre blank: false
		apellidoPat blank: false
		apellidoMat blank:false 
		
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true
    }

  	static mapping = {
  		diasLaborales defaultvalue: "1000001"
  	}

  	public static List listUnique(){
  		//Doctor.list().unique{ it->}

  		Doctor.withCriteria {
        	projections {
            	distinct "tipoCita"
				and {
					isNull('fechaBaja')				
				}
        	}	
        }.sort() 

/*
		def criteria = Doctor.createCriteria()
		criteria.listDistinct () {
			
            isNull('fechaBaja')				
        }.sort()
		*/
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
