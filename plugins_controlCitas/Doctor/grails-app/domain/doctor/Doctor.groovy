package doctor

class Doctor {
	String tipoCita
	String nombre
	String apellidoPat
	String apellidoMat
	String diasLaborales 
	String[] horario = {null}
	String[] diasNoLaborales = {null}
    static constraints = {
		tipoCita blank: false
		nombre blank: false
		apellidoPat blank: false
		apellidoMat blank:false
		horario blank: true
		diasNoLaborales blank: true

    }

  	static mapping = {
  		diasLaborales defaultvalue: "1000001"

  	}
}
