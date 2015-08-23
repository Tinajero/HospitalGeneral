package busquedas

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])
@Transactional(readOnly = true)
class BusquedasComodinController {
    def BusquedasService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index()
    {

    }
    def buscar()
    {
      def lista  = BusquedasService.obtenLista(params)
      print params
      render (view:'resultados', model:['lista':lista])
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'busquedasComodin.label', default: 'BusquedasComodin'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
