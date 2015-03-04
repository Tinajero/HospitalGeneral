package cita
import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])
class MetodosCalendarController {

    def index() { }

    def metodo () {
    	String operacion = params['method']
    	println "me mandaraon "  + operacion
    
    }
}
