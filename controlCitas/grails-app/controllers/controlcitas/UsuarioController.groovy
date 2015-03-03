package controlcitas

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class UsuarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Usuario.list(params), model:[usuarioInstanceCount: Usuario.count()]
    }

    def show(Usuario usuarioInstance) {
        respond usuarioInstance
    }

	
    def create() {
        respond new Usuario(params)
    }

    @Transactional
    def save(Usuario usuarioInstance) {
		
        if (usuarioInstance == null) {
            notFound()
            return
        }

        if (usuarioInstance.hasErrors() ) {
			
            respond usuarioInstance.errors, view:'create'
            return
        }
		println "params.password2 " + params.password2 
		println "params.password " + params.password
		if (params.password2 != params.password){
			usuarioInstance.errors.reject('user.password.doesnotmatch ', 'Las contrase&ntilde;as no coinciden')
			//flash.message = "error en con trase&ntilde;a"
			//usuarioInstance.message = "error en la contraseña"
			//usuarionInstance.errors = "error en contraseña"
			//usuarioInstance.errors.
            println usuarioInstance.hasErrors()
			respond usuarioInstance.errors, view:'create'
			return
		}
		def userRole = SecRole.findOrSaveWhere(authority:'ROLE_USER')
		
		
        usuarioInstance.save flush:true
		SecUserSecRole.create usuarioInstance, userRole, true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuarioInstance.username])
                redirect usuarioInstance
            }
            '*' { respond usuarioInstance, [status: CREATED] }
        }
    }

    def edit(Usuario usuarioInstance) {
        respond usuarioInstance
    }

    @Transactional
    def update(Usuario usuarioInstance) {
        if (usuarioInstance == null) {
            notFound()
            return
        }

        if (usuarioInstance.hasErrors()) {
            respond usuarioInstance.errors, view:'edit'
            return
        }
        usuarioInstance.validate()
        usuarioInstance.hasErrors()
        if (params.password2 != params.password){
            usuarioInstance.errors.reject('user.password.doesnotmatch ', 'Las contrase&ntilde;as no coinciden')
            flash.message = "Las contrasenas no coinciden "
                             
            //usuarioInstance.message = "error en la contraseña"
            //usuarionInstance.errors = "error en contraseña"
            //usuarioInstance.errors.
            println "hay error"
            println usuarioInstance.hasErrors()

            //respond usuarioInstance.errors, view:'edit'
            render view: 'edit' , model:[usuarioInstance:usuarioInstance]
            return
        }
        usuarioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Usuario.label', default: 'Usuario'), usuarioInstance.username])
                redirect usuarioInstance
            }
            '*'{ respond usuarioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Usuario usuarioInstance) {
		println "deleteando"
        if (usuarioInstance == null) {
            notFound()
            return
        }

        usuarioInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Usuario.label', default: 'Usuario'), usuarioInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
