package doctor

import java.util.Date;


class SubServicio extends ServicioMedico {


	String colorHexadecimal;
	
	static hasMany = [tipoSubServicios: TipoSubServicio]
		
	static constraints = {
		nombre blank:false, empty:false
		descripcion blank:false	
	}
	
	
	
	@Override
	public String toString() {
		return "SubServicio [colorHexadecimal=" + colorHexadecimal + " " + super.toString() +", tipoSubServicios" + tipoSubServicios + "]";
	}
}
