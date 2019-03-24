package doctor


class SubServicio extends Servicio {

	String colorHexadecimal;
	static hasMany = [subServicios: SubServicio]
    static constraints = {
		
    }
}
