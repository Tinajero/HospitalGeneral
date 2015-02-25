package controlcitas
import grails.plugin.springsecurity.annotation.Secured;

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
@Secured(['IS_AUTHENTICATED_FULLY'])
class ControlarController {
	def springSecurityService
    def index() { 
		def role = springSecurityService.getPrincipal().getAuthorities()
		
		
		role.each {
			
			if (it.toString() == "ROLE_ADMIN") {
				//administrador()
				render (view:"administrador")
				return
			} else {
				//renderizar la pagina principal del usuario
				render (view: "ventanilla")
				return
			}
		}
	
		
	}

}
