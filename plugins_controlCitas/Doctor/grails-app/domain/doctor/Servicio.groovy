package doctor

import java.util.Date;

class Servicio extends ServicioMedico{

	static hasMany = [subServicios: SubServicio]
	
	static constraints = {
	}
	
}
