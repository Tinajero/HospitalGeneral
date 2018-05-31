package hojaregistrodiario

import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_USER'])

class HojaRegistroDiarioController {
def HojaRegistroDiarioService
def DoctorService
    def index() { }

    def buscar(){
    	
    	def lista = HojaRegistroDiarioService.list(params)
		
		def cont = 3;
		if(lista[3] != null){
			
			def realPath = request.getSession().getServletContext().getRealPath("/")			
			String filePathString = realPath + "temp_pdf/" + lista[3]; 
			while(cont-- > 0){
				File f = new File(filePathString) 
				print filePathString + " " + cont
				if(f.exists() && !f.isDirectory()){					
					sleep(2000)
					render (view:'resultado', model:['lista':lista])					
				} else {
					sleep(2000)
				}
			}
		}				 
    	render (view:'resultado', model:['lista':lista])    	
    }
	
	
	def tipoCitaCambiada(String tipoCita){
		
		if(tipoCita != null){
			
			def doctores = DoctorService.getDoctoresWhitTipoCita( tipoCita, null );
			def noSelection = ['':'Seleccione un Medico']
					render g.select(id:'cbDoctores', name:'doctorId',
							from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control' , 
							//onchange:'cambioDoctor(this.value);',
							noSelection:noSelection
							)
		}
	}


    def listadoHojas(){
    	
    }

}
