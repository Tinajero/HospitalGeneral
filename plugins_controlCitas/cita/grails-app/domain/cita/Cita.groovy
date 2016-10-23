package cita

import paciente.Paciente
import doctor.Doctor
class Cita {

	Paciente paciente
	Doctor doctor
	Date fecha
	/*Tipo de cita sera 1 para primera vez 2 para subsecuente*/
	Integer tipoCita
    static constraints = {
    }
}
