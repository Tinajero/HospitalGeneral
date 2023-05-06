package doctor

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(DiaSinCitaService)
class DiaSinCitaServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
		def diaSinC = DiaSinCitaService.isDiaSinCita(1);
    }
}
