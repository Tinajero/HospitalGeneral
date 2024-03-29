package doctor



import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class ServicioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def SpringSecurityService springSecurityService
	def ServicioService servicioService
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
		def total = Servicio.findAllByFechaBajaIsNull().size()
		def servicioList = Servicio.findAllByFechaBajaIsNull(params)

        respond servicioList, model:[servicioCount: total, servicioInstanceList: servicioList]
    }

    def show(Servicio servicio) {
        respond servicio
    }

    def create() {
		
        respond new Servicio(params)
    }

    @Transactional
    def save(Servicio servicio) {
        if (servicio == null) {
            notFound()
            return
        }
		
		servicio.nombre = servicio.nombre.toUpperCase()
		servicio.descripcion = servicio.descripcion.toUpperCase()
		
//		print params
		
		// servicio = servicioService.agregarSubServicios(params, servicio);
		
		def idUsuarioCreacion = springSecurityService.principal.id
		servicio.usuarioCreacionId = idUsuarioCreacion
		servicio.fechaCreacion = new Date();
		servicio.validate()
		
        if (servicio.hasErrors()) {
            respond servicio.errors, view:'create', model:[servicio:servicio]
            return
        }

        servicio.save flush:true
				

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'servicio.label', default: 'Servicio'), servicio.id])
                redirect servicio
            }
            '*' { respond servicio, [status: CREATED] }
        }
    }

    def edit(Servicio servicio) {
        respond servicio
    }

    @Transactional
    def update(Servicio servicio) {
        if (servicio == null) {
            notFound()
            return
        }	
		
		servicio.nombre = servicio.nombre.toUpperCase()
		servicio.descripcion = servicio.descripcion.toUpperCase()

		// servicio = servicioService.agregarSubServicios(params, servicio);		
		
		def idUsuarioModificacion = springSecurityService.principal.id
		servicio.usuarioModificacionId = idUsuarioModificacion
		servicio.fechaModificacion = new Date();

        if (servicio.hasErrors()) {
            respond servicio.errors, view:'edit'
            return
        }

        servicio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Servicio.label', default: 'Servicio'), servicio.id])
                redirect servicio
            }
            '*'{ respond servicio, [status: OK] }
        }
    }

    @Transactional
    def delete(Servicio servicio) {

        if (servicio == null) {
            notFound()
            return
        }
		
		if (!can_delete(servicio)) {
			return
		}
			 
        servicioService.safe_delete(servicio, springSecurityService.principal.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Servicio.label', default: 'Servicio'), servicio.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'servicio.label', default: 'Servicio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	private boolean can_delete(servicio) {
		def can_delete = true
		def messageOther = ''
				
		if(servicioService.tieneCitas(servicio)){
			messageOther += 'El Servicio tiene citas asignadas por su Doctor, por lo que no es posible eliminarlo.'
			can_delete = false
		}
		
		if(servicioService.haveDoctors(servicio)){
			messageOther += 'El Servicio tiene Doctores asignados, por lo que no es posible eliminarlo.'
			can_delete = false
		}
		
		if(!can_delete) {
			request.withFormat {
				form multipartForm {
					flash.message = message(code: messageOther , args: [message(code: 'servicio.label', default: 'servicio'), servicio.id])
					redirect servicio
				}
				'*'{ respond servicio, [status: NOT_FOUND] }
			}
		}

		can_delete
	}
}
