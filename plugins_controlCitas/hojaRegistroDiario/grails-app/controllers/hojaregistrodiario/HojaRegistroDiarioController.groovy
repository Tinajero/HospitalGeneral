package hojaregistrodiario

import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])

class HojaRegistroDiarioController {
def HojaRegistroDiarioService
    def index() { }

    def buscar(){
    	
    	def lista = HojaRegistroDiarioService.list(params)
		
		sleep(2000)
		 
    	render (view:'resultado', model:['lista':lista])
    	
    }


    def listadoHojas(){
    	
    }

}
