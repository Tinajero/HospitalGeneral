package doctor

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(SubServicioService)
class SubServicioServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:
            1==1
    }

    void "test should return false for subServicios with citas"(){
        when:
			print "hola Mundo"
		
		then:
			"hi" == "hi"
    }
}
