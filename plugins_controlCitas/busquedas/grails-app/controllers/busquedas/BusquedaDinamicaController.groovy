package busquedas

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])
@Transactional(readOnly = true)
class BusquedaDinamicaController {
    def BusquedaDinamicaService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def busqueda()
    {


    }    

    def realizarBusqueda(params){
        print params

        def listaResultados = BusquedaDinamicaService.busquedaDinamica(params)

       render(view: "listado", model:[lista:listaResultados])

    }
}
