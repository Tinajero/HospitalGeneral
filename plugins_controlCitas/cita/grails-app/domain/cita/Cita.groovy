package cita

import paciente.Paciente
import doctor.Doctor
class Cita {

	Paciente paciente
	Doctor doctor
	Date fecha
	/*Tipo de cita sera 1 para primera vez 2 para subsecuente*/
	Integer tipoCita
	String asignadaA
	
	Date fechaBaja
	Date fechaModificacion
	Date fechaCreacion
	
	Integer usuarioBajaId
	Integer usuarioModificacionId
	Integer usuarioCreacionId
	
    static constraints = {
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true
    }
}
