package paciente

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Paciente)
class PacienteSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Prueba la creacion de fecha con el curp"() {
		
					
		
		Paciente p = new Paciente();
		String curp = "RUTD920420HOCZNN04";
		
		p.setCurp(curp);
		
		Calendar fechaNacimiento = Calendar.getInstance();
		fechaNacimiento.set(1992, 03, 20)
	
		expect: "fix me"
			fechaNacimiento.get(Calendar.YEAR) == p.fechaNacimiento.get(Calendar.YEAR);
			fechaNacimiento.get(Calendar.MONTH) == p.fechaNacimiento.get(Calendar.MONTH);
			fechaNacimiento.get(Calendar.DAY_OF_MONTH) == p.fechaNacimiento.get(Calendar.DAY_OF_MONTH);
		println fechaNacimiento.getTime()
		
    }
	
	void "prueba la creacion de sexo con curp"() {
		
		Paciente p = new Paciente();
		String curp = "RUTD920420HOCZNN04";
		p.setCurp(curp)
		expect: "Creacion correcta"
			p.getSexo().compareTo("1") == 0
	}
	
	void "prueba la creacion de Entidad Federativa con curp"() {
		
		Paciente p = new Paciente();
		String curp = "RUTD920420HOCZNN04";
		p.setCurp(curp)
		expect: "Creacion correcta"
			p.entidadFederativa.compareTo("OC") == 0
	}
}
