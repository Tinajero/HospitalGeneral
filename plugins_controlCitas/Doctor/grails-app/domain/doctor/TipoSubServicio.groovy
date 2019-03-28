package doctor

class TipoSubServicio extends ServicioMedico {

	static belongsTo = doctor.SubServicio
	
    static constraints = {
    }
}
