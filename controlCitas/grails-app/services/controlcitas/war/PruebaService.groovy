package controlcitas.war

import grails.transaction.Transactional

@Transactional
class PruebaService {

    def serviceMethod() {
        return "algo"
    }

    def foo() {
        return 'foo'
    }
}
