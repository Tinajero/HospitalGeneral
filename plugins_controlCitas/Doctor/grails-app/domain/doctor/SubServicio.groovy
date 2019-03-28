package doctor


class SubServicio extends ServicioMedico {

	String colorHexadecimal;
	static hasMany = [tipoSubServicios: TipoSubServicio]
	static belongsTo = Servicio 
    static constraints = {
		
    }
}
