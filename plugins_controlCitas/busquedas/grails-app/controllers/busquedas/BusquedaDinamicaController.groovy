package busquedas

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])
@Transactional(readOnly = true)
class BusquedaDinamicaController {
    def BusquedasService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def busqueda()
    {

    }    
}
