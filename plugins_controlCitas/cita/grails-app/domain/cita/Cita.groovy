package cita

import paciente.Paciente
import doctor.Doctor
import doctor.SubServicio
import doctor.TipoSubServicio
class Cita {

	Paciente paciente
	Doctor doctor
	Date fecha
	/*Tipo de cita sera 0 para primera vez 1 para subsecuente*/
	SubServicio tipoCita
	SubServicio asignadaA
	TipoSubServicio tipoSubServicioAtendido;
	
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
		tipoSubServicioAtendido nullable:true
    }
}
