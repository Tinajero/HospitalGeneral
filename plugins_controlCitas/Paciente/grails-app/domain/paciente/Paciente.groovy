package paciente
/*
 * Clase que guardara la informacion de los pacientes, en este caso
 * solo necesita de el nombre y el string que se genera con el expediente
 * 
 * 
 * 
 */
class Paciente {

	String apellidoPaterno
	String apellidoMaterno
	String nombre
	String expediente
	/* Esto para que el paciente pueda cambiar de telefono, o no tener, y podamos tener todos
	 * asi como las poblaciones, que tal que se cambia de lugar de residencia, esto para no tener
	 * problemas en los formularios al momento que ingresen datos que no tenian por las razones
	 * anteriores.
	 * */
	static hasMany = [numeroTelefono:String, poblacion:String] 
	
    static constraints = {
    	apellidoPaterno blank: false
    	apellidoMaterno blank: false
    	nombre blank:false
    	expediente blank: false, matches: '\\d{2}\\-\\d{2}-\\d{2}'//format: 'dd-dd-dd' //unique: true
    	numeroTelefono blank:false
    	poblacion blank: false
    }
}
