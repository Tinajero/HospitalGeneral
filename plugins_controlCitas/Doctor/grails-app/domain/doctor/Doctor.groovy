package doctor

class Doctor {
	String tipoCita
	String nombre
	String apellidoPat
	String apellidoMat
	String[] diasLaborales = {null}
	String[] horario = {null}
	String[] diasNoLaborales = {null}
    static constraints = {
		diasLaborales blank: true
		horario blank: true
		diasNoLaborales blank: true
    }
}
