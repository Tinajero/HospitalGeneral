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
	String curp
	String folioSeguroPopular
	Long edad
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
    	expediente blank: true, matches: '\\d{2}\\-\\d{2}\\-\\d{2}', unique: true, nullable: true
    	numeroTelefono blank:false
    	poblacion blank: false
    }
    static mapping = {
    	edad formula: "controlCitaDB.calcular_edad_curp(curp)"
    }

    /*Esta es la function que se debe de crear en la base de datos.
    CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_edad_curp`( curp VARCHAR(20)) RETURNS int(11)
	BEGIN
	
		RETURN TIMESTAMPDIFF(YEAR, concat(substring(curp, 4,2),'-' ,substring(curp, 6,2), '-',substring(curp, 8,2) ), CURDATE());
	END
    */
}
